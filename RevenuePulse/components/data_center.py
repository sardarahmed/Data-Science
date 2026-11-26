import streamlit as st

from core.data_contract import REVENUEPULSE_FIELDS
from core.data_loader import DataLoadError, load_upload
from core.data_mapping import MappingError, apply_mapping
from core.data_quality import inspect_quality
from core.example_data import data_dictionary_csv, example_csv, example_excel


def render_data_center() -> None:
    st.markdown('<div class="rp-section-heading">Data &amp; imports</div>', unsafe_allow_html=True)

    csv_col, excel_col, dictionary_col = st.columns(3, gap="medium")
    with csv_col:
        st.download_button(
            "Example CSV",
            data=example_csv(),
            file_name="revenuepulse_example.csv",
            mime="text/csv",
            use_container_width=True,
        )
    with excel_col:
        st.download_button(
            "Example Excel",
            data=example_excel(),
            file_name="revenuepulse_example.xlsx",
            mime="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            use_container_width=True,
        )
    with dictionary_col:
        st.download_button(
            "Data dictionary",
            data=data_dictionary_csv(),
            file_name="revenuepulse_data_dictionary.csv",
            mime="text/csv",
            use_container_width=True,
        )

    uploaded = st.file_uploader(
        "Upload CSV or Excel",
        type=["csv", "xlsx", "xls"],
        help="Maximum file size: 25 MB",
    )
    if uploaded is None:
        st.caption("No uploaded data is active. The Overview uses the fictional demo dataset.")
        return

    try:
        frame = load_upload(uploaded, uploaded.name, uploaded.size)
    except DataLoadError as exc:
        st.error(str(exc))
        return

    quality = inspect_quality(frame)
    row_col, duplicate_col, missing_col = st.columns(3)
    row_col.metric("Rows", f"{quality.rows:,}")
    duplicate_col.metric("Duplicate rows", f"{quality.duplicates:,}")
    missing_col.metric("Missing columns", f"{quality.empty_column_count:,}")

    st.markdown('<div class="rp-table-title">Map source columns</div>', unsafe_allow_html=True)
    mapping: dict[str, str] = {}
    options = [""] + [str(column) for column in frame.columns]
    for field in REVENUEPULSE_FIELDS:
        default = field.name if field.name in frame.columns else ""
        mapping[field.name] = st.selectbox(
            f"{field.label}{' *' if field.required else ''}",
            options=options,
            index=options.index(default) if default in options else 0,
            key=f"rp_map_{field.name}",
        )

    if st.button("Validate and activate data", type="primary"):
        try:
            mapped = apply_mapping(frame, mapping)
        except MappingError as exc:
            st.error(str(exc))
        else:
            st.session_state.revenuepulse_uploaded_data = mapped
            st.session_state.revenuepulse_demo_mode = False
            st.success(
                f"{len(mapped):,} rows are active for this browser session."
            )
            st.dataframe(mapped.head(100), use_container_width=True, hide_index=True)
