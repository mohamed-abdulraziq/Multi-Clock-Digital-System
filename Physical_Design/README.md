# Physical Design

The available implementation artifacts include a GDSII layout, SDF timing annotation, DSPF parasitic data, gate-level netlists, and Encounter reports.

## Reported post-route timing

| Check | Worst slack | Total negative slack | Violating paths |
|---|---:|---:|---:|
| Setup | +2.649 ns | 0 | 0 |
| Hold | +0.039 ns | 0 | 0 |

The post-route summary reports 1,159 analyzed paths. The positive slack values apply to the supplied constraints and the reported analysis corner/mode.

## Geometry and connectivity checks

- The Encounter geometry report reports no violations for the checks it ran; its command used `verifyGeometry -noMinArea`, so minimum-area checking was excluded.
- The connectivity report reports no problems or warnings for `verifyConnectivity -type all -noAntenna`.
- This is not an LVS report and is not evidence of full foundry DRC/LVS sign-off.

## Power estimate

The available power report estimates 0.7142 mW total power. The report uses low-effort, zero-delay assumptions and lacks complete switching activity annotation, so this number is a preliminary tool estimate, not sign-off power.

The binary layout, extracted parasitics, and raw tool reports are not included in this public snapshot. They may contain implementation or technology-specific information and require separate review before publication.
