import pandas as pd

from core.overview_analytics import calculate_overview_metrics


def test_missing_optional_analytics_columns_are_safe() -> None:
    frame = pd.DataFrame(
        {
            "date": pd.to_datetime(["2026-01-01"]),
            "account_id": ["A1"],
            "account_name": ["Acme"],
        }
    )

    metrics = calculate_overview_metrics(frame)

    assert metrics.total_revenue == 0.0
    assert metrics.active_accounts == 1
