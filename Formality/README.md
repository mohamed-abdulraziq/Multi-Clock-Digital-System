# Formal Equivalence

The available Formality logs record two equivalence runs:

1. Post-synthesis: reference RTL versus synthesized gate-level netlist.
2. Post-DFT: reference RTL versus post-DFT gate-level netlist.

Both reports summarize 386 passing compare points, with 0 failing, 0 aborted, and 0 unverified points. In the post-DFT comparison, four scan output ports were excluded from comparison.

The runs used Synopsys Formality with automatic setup enabled (`synopsys_auto_setup`). These results apply to the exact reference, implementation netlists, setup, and compare configuration used in those runs. They should not be read as proof for different constraints, netlists, or configurations.

The original logs and SVF guidance files are not included in this public snapshot.
