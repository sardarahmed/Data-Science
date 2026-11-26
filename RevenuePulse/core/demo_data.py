from datetime import date

import numpy as np
import pandas as pd


PRODUCTS = ("Pulse Analytics", "Revenue Intelligence", "Forecasting", "Integrations")
CHANNELS = ("Organic", "Paid Search", "Content", "Partners", "Referral")
PLANS = ("Starter", "Growth", "Scale", "Enterprise")
STATUSES = ("Healthy", "Watch", "At Risk")


def generate_demo_accounts(start: date = date(2025, 1, 1), months: int = 18) -> pd.DataFrame:
    if months < 1:
        raise ValueError("months must be at least 1")

    rng = np.random.default_rng(20261121)
    month_starts = pd.date_range(start=start, periods=months, freq="MS")
    rows: list[dict[str, object]] = []
    account_number = 1

    for month_index, month in enumerate(month_starts):
        for account_index in range(18 + month_index // 3):
            account_id = f"ACC-{(account_number % 180):04d}"
            plan_index = int(rng.integers(0, len(PLANS)))
            plan = PLANS[plan_index]
            product = PRODUCTS[int(rng.integers(0, len(PRODUCTS)))]
            channel = CHANNELS[int(rng.integers(0, len(CHANNELS)))]
            plan_base = (320, 780, 1850, 5200)[plan_index]
            growth = 1 + month_index * 0.018
            mrr = round(plan_base * growth * rng.uniform(0.92, 1.10), 2)
            users = int(rng.integers(8, 180))
            active_users = int(users * rng.uniform(0.42, 0.94))
            usage_ratio = active_users / users
            health_score = int(rng.integers(44, 99))
            health_score = min(100, int(health_score * (0.75 + usage_ratio * 0.25)))
            status = "Healthy" if health_score >= 76 else "Watch" if health_score >= 58 else "At Risk"
            churn_probability = min(
                0.95,
                max(0.02, (100 - health_score) / 100 * 0.52 + (0.15 if status == "At Risk" else 0)),
            )
            converted = bool(rng.random() < 0.24 + month_index * 0.002)
            event_count = int(rng.integers(20, 650))
            event_type = rng.choice(("viewed_report", "exported_report", "created_segment", "invited_user"))
            revenue = mrr if rng.random() > 0.12 else 0.0

            rows.append(
                {
                    "date": pd.Timestamp(year=month.year, month=month.month, day=int(rng.integers(1, 28))),
                    "month": month.to_period("M").to_timestamp(),
                    "account_id": account_id,
                    "account_name": f"{('Acme', 'Northstar', 'Cobalt', 'Lumio', 'Vertex')[account_index % 5]} "
                                    f"{('Labs', 'Systems', 'Group', 'Works', 'Media')[account_index % 5]}",
                    "plan": plan,
                    "product": product,
                    "channel": channel,
                    "mrr": mrr,
                    "revenue": revenue,
                    "users": users,
                    "active_users": active_users,
                    "health_score": health_score,
                    "status": status,
                    "churn_probability": round(churn_probability, 4),
                    "converted": converted,
                    "event_count": event_count,
                    "event_type": str(event_type),
                }
            )
            account_number += 1

    return pd.DataFrame(rows)


def generate_monthly_funnel(months: int = 18) -> pd.DataFrame:
    rng = np.random.default_rng(20261121)
    rows: list[dict[str, object]] = []
    for month_index in range(months):
        visitors = int(rng.integers(9800, 18000))
        signups = int(visitors * rng.uniform(0.08, 0.14))
        activated = int(signups * rng.uniform(0.54, 0.72))
        paying = int(activated * rng.uniform(0.38, 0.58))
        month = pd.Timestamp(year=2025 + month_index // 12, month=month_index % 12 + 1, day=1)
        rows.append(
            {
                "month": month,
                "Visitors": visitors,
                "Signups": signups,
                "Activated": activated,
                "Paying": paying,
            }
        )
    return pd.DataFrame(rows)


def frame_to_csv(frame: pd.DataFrame) -> bytes:
    return frame.to_csv(index=False).encode("utf-8")
