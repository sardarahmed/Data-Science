from io import BytesIO

import pytest

from core.data_loader import DataLoadError, load_upload


def test_load_csv() -> None:
    frame = load_upload(
        BytesIO(b"date,account_id,account_name,revenue\n2026-01-01,A,Acme,100"),
        "accounts.csv",
        58,
    )

    assert len(frame) == 1
    assert "account_id" in frame.columns


def test_reject_empty_file() -> None:
    with pytest.raises(DataLoadError, match="empty"):
        load_upload(BytesIO(b""), "accounts.csv", 0)


def test_reject_unsupported_file() -> None:
    with pytest.raises(DataLoadError, match="Unsupported"):
        load_upload(BytesIO(b"text"), "accounts.txt", 4)
