import pandas as pd
import streamlit as st

from core.exports import excel_report, pdf_report


def render_report_exports(frame: pd.DataFrame) -> None:
    st.markdown('<div class="rp-section-heading">Reports &amp; exports</div>', unsafe_allow_html=True)
    excel_col, pdf_col = st.columns(2, gap="medium")
    with excel_col:
        st.download_button(
            "Export executive report (Excel)",
            data=excel_report(frame),
            file_name="revenuepulse_executive_report.xlsx",
            mime="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            use_container_width=True,
        )
    with pdf_col:
        st.download_button(
            "Export executive report (PDF)",
            data=pdf_report(frame),
            file_name="revenuepulse_executive_report.pdf",
            mime="application/pdf",
            use_container_width=True,
        )
