from datetime import date, timedelta

import streamlit as st


def render_topbar(config) -> None:
    active = st.session_state.revenuepulse_active_module

    st.markdown(
        f"""
        <header class="rp-topbar">
          <div class="rp-breadcrumb">
            <span>Workspace</span>
            <b>/</b>
            <strong>{active}</strong>
          </div>
          <div class="rp-user">
            <span class="rp-live-dot"></span>
            <div>
              <strong>Pulse Admin</strong>
              <small>Demo workspace</small>
            </div>
            <div class="rp-avatar">PA</div>
          </div>
        </header>
        """,
        unsafe_allow_html=True,
    )

    search_col, date_col, source_col, export_col = st.columns(
        [2.1, 1.8, 1.2, 0.7],
        gap="medium",
        vertical_alignment="bottom",
    )
    with search_col:
        st.text_input(
            "Search",
            key="revenuepulse_search",
            placeholder="Search accounts or reports...",
            label_visibility="collapsed",
        )
    with date_col:
        today = date.today()
        period = st.date_input(
            "Date range",
            value=(today - timedelta(days=29), today),
            max_value=today,
            key="revenuepulse_date_range",
        )
        if isinstance(period, tuple) and len(period) == 2:
            st.session_state.revenuepulse_date_range_value = period
    with source_col:
        source = st.selectbox(
            "Data source",
            options=["Demo data"],
            index=0,
            label_visibility="collapsed",
            key="revenuepulse_data_source",
        )
        st.session_state.revenuepulse_demo_mode = source == "Demo data"
    with export_col:
        export_payload = b"RevenuePulse\nUse the Reports page to export the active dataset.\n"
        st.download_button(
            "Export",
            data=export_payload,
            file_name="revenuepulse_dashboard_config.json",
            mime="application/json",
            use_container_width=True,
        )
