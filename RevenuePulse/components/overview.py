from datetime import date

import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import streamlit as st

from core.demo_data import generate_demo_accounts, generate_monthly_funnel
from core.overview_analytics import (
    calculate_overview_metrics,
    channel_performance,
    event_breakdown,
    filter_overview,
    product_revenue,
)
from components.kpi_cards import render_kpi_card


TEMPLATE = "plotly_dark"


def render_overview() -> None:
    frame = generate_demo_accounts()
    funnel = generate_monthly_funnel()

    period = st.session_state.get(
        "revenuepulse_date_range_value",
        (date.today().replace(day=1), date.today()),
    )
    if isinstance(period, tuple) and len(period) == 2:
        start, end = period
        start_ts = pd.Timestamp(start)
        end_ts = pd.Timestamp(end)
    else:
        start_ts = frame["date"].min()
        end_ts = frame["date"].max()

    search = st.session_state.get("revenuepulse_search", "").strip()
    filtered = filter_overview(frame, start_ts, end_ts, search)
    if filtered.empty:
        st.warning("No demo records match the selected date range or search.")
        return

    metrics = calculate_overview_metrics(filtered)

    cards = st.columns(6, gap="small")
    card_values = (
        ("Total Revenue", f"${metrics.total_revenue:,.0f}", "↗ 12.8%", "purple"),
        ("Active Accounts", f"{metrics.active_accounts:,}", "↗ 8.4%", "cyan"),
        ("Monthly Recurring Revenue", f"${metrics.mrr:,.0f}", "↗ 5.7%", "purple"),
        ("Conversion Rate", f"{metrics.conversion_rate:.1f}%", "↗ 2.1%", "green"),
        ("Churn Rate", f"{metrics.churn_rate:.1f}%", "↘ 0.8%", "red"),
        ("NPS Score", f"{metrics.nps_score:+d}", "↗ 4 pts", "cyan"),
    )
    for column, (label, value, trend, accent) in zip(cards, card_values):
        with column:
            render_kpi_card(label, value, trend, accent)

    first, second, third = st.columns([1.15, 1.35, 1], gap="medium")
    with first:
        products = product_revenue(filtered)
        fig = px.pie(
            products,
            names="product",
            values="revenue",
            hole=0.58,
            title="Revenue by Product",
            template=TEMPLATE,
            color_discrete_sequence=["#8b7cf6", "#64d7da", "#62c9a8", "#6574d9"],
        )
        fig.update_layout(height=330, margin=dict(l=16, r=16, t=58, b=10), showlegend=True)
        st.plotly_chart(fig, use_container_width=True)

    with second:
        latest = funnel.iloc[-1]
        stages = ["Visitors", "Signups", "Activated", "Paying"]
        values = [int(latest[stage]) for stage in stages]
        fig = go.Figure(go.Funnel(
            y=stages,
            x=values,
            textinfo="value+percent initial",
            marker={"color": ["#8b7cf6", "#7568d9", "#64d7da", "#62c9a8"]},
        ))
        fig.update_layout(
            title="User Acquisition Funnel",
            template=TEMPLATE,
            height=330,
            margin=dict(l=16, r=16, t=58, b=10),
        )
        st.plotly_chart(fig, use_container_width=True)

    with third:
        health = (
            filtered.groupby("status", as_index=False)["account_id"]
            .nunique()
            .rename(columns={"account_id": "accounts"})
        )
        fig = px.bar(
            health,
            x="status",
            y="accounts",
            title="Account Health",
            template=TEMPLATE,
            color="status",
            color_discrete_map={"Healthy": "#62c9a8", "Watch": "#f0ba67", "At Risk": "#ed7377"},
        )
        fig.update_layout(
            height=330,
            margin=dict(l=16, r=16, t=58, b=10),
            showlegend=False,
        )
        st.plotly_chart(fig, use_container_width=True)

    fourth, fifth, sixth = st.columns([1.05, 1.05, 1.2], gap="medium")
    with fourth:
        channels = channel_performance(filtered)
        fig = px.bar(
            channels,
            x="channel",
            y="accounts",
            title="Acquisition Channels",
            template=TEMPLATE,
            color="accounts",
            color_continuous_scale=["#3e4870", "#8b7cf6"],
        )
        fig.update_layout(height=300, margin=dict(l=16, r=16, t=58, b=10), showlegend=False)
        st.plotly_chart(fig, use_container_width=True)

    with fifth:
        events = event_breakdown(filtered)
        fig = px.bar(
            events,
            x="event_count",
            y="event_type",
            orientation="h",
            title="Event Breakdown",
            template=TEMPLATE,
            color_discrete_sequence=["#64d7da"],
        )
        fig.update_layout(height=300, margin=dict(l=16, r=16, t=58, b=10), yaxis={"categoryorder": "total ascending"})
        st.plotly_chart(fig, use_container_width=True)

    with sixth:
        recent = (
            filtered.sort_values(["date", "health_score"], ascending=[False, True])
            .head(7)
            [["account_name", "status", "mrr", "health_score", "date"]]
            .rename(columns={
                "account_name": "Account",
                "status": "Status",
                "mrr": "MRR",
                "health_score": "Health",
                "date": "Last active",
            })
        )
        st.markdown('<div class="rp-table-title">Recent Account Activity</div>', unsafe_allow_html=True)
        st.dataframe(recent, use_container_width=True, hide_index=True, height=250)

    st.markdown('<div class="rp-section-heading">Accounts at Risk</div>', unsafe_allow_html=True)
    risk = (
        filtered[filtered["status"] == "At Risk"]
        .sort_values("health_score")
        .head(10)
        [["account_name", "health_score", "status", "date", "active_users", "users", "mrr", "churn_probability"]]
        .rename(columns={
            "account_name": "Account",
            "health_score": "Health Score",
            "status": "Status",
            "date": "Last Active",
            "active_users": "Active Users",
            "users": "Usage",
            "mrr": "MRR",
            "churn_probability": "Risk Factors",
        })
    )
    if risk.empty:
        risk = pd.DataFrame(columns=["Account", "Health Score", "Status", "Last Active", "Active Users", "Usage", "MRR", "Risk Factors"])
    st.dataframe(risk, use_container_width=True, hide_index=True, height=300)
