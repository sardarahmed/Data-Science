from collections import Counter

import pandas as pd

from core.data_contract import REVENUEPULSE_FIELDS


class MappingError(ValueError):
    pass


def apply_mapping(frame: pd.DataFrame, mapping: dict[str, str]) -> pd.DataFrame:
    selected = [source for source in mapping.values() if source]
    duplicates = [column for column, count in Counter(selected).items() if count > 1]
    if duplicates:
        raise MappingError(
            "Each source column can be mapped only once: " + ", ".join(duplicates)
        )

    rename = {
        source: target
        for target, source in mapping.items()
        if source
    }
    result = frame.rename(columns=rename).copy()

    for field in REVENUEPULSE_FIELDS:
        if field.name not in result.columns:
            continue
        if field.field_type.value == "date":
            result[field.name] = pd.to_datetime(result[field.name], errors="coerce")
        elif field.field_type.value == "number":
            result[field.name] = pd.to_numeric(
                result[field.name].astype(str).str.replace(",", "", regex=False),
                errors="coerce",
            )

    required = [
        field.name
        for field in REVENUEPULSE_FIELDS
        if field.required
    ]
    missing = [field for field in required if field not in result.columns]
    if missing:
        raise MappingError(
            "Map these required fields: " + ", ".join(missing)
        )
    invalid_dates = int(result["date"].isna().sum()) if "date" in result else 0
    if invalid_dates:
        raise MappingError(
            f"{invalid_dates} Date value(s) could not be converted to valid dates."
        )
    return result
