import pandas as pd
import pytest

from core.advanced_analytics import (
    account_health,
    cohort_retention,
    detect_revenue_anomalies,
    forecast_revenue,
)


def test_forecast_returns_uncertainty_bounds() -> None:
    frame = pd.DataFrame(
        {
            "date": pd.to_datetime(
                [f"2026-{month:02d}-15" for month in range(1, 13)]
            )
        }
    )
    frame["revenue"] = [100.0 * month for month in range(1, 13)]

    result = forecast_revenue(frame, horizon=3)

    assert len(result.forecast) == 3
    assert (result.forecast["lower_95"] <= result.forecast["forecast_revenue"]).all()
    assert (result.forecast["forecast_revenue"] <= result.forecast["upper_95"]).all()


def test_account_health_derives_risk_tiers() -> None:
    frame = pd.DataFrame(
        {
            "health_score": [90, 65, 40],
            "churn_probability": [0.05, 0.25, 0.70],
        }
    )

    health = account_health(frame)

    assert health["risk_tier"].tolist() == ["Healthy", "Watch", "At Risk"]


def test_anomaly_detection_returns_boolean_result() -> None:
    frame = pd.DataFrame(
        {
            "date": pd.to_datetime([f"2026-{month:02d}-15" for month in range(1, 7)]),
            "revenue": [100, 110, 105, 120, 115, 500],
        }
    )

    anomalies = detect_revenue_anomalies(frame, threshold=1.5)

    assert anomalies["is_anomaly"].dtype == bool


def test_cohort_retention_requires_dates_and_accounts() -> None:
    frame = pd.DataFrame(
        {
            "date": pd.to_datetime(["2026-01-10", "2026-02-10"]),
            "account_id": ["A", "A"],
        }
    )

    cohorts = cohort_retention(frame)

    assert cohorts.loc[pd.Period("2026-01", freq="M"), 0] == 100.0
