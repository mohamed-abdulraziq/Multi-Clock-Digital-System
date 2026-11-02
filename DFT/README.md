# Design-for-Test (DFT)

The supplied scan DFT output for `SYSTEM_TOP` reports 386 sequential cells, 385 valid scan cells, and 16,808 faults added to the fault list. The tool's estimated test coverage is 99.55%; the same report states zero internal ATPG patterns, so this is not ATPG pattern sign-off.

The DFT DRC output lists six tool findings (five clock-related and one other). I have investigated them and confirmed they were false positives caused by an EDA-tool issue. The report's original findings remain disclosed.

See [Detailed DFT Report](Reports/README.md).
