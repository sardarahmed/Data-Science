from pydantic import BaseModel, ConfigDict, Field


class DashboardConfig(BaseModel):
    model_config = ConfigDict(frozen=True)

    product_name: str
    dashboard_id: str
    modules: tuple[str, ...]
    default_currency: str = "USD"
    default_decimals: int = Field(default=2, ge=0, le=6)


class RevenuePulseConfig(DashboardConfig):
    def __init__(self) -> None:
        super().__init__(
            product_name="RevenuePulse",
            dashboard_id="saas-revenue-analytics",
            modules=(
                "Overview",
                "Reports",
                "Funnels",
                "Cohorts",
                "Insights",
                "Users",
                "Accounts",
                "Segments",
                "Activity",
                "Integrations",
                "Automations",
                "Settings",
            ),
        )
