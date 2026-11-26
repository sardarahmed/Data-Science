import streamlit as st


def render_kpi_card(label: str, value: str, trend: str, accent: str = "purple") -> None:
    accent_class = f"rp-accent-{accent}"
    st.markdown(
        f"""
        <article class="rp-kpi-card {accent_class}">
          <div class="rp-kpi-top">
            <span>{label}</span>
            <button type="button" aria-label="{label} options">•••</button>
          </div>
          <div class="rp-kpi-value">{value}</div>
          <div class="rp-kpi-trend">{trend}</div>
        </article>
        """,
        unsafe_allow_html=True,
    )
