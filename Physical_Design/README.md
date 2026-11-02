# Physical Design

The supplied Cadence Encounter implementation artifacts are associated with top cell `SYS_TOP`. The evidence includes a GDSII layout, SDF timing annotation, DSPF parasitic data, gate-level netlists, post-route timing summaries, a power estimate, geometry/connectivity checks, and a physical-layout screenshot.

## Post-route timing

| Check | Worst slack | Total negative slack | Violating paths |
|---|---:|---:|---:|
| Setup | +2.649 ns | 0 | 0 |
| Hold | +0.039 ns | 0 | 0 |

Both summaries report 1,159 analyzed paths. The hold margin is 39 ps.

Detailed reports:
- [Post-route timing](Reports/Post_Route_Timing.md)
- [Power estimate](Reports/Power_Estimate.md)
- [Geometry and connectivity checks](Reports/Geometry_and_Connectivity.md)
- [Implementation artifact inventory](Reports/Implementation_Artifacts.md)

## Scope and limitations

- Geometry: zero findings reported by `verifyGeometry -noMinArea`; minimum-area checking was excluded, so this is not full foundry DRC sign-off.
- Connectivity: no problems or warnings reported by `verifyConnectivity -type all -noAntenna`; this is not LVS.
- Power: 0.7142 mW preliminary estimate, with no activity file supplied and primary-input activity set to 0.2.
- The available post-route summaries show positive setup and hold slack under the recorded constraints, but do not by themselves establish full MCMM sign-off.

**Naming note:** synthesis/Formality reports identify the design as `SYSTEM_TOP`, while Encounter reports identify it as `SYS_TOP`. The relationship should be confirmed before claiming exact top-cell identity. GDSII, SDF, DSPF, and technology-dependent netlists are intentionally not copied into this public snapshot; their existence and roles are documented in the artifact inventory.
