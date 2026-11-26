from io import BytesIO
from typing import BinaryIO

import pandas as pd


MAX_UPLOAD_BYTES = 25 * 1024 * 1024
ALLOWED_SUFFIXES = {".csv", ".xlsx", ".xls"}


class DataLoadError(ValueError):
    pass


def validate_upload(filename: str, size_bytes: int) -> str:
    suffix = "." + filename.lower().rsplit(".", 1)[-1] if "." in filename else ""
    if suffix not in ALLOWED_SUFFIXES:
        raise DataLoadError("Unsupported file type. Upload a CSV or Excel workbook.")
    if size_bytes <= 0:
        raise DataLoadError("The uploaded file is empty.")
    if size_bytes > MAX_UPLOAD_BYTES:
        raise DataLoadError("The uploaded file exceeds the 25 MB limit.")
    return suffix


def load_upload(file: BinaryIO, filename: str, size_bytes: int) -> pd.DataFrame:
    suffix = validate_upload(filename, size_bytes)
    try:
        payload = BytesIO(file.read())
        if suffix == ".csv":
            frame = pd.read_csv(payload)
        elif suffix == ".xlsx":
            frame = pd.read_excel(payload, engine="openpyxl")
        else:
            frame = pd.read_excel(payload)
    except Exception as exc:
        raise DataLoadError(
            f"Could not read '{filename}'. Confirm that it is a valid CSV or Excel file."
        ) from exc
    if frame.empty:
        raise DataLoadError("The uploaded file contains no data rows.")
    return frame
