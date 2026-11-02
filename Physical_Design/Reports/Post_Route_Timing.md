# Post-Route Timing Summary — SYS_TOP

**Tool:** Cadence First Encounter  
**Report date:** 25 October 2024  
**Top cell in report:** `SYS_TOP`

## Setup timing

| Path group | WNS (ns) | TNS (ns) | Violating paths | Analyzed paths |
|---|---:|---:|---:|---:|
| All | **+2.649** | 0.000 | 0 | 1,159 |
| Reg-to-reg | +2.649 | 0.000 | 0 | 1,135 |
| Input-to-reg | +14.846 | 0.000 | 0 | 397 |
| Reg-to-output | +28.684 | 0.000 | 0 | 7 |
| Clock gating | +17.398 | 0.000 | 0 | 1 |

## Hold timing

| Path group | WNS (ns) | TNS (ns) | Violating paths | Analyzed paths |
|---|---:|---:|---:|---:|
| All | **+0.039** | 0.000 | 0 | 1,159 |
| Reg-to-reg | +0.039 | 0.000 | 0 | 1,135 |
| Input-to-reg | +0.307 | 0.000 | 0 | 397 |
| Reg-to-output | +8.995 | 0.000 | 0 | 7 |
| Clock gating | +0.615 | 0.000 | 0 | 1 |

The setup summary also reports zero max-capacitance, max-transition, and max-fanout violations for the checks shown.

## Interpretation

The supplied post-route summaries show positive setup and hold slack, with zero reported violating paths under the recorded constraints and analysis. Hold slack is relatively small at **39 ps**, so it should be stated precisely rather than rounded away.

These reports are evidence of the reported timing analysis; they do not, by themselves, establish full multi-corner/multi-mode sign-off. The physical-design report top cell is named `SYS_TOP`, whereas the synthesis/Formality reports name `SYSTEM_TOP`; the mapping between these names should be confirmed before making a strict same-top claim.
