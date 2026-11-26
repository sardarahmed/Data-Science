from dataclasses import dataclass

import numpy as np
import pandas as pd


@dataclass(frozen=True)
class ForecastResult:
    history: pd.DataFrame
    forecast: pd.DataFrame
    slope: float
    residual_std: float


def monthly_revenue(frame: pd.DataFrame) -> pd.DataFrame:
    result = frame.copy()
    result["date"] = pd.to_datetime(result["date"], errors="coerce")
    result["revenue"] = pd.to_numeric(result["revenue"], errors="coerce").fillna(0)
    result["month"] = result["date"].dt.to_period("M").dt.to_timestamp()
    return result.groupby("month", as_index=False)["revenue"].sum()


def forecast_revenue(frame: pd.DataFrame, horizon: int = 6) -> ForecastResult:
    if horizon < 1:
        raise ValueError("Forecast horizon must be at least 1")
    history = monthly_revenue(frame)
    if len(history) < 2:
        raise ValueError("Forecasting requires at least 2 complete months of data.")

    x = np.arange(len(history), dtype=float)
    y = history["revenue"].to_numpy(dtype=float)
    slope, intercept = np.polyfit(x, y, 1)
    fitted = slope * x + intercept
    residual_std = float(np.std(y - fitted, ddof=1)) if len(y) > 1 else 0.0
    future_x = np.arange(len(history), len(history) + horizon, dtype=float)
    forecast_values = np.maximum(slope * future_x + intercept, 0)

    uncertainty = 1.96 * residual_std
    future_months = pd.date_range(
        start=history["month"].iloc[-1] + pd.offsets.MonthBegin(1),
        periods=horizon,
        freq="MS",
    )
    forecast = pd.DataFrame(
        {
            "month": future_months,
            "forecast_revenue": forecast_values,
            "lower_95": np.maximum(forecast_values - uncertainty, 0),
            "upper_95": forecast_values + uncertainty,
        }
    )
    history["trend_revenue"] = fitted
    return ForecastResult(
        history=history,
        forecast=forecast,
        slope=float(slope),
        residual_std=residual_std,
    )


def account_health(frame: pd.DataFrame) -> pd.DataFrame:
    result = frame.copy()
    if "date" in result.columns:
        result["date"] = pd.to_datetime(result["date"], errors="coerce")
    for column in ("health_score", "mrr", "users", "active_users", "churn_probability"):
        if column in result.columns:
            result[column] = pd.to_numeric(result[column], errors="coerce").fillna(0)

    if "health_score" not in result:
        usage = (
            result["active_users"] / result["users"].replace(0, np.nan)
        ).fillna(0)
        result["health_score"] = (usage * 100).clip(0, 100).round().astype(int)
    else:
        result["health_score"] = result["health_score"].clip(0, 100)

    if "churn_probability" not in result:
        result["churn_probability"] = ((100 - result["health_score"]) / 100).clip(0, 1)

    result["risk_tier"] = pd.cut(
        result["health_score"],
        bins=[-1, 57, 75, 100],
        labels=["At Risk", "Watch", "Healthy"],
    ).astype(str)
    return result


def detect_revenue_anomalies(frame: pd.DataFrame, threshold: float = 1.5) -> pd.DataFrame:
    if threshold <= 0:
        raise ValueError("Anomaly threshold must be positive.")
    history = monthly_revenue(frame)
    if len(history) < 4:
        return history.assign(is_anomaly=False, anomaly_score=0.0)

    values = history["revenue"]
    q1 = float(values.quantile(0.25))
    q3 = float(values.quantile(0.75))
    iqr = q3 - q1
    if iqr > 0:
        lower = q1 - threshold * iqr
        upper = q3 + threshold * iqr
        midpoint = (lower + upper) / 2
        scale = max((upper - lower) / 2, 1e-9)
    else:
        median = float(values.median())
        mad = float(np.median(np.abs(values - median)))
        scale = max(1.4826 * mad, 1e-9)
        lower = median - threshold * scale
        upper = median + threshold * scale
        midpoint = median

    history["is_anomaly"] = (values < lower) | (values > upper)
    history["anomaly_score"] = (values - midpoint) / scale
    return history


def cohort_retention(frame: pd.DataFrame) -> pd.DataFrame:
    result = frame.copy()
    result["date"] = pd.to_datetime(result["date"], errors="coerce")
    if "account_id" not in result.columns or "date" not in result.columns:
        return pd.DataFrame()

    result["activity_month"] = result["date"].dt.to_period("M")
    result["cohort_month"] = result.groupby("account_id")["date"].transform(
        lambda values: values.min().to_period("M")
    )
    result["period_number"] = (
        (result["activity_month"].dt.year - result["cohort_month"].dt.year) * 12
        + result["activity_month"].dt.month
        - result["cohort_month"].dt.month
    )
    cohort = (
        result.groupby(["cohort_month", "period_number"])["account_id"]
        .nunique()
        .reset_index(name="active_accounts")
    )
    cohort_sizes = (
        cohort[cohort["period_number"] == 0]
        .set_index("cohort_month")["active_accounts"]
    )
    cohort["retention"] = cohort.apply(
        lambda row: row["active_accounts"] / cohort_sizes[row["cohort_month"]] * 100,
        axis=1,
    )
    return (
        cohort.pivot(index="cohort_month", columns="period_number", values="retention")
        .sort_index()
        .fillna(0)
    )
