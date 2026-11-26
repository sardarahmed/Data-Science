from pathlib import Path

from core.demo_data import generate_demo_accounts
from core.exports import excel_report, pdf_report
from core.overview_analytics import calculate_overview_metrics


def main() -> None:
    root = Path(__file__).resolve().parent
    frame = generate_demo_accounts()
    metrics = calculate_overview_metrics(frame)

    excel_payload = excel_report(frame)
    pdf_payload = pdf_report(frame)
    output = root / "data"

    (output / "smoke_report.xlsx").write_bytes(excel_payload)
    (output / "smoke_report.pdf").write_bytes(pdf_payload)

    assert len(frame) > 0
    assert metrics.active_accounts > 0
    assert excel_payload[:2] == b"PK"
    assert pdf_payload[:4] == b"%PDF"
    print(
        f"Smoke test passed: {len(frame)} rows, "
        f"{metrics.active_accounts} active accounts"
    )


if __name__ == "__main__":
    main()
