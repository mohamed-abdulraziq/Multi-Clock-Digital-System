# Al-Tamaseh — Multi-Clock Digital System

A modular multi-clock digital system implemented in Verilog/SystemVerilog. The design integrates UART communication, an asynchronous FIFO, a system controller, clock/reset management, and supporting datapath/control blocks.

## Project Overview

This repository contains the RTL and verification source currently available for the integrated system.

### Main RTL Components

- **System integration:** `SYSTEM_TOP`, `SYS_CTRL`, and the system testbench.
- **UART:** transmitter and receiver blocks, including FSMs, serializers/deserializers, counters, parity and framing checks, and RX sampling logic.
- **Asynchronous FIFO:** FIFO read/write logic, memory control, and read-to-write / write-to-read synchronization.
- **Clock and reset:** clock divider, prescale mux, clock gating, reset synchronizer, pulse generation, and data synchronizer.
- **Datapath:** ALU and register file.

## Repository Structure

```text
.
├── RTL/
│   ├── Top/
│   ├── Controller/
│   ├── UART/
│   │   ├── RX/
│   │   └── TX/
│   ├── FIFO/
│   ├── Synchronizers/
│   ├── Clock_Reset/
│   └── Datapath/
├── Verification/
├── Synthesis/
├── DFT/
├── Formality/
├── Physical_Design/
└── README.md
```

## Verification

The integrated RTL testbench is provided in `Verification/`. The repository does not claim a simulation pass count or functional coverage percentage until the exact simulator transcript and configuration are included.

## ASIC Implementation Evidence

The project work includes synthesis, scan DFT, formal equivalence, and physical-design artifacts. Selected reports and outputs will be added only after review and sanitization.

Tool reports describe the specific runs and constraints recorded in those reports. They should not be interpreted as foundry sign-off unless the relevant sign-off checks and conditions are explicitly documented.

## Tools

The available artifacts indicate the use of Synopsys Design Compiler, Synopsys Formality, DFT tooling, and Cadence Encounter for implementation-related stages.

## Reproduction and Exclusions

Some original EDA scripts, technology libraries, and tool setup files are not included in this initial public snapshot. Proprietary PDK/library files, license material, and environment-specific absolute paths are intentionally excluded. Reproducing the complete ASIC flow requires access to the relevant licensed tools, technology files, and project constraints.

## License

No license has been added. Until a license is selected, this repository is source-available for viewing but does not grant reuse rights.
