# RevenuePulse release checklist

Before distribution:

- [ ] Run `python -m pytest -q`
- [ ] Run `START_REVENUEPULSE.bat`
- [ ] Verify Overview loads in a fresh browser session
- [ ] Verify CSV and Excel imports
- [ ] Verify at least one PDF export
- [ ] Verify at least one Excel export
- [ ] Verify the example CSV and XLSX files
- [ ] Add the final `assets/design-reference.png` if a licensed reference is available
- [ ] Replace demo account names if the final buyer receives alternate branding
- [ ] Review the sample license for marketplace requirements
- [ ] Package the project without `.venv`, `.pytest_cache`, or `__pycache__`
