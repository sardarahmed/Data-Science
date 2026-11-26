# RevenuePulse

RevenuePulse is a commercial-ready SaaS analytics dashboard built with
Python and Streamlit. This repository starts with an isolated, tested
application shell; analytics and integrations will be added milestone by
milestone.

## Milestone 7

Milestone 7 provides:

- One-click Windows launcher
- Non-technical quick-start instructions
- A sample commercial product license
- A distributor release checklist
- A local smoke-test script
- Validated example data and report artifacts

## Milestone 1

Milestone 1 provides:

- The reusable RevenuePulse project structure
- A premium dark application shell
- Original RevenuePulse branding
- Navigation for the planned dashboard modules
- Session-scoped application state
- Configuration through Pydantic
- Automated shell tests

## Milestone 2

Milestone 2 provides:

- Premium dark navy, charcoal, purple and cyan visual styling
- A persistent left workspace navigation
- Functional module switching
- Search and date-range controls
- Data-source and export controls
- Responsive overview preview cards
- An original top navigation and workspace brand treatment

## Milestone 3

Milestone 3 provides:

- Real KPI calculations from the fictional SaaS demo dataset
- Revenue by product donut chart
- Acquisition funnel
- Account-health distribution
- Acquisition-channel and event-breakdown charts
- Recent account activity
- Accounts-at-risk table

## Milestone 4

Milestone 4 provides:

- CSV and Excel upload support
- Required-column and data-quality validation
- Column mapping to the RevenuePulse data contract
- Session-scoped uploaded data
- Downloadable fictional example CSV and Excel datasets
- A downloadable CSV data dictionary

## Milestone 5

Milestone 5 provides:

- Linear monthly revenue forecasting
- 95% uncertainty bands
- IQR revenue anomaly detection
- Account-health and churn-risk derivation
- Account retention cohort heatmaps
- Rule-based, evidence-labelled insights

## Milestone 6

Milestone 6 provides:

- Executive Excel workbooks with summary and account-record sheets
- Executive PDF reports derived from active metrics
- A functional Reports page
- Working report export controls
- Automated validation of workbook and PDF payloads

The design reference image was not found at
`assets/design-reference.png`. It must be supplied before Milestone 2
design work can be matched precisely.

## Project structure

```text
RevenuePulse/
  app.py
  core/                  Shared models and analytics services
  components/            Reusable UI components
  dashboards/            Independent dashboard configurations
  data/                  Demo data and import templates
  tests/                 Automated tests
  assets/                Logo and visual assets
  documentation/         Installation and product documentation
```

## Windows quick start

Use Python 3.11 or newer. Python 3.11 is recommended for the widest package
compatibility.

```powershell
cd E:\Data-Science\RevenuePulse
py -3.11 -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
streamlit run app.py
```

Open the URL printed in the terminal, normally
`http://localhost:8501`.

If PowerShell prevents environment activation:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.venv\Scripts\Activate.ps1
```

## Tests

```powershell
python -m pytest -q
```
