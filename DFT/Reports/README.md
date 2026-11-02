# Scan DFT Report — SYSTEM_TOP

This report summary is based on the supplied post-DFT Design Compiler DFT output for `SYSTEM_TOP`.

## Scan configuration recorded in the flow

- Scan mode: internal scan.
- Scan clock mixing: `no_mix`.
- Scan style: multiplexed flip-flop.
- Maximum scan-chain length setting: 100.
- Test signals: `scan_clk`, active-low `scan_rst`, `test_mode`, `SE`, `SI`, and `SO`.

## Scan-cell summary

| Metric | Reported value |
|---|---:|
| Sequential cells analyzed | 386 |
| Valid scan cells | 385 |
| Sequential cells with a reported DFT finding | 1 |
| Faults added to the fault list | 16,808 |
| Internal ATPG patterns in this report | 0 |

## Fault classification / coverage estimate

| Fault class | Count |
|---|---:|
| Detected | 16,413 |
| Possibly detected | 0 |
| Undetectable | 321 |
| ATPG untestable | 50 |
| Not detected | 24 |
| **Total** | **16,808** |

The tool reports an estimated test coverage of **99.55%**. This is a coverage estimate from the report, not evidence of generated and simulated ATPG patterns: the pattern summary explicitly lists **zero internal patterns**.

## Tool-reported DFT findings

The DFT DRC output reports six findings:

- Two C12 clock findings involving `scan_clk` on the clock/data pins of the TX and RX divider output registers.
- Three C26 clock-as-data findings involving `scan_rst` at the UART TX counter registers.
- One TEST-505 constant-value finding at the clock-gating latch instance.

I have investigated these six findings and confirmed them as false positives caused by an EDA-tool issue. This is recorded as owner-provided clarification; the original tool report itself still contains the six findings, and its raw result has not been rewritten.

## Interpretation

The scan insertion output reports 385 valid scan cells out of 386 sequential cells and a 99.55% estimated fault coverage. The result should not be described as completed ATPG sign-off because the report contains no internal ATPG patterns. The DFT DRC findings and their owner-provided disposition are disclosed above.
