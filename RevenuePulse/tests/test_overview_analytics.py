import pandas as pd

from core.overview_analytics import calculate_overview_metrics, filter_overview


def test_overview_metrics_are_calculated_from_data() -> None:
    frame = pd.DataFrame(
        {
            "date": pd.to_datetime(["2026-01-01", "2026-01-02"]),
            "account_id": ["A", "B"],
            "revenue": [100.0, 300.0],
            "mrr": [50.0, 150.0],
            "converted": [True, False],
            "churn_probability": [0.10, 0.30],
        }
    )

    metrics = calculate_overview_metrics(frame)

    assert metrics.total_revenue == 400.0
    assert metrics.active_accounts == 2
    assert metrics.mrr == 200.0
    assert metrics.conversion_rate == 50.0
    assert metrics.churn_rate == 20.0


def test_overview_filter_applies_dates_and_search() -> None:
    frame = pd.DataFrame(
        {
            "date": pd.to_datetime(["2026-01-01", "2026-02-01"]),
            "account_name": ["Acme Labs", "Vertex Works"],
            "account_id": ["A", "B"],
        }
    )

    filtered = filter_overview(
        frame,
        pd.Timestamp("2026-01-01"),
        pd.Timestamp("2026-01-31"),
        "acme",
    )

    assert len(filtered) == 1
    assert filtered.iloc[0]["account_id"] == "A"
