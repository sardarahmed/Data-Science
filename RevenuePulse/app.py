from pathlib import Path

import streamlit as st

from core.config import RevenuePulseConfig
from components.shell import apply_theme, render_sidebar
from components.brand import render_topbar
from components.overview import render_overview
from components.data_center import render_data_center
from components.advanced_views import render_advanced_module
from core.demo_data import generate_demo_accounts
from components.exports import render_report_exports


PROJECT_ROOT = Path(__file__).resolve().parent


def initialize_session() -> None:
    defaults = {
        "revenuepulse_theme": "Dark",
        "revenuepulse_active_module": "Overview",
        "revenuepulse_demo_mode": True,
        "revenuepulse_uploaded_data": None,
    }
    for key, value in defaults.items():
        if key not in st.session_state:
            st.session_state[key] = value


def main() -> None:
    config = RevenuePulseConfig()
    initialize_session()

    st.set_page_config(
        page_title=config.product_name,
        page_icon="R",
        layout="wide",
        initial_sidebar_state="expanded",
    )
    apply_theme(PROJECT_ROOT)
    render_sidebar(config)
    render_topbar(config)

    active_module = st.session_state.revenuepulse_active_module
    search = st.session_state.get("revenuepulse_search", "").strip()
    page_subtitle = (
        f"Results for “{search}”" if search else "Commercial SaaS intelligence workspace"
    )
    st.markdown(
        f"""
        <main class="rp-page">
          <div class="rp-page-heading">
            <div>
              <span class="rp-eyebrow">RevenuePulse workspace</span>
              <h1>{active_module}</h1>
            </div>
            <span class="rp-status"><i></i> Demo workspace</span>
          </div>
          <div class="rp-context-bar">
            <span>{page_subtitle}</span>
            <span>Dark workspace</span>
          </div>
        </main>
        """,
        unsafe_allow_html=True,
    )

    if active_module == "Overview":
        render_overview()
        render_data_center()
    elif active_module == "Reports":
        frame = (
            generate_demo_accounts()
            if st.session_state.revenuepulse_demo_mode
            else st.session_state.revenuepulse_uploaded_data
        )
        if frame is None:
            st.info("Upload and map an account dataset to enable exports.")
        else:
            render_report_exports(frame)
    elif active_module in {"Cohorts", "Insights", "Reports", "Funnels", "Accounts", "Segments", "Activity"}:
        frame = (
            generate_demo_accounts()
            if st.session_state.revenuepulse_demo_mode
            else st.session_state.revenuepulse_uploaded_data
        )
        if frame is None:
            st.info("Upload and map an account dataset to enable this analysis.")
        else:
            render_advanced_module(frame, active_module)
    else:
        st.markdown(
            f"""
            <section class="rp-shell-card">
              <span class="rp-card-label">{active_module}</span>
              <h2>Module workspace ready</h2>
              <p>
                Navigation and layout are active. Data calculations for this
                module will be connected in the scheduled analytics milestone.
              </p>
            </section>
            """,
            unsafe_allow_html=True,
        )


if __name__ == "__main__":
    main()
