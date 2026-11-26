from io import BytesIO

import pandas as pd
from openpyxl.styles import Font, PatternFill
from openpyxl import Workbook

from core.demo_data import frame_to_csv, generate_demo_accounts


DATA_DICTIONARY = (
    ("date", "Yes", "Date", "YYYY-MM-DD"),
    ("account_id", "Yes", "Text", "Unique account identifier"),
    ("account_name", "Yes", "Text", "Account or customer name"),
    ("plan", "No", "Text", "Starter, Growth, Scale or Enterprise"),
    ("product", "No", "Text", "Purchased product or service"),
    ("channel", "No", "Text", "Acquisition source"),
    ("mrr", "No", "Number", "Monthly recurring revenue"),
    ("revenue", "No", "Number", "Revenue for the row"),
    ("users", "No", "Number", "Total licensed users"),
    ("active_users", "No", "Number", "Active users"),
    ("status", "No", "Text", "Healthy, Watch or At Risk"),
)


def example_csv() -> bytes:
    return frame_to_csv(generate_demo_accounts(months=12))


def example_excel() -> bytes:
    frame = generate_demo_accounts(months=12)
    workbook = Workbook()
    sales_sheet = workbook.active
    sales_sheet.title = "SaaS Accounts"
    for column_name in frame.columns:
        sales_sheet.append(frame.columns.tolist())
        break
    for row in frame.itertuples(index=False, name=None):
        sales_sheet.append(row)
    for cell in sales_sheet[1]:
        cell.fill = PatternFill("solid", fgColor="8B7CF6")
        cell.font = Font(color="FFFFFF", bold=True)
    for column in sales_sheet.columns:
        sales_sheet.column_dimensions[column[0].column_letter].width = 22
    sales_sheet.freeze_panes = "A2"
    sales_sheet.auto_filter.ref = sales_sheet.dimensions

    dictionary_sheet = workbook.create_sheet("Data Dictionary")
    dictionary_sheet.append(("Field", "Required", "Type", "Description"))
    for row in DATA_DICTIONARY:
        dictionary_sheet.append(row)
    for column in dictionary_sheet.columns:
        dictionary_sheet.column_dimensions[column[0].column_letter].width = 24

    buffer = BytesIO()
    workbook.save(buffer)
    return buffer.getvalue()


def data_dictionary_csv() -> bytes:
    return pd.DataFrame(
        DATA_DICTIONARY,
        columns=("Field", "Required", "Type", "Description"),
    ).to_csv(index=False).encode("utf-8")
