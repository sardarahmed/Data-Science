from pathlib import Path

import streamlit as st

from core.config import DashboardConfig


def apply_theme(project_root: Path) -> None:
    css_path = project_root / "assets" / "styles.css"
    st.markdown(f"<style>{css_path.read_text(encoding='utf-8')}</style>", unsafe_allow_html=True)


def render_sidebar(config: DashboardConfig) -> None:
    with st.sidebar:
        st.markdown(
            """
            <div class="rp-brand">
              <div class="rp-logo">
                <svg viewBox="0 0 32 32" aria-hidden="true">
                  <path d="M5 16h5l3-8 6 16 3-8h5" fill="none"
                        stroke="currentColor" stroke-width="3"
                        stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
              </div>
              <div>
                <strong>RevenuePulse</strong>
                <small>Analytics</small>
              </div>
            </div>
            """,
            unsafe_allow_html=True,
        )

        st.markdown('<div class="rp-nav-label">WORKSPACE</div>', unsafe_allow_html=True)
        nav_options = list(config.modules)
        active = st.radio(
            "Navigation",
            nav_options,
            index=nav_options.index(st.session_state.revenuepulse_active_module),
            label_visibility="collapsed",
        )
        st.session_state.revenuepulse_active_module = active

        st.markdown(
            """
            <div class="rp-sidebar-footer">
              <div class="rp-mini-logo">RP</div>
              <div>
                <strong>RevenuePulse</strong>
                <small>Commercial edition</small>
              </div>
            </div>
            """,
            unsafe_allow_html=True,
        )
