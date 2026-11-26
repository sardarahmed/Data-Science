import pandas as pd
import pytest

from core.data_mapping import MappingError, apply_mapping


def test_mapping_converts_dates_and_numbers() -> None:
    frame = pd.DataFrame(
        {
            "Account": ["Acme"],
            "Order Date": ["2026-01-15"],
            "Account ID": ["A001"],
            "Revenue": ["1,250"],
        }
    )
    mapped = apply_mapping(
        frame,
        {
            "date": "Order Date",
            "account_id": "Account ID",
            "account_name": "Account",
            "revenue": "Revenue",
        },
    )

    assert pd.api.types.is_datetime64_any_dtype(mapped["date"])
    assert mapped["revenue"].iloc[0] == 1250.0


def test_mapping_requires_account_fields() -> None:
    frame = pd.DataFrame({"Date": ["2026-01-15"], "Account": ["Acme"]})

    with pytest.raises(MappingError, match="required fields"):
        apply_mapping(
            frame,
            {"date": "Date", "account_id": "", "account_name": "Account"},
        )
