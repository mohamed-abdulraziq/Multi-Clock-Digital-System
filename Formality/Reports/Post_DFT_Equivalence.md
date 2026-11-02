# Post-DFT Formal Equivalence

**Reference:** RTL `SYSTEM_TOP`  
**Implementation:** Post-DFT gate-level netlist `SYSTEM_TOP`  
**Tool log date:** 23 October 2024

## Result

| Metric | Result |
|---|---:|
| Matched compare points | 386 |
| Passing compare points | 386 |
| Failing compare points | 0 |
| Verification status | **SUCCEEDED** |

The comparison setup enabled Synopsys Auto Setup. The four scan-output ports (`SO[3:0]`) were explicitly excluded from comparison because they are test-only ports added after scan insertion.

This confirms equivalence for the reported compare points under the documented setup. It is not ATPG pattern simulation or physical sign-off.
