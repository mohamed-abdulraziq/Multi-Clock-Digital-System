# Physical-Design Geometry and Connectivity Checks — SYS_TOP

**Tool:** Cadence First Encounter  
**Report date:** 25 October 2024

## Geometry check

The supplied geometry report ran:

`verifyGeometry -noMinArea`

Reported counts:

| Check category | Findings |
|---|---:|
| Cells | 0 |
| Same-net | 0 |
| Wiring | 0 |
| Antenna | 0 |
| Shorts | 0 |
| Overlap | 0 |

The report states “No DRC violations were found” for this command. **Minimum-area checking was explicitly disabled** by `-noMinArea`; this must not be presented as a complete foundry DRC sign-off.

## Connectivity check

The supplied connectivity report ran:

`verifyConnectivity -type all -noAntenna`

It reports: **“Found no problems or warnings.”**

This is the result of the stated Encounter connectivity check. It is not an LVS report and should not be described as LVS-clean.
