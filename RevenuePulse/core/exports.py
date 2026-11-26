from io import BytesIO

import pandas as pd
from fpdf import FPDF
from fpdf.enums import XPos, YPos
from openpyxl.styles import Font, PatternFill
from openpyxl import Workbook

from core.overview_analytics import calculate_overview_metrics


def excel_report(frame: pd.DataFrame) -> bytes:
    frame = frame.copy()
    metrics = calculate_overview_metrics(frame)
    workbook = Workbook()

    summary = workbook.active
    summary.title = "Executive Summary"
    summary.append(("Metric", "Value"))
    summary.append(("Total Revenue", round(metrics.total_revenue, 2)))
    summary.append(("Active Accounts", metrics.active_accounts))
    summary.append(("Monthly Recurring Revenue", round(metrics.mrr, 2)))
    summary.append(("Conversion Rate", round(metrics.conversion_rate, 2)))
    summary.append(("Churn Rate", round(metrics.churn_rate, 2)))
    summary.append(("NPS Score", metrics.nps_score))
    for cell in summary[1]:
        cell.fill = PatternFill("solid", fgColor="8B7CF6")
        cell.font = Font(color="FFFFFF", bold=True)
    summary.column_dimensions["A"].width = 32
    summary.column_dimensions["B"].width = 18

    records = workbook.create_sheet("Account Records")
    records.append(tuple(frame.columns))
    for row in frame.itertuples(index=False, name=None):
        records.append(row)
    for cell in records[1]:
        cell.fill = PatternFill("solid", fgColor="8B7CF6")
        cell.font = Font(color="FFFFFF", bold=True)
    records.freeze_panes = "A2"
    records.auto_filter.ref = records.dimensions
    for column in records.columns:
        records.column_dimensions[column[0].column_letter].width = 20

    buffer = BytesIO()
    workbook.save(buffer)
    return buffer.getvalue()


def pdf_report(frame: pd.DataFrame) -> bytes:
    metrics = calculate_overview_metrics(frame)
    pdf = FPDF()
    pdf.set_auto_page_break(auto=True, margin=15)
    pdf.add_page()
    pdf.set_fill_color(20, 27, 48)
    pdf.set_text_color(244, 247, 255)
    pdf.set_font("Helvetica", "B", 20)
    pdf.cell(0, 16, "RevenuePulse Executive Report", new_x=XPos.LMARGIN, new_y=YPos.NEXT, fill=True)

    pdf.set_text_color(40, 45, 60)
    pdf.set_font("Helvetica", "", 11)
    pdf.ln(4)
    rows = (
        ("Total Revenue", f"${metrics.total_revenue:,.2f}"),
        ("Active Accounts", f"{metrics.active_accounts:,}"),
        ("Monthly Recurring Revenue", f"${metrics.mrr:,.2f}"),
        ("Conversion Rate", f"{metrics.conversion_rate:.2f}%"),
        ("Churn Rate", f"{metrics.churn_rate:.2f}%"),
        ("NPS Score", str(metrics.nps_score)),
    )
    for label, value in rows:
        pdf.set_fill_color(235, 239, 248)
        pdf.set_font("Helvetica", "B", 10)
        pdf.cell(95, 9, label, border=1, fill=True)
        pdf.set_font("Helvetica", "", 10)
        pdf.cell(95, 9, value, border=1, new_x=XPos.LMARGIN, new_y=YPos.NEXT)

    pdf.ln(8)
    pdf.set_font("Helvetica", "B", 12)
    pdf.cell(0, 8, "Report Basis", new_x=XPos.LMARGIN, new_y=YPos.NEXT)
    pdf.set_font("Helvetica", "", 10)
    pdf.multi_cell(
        0,
        6,
        f"This report contains {len(frame):,} source rows and all values are derived "
        "from the active RevenuePulse dataset.",
    )
    return bytes(pdf.output())
