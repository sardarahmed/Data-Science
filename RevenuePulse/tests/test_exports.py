from io import BytesIO

import pandas as pd
from openpyxl import load_workbook

from core.exports import excel_report, pdf_report


def export_frame() -> pd.DataFrame:
    return pd.DataFrame(
        {
            "date": pd.to_datetime(["2026-01-01", "2026-01-02"]),
            "account_id": ["A1", "A2"],
            "account_name": ["Acme", "Vertex"],
            "revenue": [100.0, 300.0],
            "mrr": [50.0, 150.0],
            "converted": [True, False],
            "churn_probability": [0.10, 0.30],
        }
    )


def test_excel_report_contains_summary_and_records() -> None:
    payload = excel_report(export_frame())
    workbook = load_workbook(BytesIO(payload), read_only=True)

    assert "Executive Summary" in workbook.sheetnames
    assert "Account Records" in workbook.sheetnames
    assert workbook["Executive Summary"]["B2"].value == 400.0


def test_pdf_report_starts_with_valid_pdf_header() -> None:
    payload = pdf_report(export_frame())

    assert payload.startswith(b"%PDF")
    assert len(payload) > 500
