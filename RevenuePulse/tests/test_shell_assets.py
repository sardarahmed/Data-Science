from pathlib import Path


def test_milestone_shell_files_exist() -> None:
    root = Path(__file__).resolve().parents[1]

    assert (root / "app.py").is_file()
    assert (root / "assets" / "styles.css").is_file()
    assert (root / "assets" / "revenuepulse-logo.svg").is_file()
    assert (root / "README.md").is_file()
    assert (root / "START_REVENUEPULSE.bat").is_file()
    assert (root / "QUICK_START.txt").is_file()
