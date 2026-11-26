import pandas as pd
import plotly.graph_objects as go
import streamlit as st

from core.advanced_analytics import (
    account_health,
    cohort_retention,
    detect_revenue_anomalies,
    forecast_revenue,
)


def render_advanced_module(frame: pd.DataFrame, module: str, dark_theme: bool = True) -> None:
    st.markdown(f'<div class="rp-section-heading">{module}</div>', unsafe_allow_html=True)
    template = "plotly_dark" if dark_theme else "plotly"

    if module == "Insights":
        anomaly_history = detect_revenue_anomalies(frame)
        anomaly_count = int(anomaly_history["is_anomaly"].sum())
        health = account_health(frame)
        at_risk = int((health["risk_tier"] == "At Risk").sum())
        health_mean = float(health["health_score"].mean())

        kpi_one, kpi_two, kpi_three = st.columns(3)
        kpi_one.metric("Revenue anomalies", f"{anomaly_count}")
        kpi_two.metric("At-risk account rows", f"{at_risk:,}")
        kpi_three.metric("Average health", f"{health_mean:.1f}")

        insight_col, table_col = st.columns([1, 2], gap="medium")
        with insight_col:
            st.markdown(
                f"""
                <div class="rp-insight-card">
                  <span>Rule-based insight</span>
                  <h3>{at_risk:,} account records are at risk</h3>
                  <p>
                    Health scores are derived from usage and available account
                    signals; no AI-generated prediction is presented as fact.
                  </p>
                </div>
                """,
                unsafe_allow_html=True,
            )
        with table_col:
            st.markdown('<div class="rp-table-title">Anomaly timeline</div>', unsafe_allow_html=True)
            st.dataframe(
                anomaly_history,
                use_container_width=True,
                hide_index=True,
                height=300,
            )
        st.download_button(
            "Download anomaly report",
            data=anomaly_history.to_csv(index=False).encode("utf-8"),
            file_name="revenuepulse_anomaly_report.csv",
            mime="text/csv",
        )
        return

    if module == "Cohorts":
        cohorts = cohort_retention(frame)
        if cohorts.empty:
            st.warning("Cohort analysis requires account_id and date columns.")
            return
        fig = go.Figure(
            go.Heatmap(
                z=cohorts.values,
                x=[f"Period {column}" for column in cohorts.columns],
                y=[str(index) for index in cohorts.index],
                colorscale=[
                    [0, "#171f35"],
                    [0.5, "#5f64a8"],
                    [1, "#64d7da"],
                ],
                text=[[f"{value:.0f}%" for value in row] for row in cohorts.values],
                texttemplate="%{text}",
                zmin=0,
                zmax=100,
            )
        )
        fig.update_layout(
            title="Account retention cohorts",
            template=template,
            height=430,
            margin=dict(l=20, r=20, t=55, b=20),
        )
        st.plotly_chart(fig, use_container_width=True)
        st.download_button(
            "Download cohort table",
            data=cohorts.to_csv().encode("utf-8"),
            file_name="revenuepulse_cohorts.csv",
            mime="text/csv",
        )
        return

    if module in ("Overview", "Reports", "Funnels", "Accounts", "Segments", "Activity"):
        try:
            forecast = forecast_revenue(frame, horizon=6)
        except ValueError as exc:
            st.warning(str(exc))
            return
        fig = go.Figure()
        fig.add_trace(go.Bar(
            x=forecast.history["month"],
            y=forecast.history["revenue"],
            name="Actual revenue",
            marker_color="#8b7cf6",
        ))
        fig.add_trace(go.Scatter(
            x=forecast.history["month"],
            y=forecast.history["trend_revenue"],
            name="Trend",
            line={"color": "#62c9a8", "width": 3},
        ))
        fig.add_trace(go.Scatter(
            x=forecast.forecast["month"],
            y=forecast.forecast["forecast_revenue"],
            name="Forecast",
            line={"color": "#64d7da", "width": 3, "dash": "dash"},
        ))
        fig.add_trace(go.Scatter(
            x=pd.concat([forecast.forecast["month"], forecast.forecast["month"][::-1]]),
            y=pd.concat([forecast.forecast["upper_95"], forecast.forecast["lower_95"][::-1]]),
            fill="toself",
            fillcolor="rgba(100,215,218,0.14)",
            line={"color": "rgba(100,215,218,0)"},
            name="95% uncertainty",
            hoverinfo="skip",
        ))
        fig.update_layout(
            title=f"{module} revenue forecast",
            template=template,
            height=420,
            margin=dict(l=20, r=20, t=55, b=20),
        )
        st.plotly_chart(fig, use_container_width=True)
        st.download_button(
            "Download forecast",
            data=forecast.forecast.to_csv(index=False).encode("utf-8"),
            file_name="revenuepulse_forecast.csv",
            mime="text/csv",
        )
        return

    st.info(f"{module} analytics are ready for connection in the next product milestone.")
