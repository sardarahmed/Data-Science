from dataclasses import dataclass

import pandas as pd


@dataclass(frozen=True)
class QualityReport:
    rows: int
    duplicates: int
    missing_by_column: dict[str, int]
    empty_column_count: int


def inspect_quality(frame: pd.DataFrame) -> QualityReport:
    missing = frame.isna().sum()
    missing_by_column = {
        str(column): int(count)
        for column, count in missing.items()
        if int(count) > 0
    }
    empty_column_count = sum(int(count) == len(frame) for count in missing)
    return QualityReport(
        rows=len(frame),
        duplicates=int(frame.duplicated().sum()),
        missing_by_column=missing_by_column,
        empty_column_count=int(empty_column_count),
    )
