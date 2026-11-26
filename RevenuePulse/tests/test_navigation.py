from core.config import RevenuePulseConfig


def test_navigation_contains_every_required_module() -> None:
    modules = RevenuePulseConfig().modules
    expected = (
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
    )

    assert modules == expected
