# Physical-Design Artifacts

The supplied project files include the following implementation outputs for top cell `SYS_TOP`:

| Artifact | Supplied file | What it represents |
|---|---|---|
| GDSII | `SYS_TOP.gds` | Physical layout database |
| SDF | `SYS_TOP.sdf` | Standard Delay Format timing annotation |
| DSPF | `SYS_TOP.spf` | Detailed parasitic data |
| Gate-level netlist | `SYS_TOP.v` | Physical-design gate-level netlist |
| Power/ground netlist | `SYS_TOP_pg.v` | Netlist including power/ground connections |

These outputs were reviewed as project evidence. The binary layout/parasitic files and technology-dependent netlists are not copied into this public repository snapshot because they can embed licensed technology information and are large implementation artifacts. The repository includes the corresponding timing, power, geometry, connectivity summaries and a physical-layout screenshot instead.

The synthesis and Formality logs use top-cell name `SYSTEM_TOP`; the physical-design outputs use `SYS_TOP`. The available evidence does not independently prove the exact naming/mapping relationship.
