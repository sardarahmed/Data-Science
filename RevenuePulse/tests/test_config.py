from core.config import RevenuePulseConfig


def test_config_identity_and_navigation() -> None:
    config = RevenuePulseConfig()

    assert config.dashboard_id == "saas-revenue-analytics"
    assert config.product_name == "RevenuePulse"
    assert len(config.modules) == 12
    assert config.modules[0] == "Overview"
    assert config.modules[-1] == "Settings"
