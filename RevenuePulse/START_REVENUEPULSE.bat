@echo off
setlocal
cd /d "%~dp0"

if not exist ".venv\Scripts\python.exe" (
    echo Setting up RevenuePulse for the first time...
    py -3.11 -m venv .venv
    if errorlevel 1 (
        echo Python 3.11 was not found. Install Python 3.11 or newer and run this file again.
        pause
        exit /b 1
    )
)

".venv\Scripts\python.exe" -m pip install --disable-pip-version-check -r requirements.txt
if errorlevel 1 (
    echo Dependency setup failed. Review the message above.
    pause
    exit /b 1
)

start "" "http://127.0.0.1:8501"
".venv\Scripts\python.exe" -m streamlit run app.py --server.address 127.0.0.1 --server.port 8501
pause
