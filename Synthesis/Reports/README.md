# Synthesis Reports — SYSTEM_TOP

This folder documents the supplied Synopsys Design Compiler synthesis reports for `SYSTEM_TOP` (report date: 23 October 2024, Design Compiler K-2015.06).

## Area report

| Metric | Reported value |
|---|---:|
| Ports | 929 |
| Nets | 2,991 |
| Total cells | 2,042 |
| Combinational cells | 1,592 |
| Sequential cells | 406 |
| Buffers / inverters | 308 |
| Macros / black boxes | 0 |
| Combinational area | 14,653.445343 |
| Sequential (non-combinational) area | 12,780.139122 |
| Buffer / inverter area | 1,209.647625 |
| **Total cell area** | **27,433.584466** |

Area values are in the technology library's area units. They are not mm². The report states that no wire-load model was specified, so net-interconnect area and total area are undefined.

### Hierarchical area highlights

| Block | Cell area | Share |
|---|---:|---:|
| Register File | 7,100.2081 | 25.9% |
| ALU | 5,671.6941 | 20.7% |
| UART | 5,175.1267 | 18.9% |
| Asynchronous FIFO | 4,775.0488 | 17.4% |
| System Controller | 1,787.4073 | 6.5% |
| RX Clock Divider | 793.0958 | 2.9% |
| TX Clock Divider | 793.0958 | 2.9% |

## Clock report

| Clock | Period | Approx. frequency | Source |
|---|---:|---:|---|
| `REF_CLK` | 20.00 ns | 50 MHz | Primary reference clock |
| `ALU_CLK` | 20.00 ns | 50 MHz | Generated from gated `REF_CLK` |
| `UART_CLK` | 271.27 ns | 3.686 MHz | Primary UART clock |
| `UART_RX_CLK` | 271.27 ns | 3.686 MHz | Generated from `UART_CLK`, divide-by-1 |
| `UART_TX_CLK` | 8,680.54 ns | 115.2 kHz | Generated from `UART_CLK`, divide-by-32 |
| `SCAN_CLK` | 40.00 ns | 25 MHz | Scan clock |

These are the periods recorded by the synthesis clock report; the approximate frequencies are calculated from those periods.

## Setup and hold reports

The supplied synthesis timing reports show:

- Worst setup path: `ALU/OUT_VALID_reg` to `ALU/ALU_OUT_reg[15]`, path group `ALU_CLK`, slack **+17.95 ns**.
- Worst reported hold path slack: **+0.42 ns**, within the `ALU_CLK` path group.
- The separate `report_constraint -all_violators` output states: **“This design has no violated constraints.”**

These are pre-layout Design Compiler timing results under the constraints and operating conditions in the original reports. They are not the post-route timing results; see [Physical Design Reports](../../Physical_Design/Reports/README.md).

## Power estimate

The Design Compiler power report gives a total estimate of approximately **0.296 mW**. It was run with low analysis effort and zero-delay activity propagation. The report warns that primary inputs and sequential cell outputs are unannotated. Treat this as an early estimate, not sign-off power.

## Design checks

The supplied `check_design` output contains lint/check findings, including unconnected ports, shorted outputs, constant outputs, and cells that do not drive nets. The report is not warning-free. These findings should be reviewed against the RTL hierarchy and intended unused/test ports before describing the design as clean.

## Evidence and limitations

- Source artifacts: the supplied Design Compiler area, clock, setup, hold, constraints, power, and check-design reports.
- Technology-library names and machine-specific paths are intentionally omitted from this public summary.
- No physical area is claimed from this synthesis report.
- The physical-design reports use top-cell name `SYS_TOP`, while these synthesis reports use `SYSTEM_TOP`. The available evidence does not establish the exact naming/mapping relationship, so the distinction is retained.
