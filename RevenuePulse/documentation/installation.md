# RevenuePulse installation guide

## Windows requirements

- Windows 10 or 11
- Python 3.11 or newer
- Microsoft Edge or another modern browser

## Install

1. Extract the RevenuePulse folder.
2. Open PowerShell in the folder.
3. Run:

```powershell
py -3.11 -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
streamlit run app.py
```

4. Keep the terminal open.
5. Open the local address printed by Streamlit.

## Stop the application

Press `Ctrl+C` in the PowerShell window.

## Easy Windows start

Double-click `START_REVENUEPULSE.bat`. On first use, the launcher creates
`.venv`, installs `requirements.txt`, opens the browser, and starts
Streamlit. Keep the terminal window open while the dashboard is in use.
