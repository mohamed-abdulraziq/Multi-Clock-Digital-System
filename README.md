# Multi-Clock Digital System

A modular multi-clock digital system implemented in Verilog/SystemVerilog. The design integrates UART communication, an asynchronous FIFO, a system controller, a register file, an ALU, and clock/reset management.

![Post-route physical implementation view](Documentation/images/Final_System_Physical_Design.jpg)

## System architecture

The design is organized around two clock domains:

- **Reference-clock domain (`REF_CLK`):** system controller, register file, ALU, ALU clock gating, FIFO write side, and UART RX data synchronization.
- **UART-clock domain (`UART_CLK`):** UART RX/TX clock generation, UART interfaces, pulse generator, and FIFO read side.
- **CDC structures:** reset synchronizers, data synchronizer, and asynchronous FIFO with independently clocked read/write sides.

The specification lists `REF_CLK = 50 MHz` and `UART_CLK = 3.6864 MHz`. See [System Architecture](Documentation/Architecture.md) for the system data flow, register map, command framing, and ALU function encodings.

## Main RTL blocks

- **System control:** command decoding and sequencing for register-file and ALU operations.
- **UART RX/TX:** serial communication, sampling, serialization, parity checking, and framing checks.
- **Asynchronous FIFO:** buffering between the reference and UART clock domains.
- **Register file:** configurable data/address widths, with four reserved registers used for ALU operands and UART/clock configuration.
- **ALU:** arithmetic, logic, comparison, and shift operations.
- **Clock/reset and CDC:** clock dividers, clock gating, reset synchronizers, data synchronizer, and FIFO pointer synchronizers.

## Repository structure

```text
.
├── RTL/
│   ├── Top/
│   ├── Controller/
│   ├── UART/RX/
│   ├── UART/TX/
│   ├── FIFO/
│   ├── Synchronizers/
│   ├── Clock_Reset/
│   └── Datapath/
├── Verification/
│   └── SYSTEM_TB.v
├── Synthesis/
├── DFT/
├── Formality/
├── Physical_Design/
└── Documentation/
    ├── Architecture.md
    ├── Specification_Reconciliation.md
    └── images/
```

## Verification

The integrated testbench is included in `Verification/SYSTEM_TB.v`. Its stimulus covers UART command-based register-file access, ALU operations, and configuration updates. The source contains output comparisons.

## ASIC implementation

The available project evidence includes synthesis, scan DFT, formal equivalence, and physical-design artifacts. Summaries and qualifications are documented in the relevant folders:

- [Synthesis](Synthesis/README.md)
- [DFT](DFT/README.md)
- [Formality](Formality/README.md)
- [Physical Design](Physical_Design/README.md)

The available post-route summary reports positive setup and hold slack under its recorded constraints. The geometry and connectivity checks are limited to the commands documented in the report; they are not represented as full foundry DRC/LVS sign-off. The power figure is a preliminary estimate.

## Specification alignment

A few differences exist between the supplied specification and the current RTL/testbench defaults, including the reference-clock period and the documented register-file address range. These are explicitly recorded in [Specification Reconciliation](Documentation/Specification_Reconciliation.md) rather than silently reconciled.

## Tools and reproduction

The available artifacts indicate the use of Synopsys Design Compiler, Synopsys Formality, DFT tooling, and Cadence Encounter. The original EDA scripts, complete constraints, licensed technology libraries, and some tool setup files are not included in this public snapshot. Reproducing the complete ASIC flow requires the relevant licensed tools, technology files, and project constraints.

Proprietary PDK/library data, license material, extracted implementation databases, and environment-specific absolute paths are intentionally excluded.
