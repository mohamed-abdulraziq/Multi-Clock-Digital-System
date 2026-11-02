# Formal Equivalence

The supplied Synopsys Formality logs record two independent equivalence runs:

1. Post-synthesis: RTL reference versus synthesized gate-level netlist.
2. Post-DFT: RTL reference versus post-DFT gate-level netlist.

Both runs report **386 passing compare points** and **zero failing compare points**. Both used `synopsys_auto_setup`.

The post-DFT run explicitly excludes four scan-output ports from comparison. Its log also lists three unread DFF points under “Not Compared”; these are disclosed in the detailed report rather than counted as passing points.

Detailed results:
- [Post-synthesis equivalence](Reports/Post_Synthesis_Equivalence.md)
- [Post-DFT equivalence](Reports/Post_DFT_Equivalence.md)

These results apply to the compare points reported under the documented Formality setup. They are not ATPG pattern simulation or physical sign-off.
