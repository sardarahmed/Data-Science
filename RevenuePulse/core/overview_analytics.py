from dataclasses import dataclass

import pandas as pd


@dataclass(frozen=True)
class OverviewMetrics:
    total_revenue: float
    active_accounts: int
    mrr: float
    conversion_rate: float
    churn_rate: float
    nps_score: int


def prepare_demo_frame(frame: pd.DataFrame) -> pd.DataFrame:
    result = frame.copy()
    result["date"] = pd.to_datetime(result["date"], errors="coerce")
    for column in ("revenue", "mrr", "users", "active_users", "health_score", "churn_probability"):
        if column in result.columns:
            result[column] = pd.to_numeric(result[column], errors="coerce").fillna(0)
    if "converted" in result.columns:
        result["converted"] = result["converted"].fillna(False).astype(bool)
    return result


def filter_overview(
    frame: pd.DataFrame,
    start: pd.Timestamp,
    end: pd.Timestamp,
    search: str = "",
) -> pd.DataFrame:
    result = prepare_demo_frame(frame)
    result = result[
        (result["date"] >= start)
        & (result["date"] <= end)
    ].copy()
    if search:
        searchable = result.select_dtypes(include=["object", "string"]).apply(
            lambda column: column.astype(str).str.contains(search, case=False, regex=False)
        )
        if not searchable.empty:
            result = result[searchable.any(axis=1)]
    return result


def calculate_overview_metrics(frame: pd.DataFrame) -> OverviewMetrics:
    result = prepare_demo_frame(frame)
    total_revenue = float(result["revenue"].sum()) if "revenue" in result else 0.0
    active_accounts = int(result["account_id"].nunique()) if "account_id" in result else 0
    mrr = float(result["mrr"].sum()) if "mrr" in result else 0.0
    conversion_rate = float(result["converted"].mean() * 100) if "converted" in result and len(result) else 0.0
    churn_rate = float(result["churn_probability"].mean() * 100) if "churn_probability" in result and len(result) else 0.0

    if "nps_score" in result:
        nps_score = int(result["nps_score"].mean())
    else:
        if "churn_probability" in result and len(result):
            nps_proxy = 72 - result["churn_probability"].mean() * 42
            nps_score = int(round(nps_proxy))
        else:
            nps_score = 72

    return OverviewMetrics(
        total_revenue=total_revenue,
        active_accounts=active_accounts,
        mrr=mrr,
        conversion_rate=conversion_rate,
        churn_rate=churn_rate,
        nps_score=nps_score,
    )


def product_revenue(frame: pd.DataFrame) -> pd.DataFrame:
    result = prepare_demo_frame(frame)
    if "product" not in result or "revenue" not in result:
        return pd.DataFrame(columns=["product", "revenue"])
    return (
        result.groupby("product", as_index=False)["revenue"]
        .sum()
        .sort_values("revenue", ascending=False)
    )


def channel_performance(frame: pd.DataFrame) -> pd.DataFrame:
    result = prepare_demo_frame(frame)
    if "channel" not in result or "account_id" not in result:
        return pd.DataFrame(columns=["channel", "accounts"])
    return (
        result.groupby("channel", as_index=False)["account_id"]
        .nunique()
        .rename(columns={"account_id": "accounts"})
        .sort_values("accounts", ascending=False)
    )


def event_breakdown(frame: pd.DataFrame) -> pd.DataFrame:
    result = prepare_demo_frame(frame)
    if "event_type" not in result or "event_count" not in result:
        return pd.DataFrame(columns=["event_type", "event_count"])
    return (
        result.groupby("event_type", as_index=False)["event_count"]
        .sum()
        .sort_values("event_count", ascending=False)
    )
