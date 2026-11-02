# Al-Tamaseh — Multi-Clock Digital System

A modular multi-clock digital system implemented in Verilog/SystemVerilog. The design integrates UART communication, an asynchronous FIFO, a system controller, clock/reset management, and supporting datapath/control blocks.

## Architecture at a glance

- **System integration:** `SYSTEM_TOP` and `SYS_CTRL`.
- **UART:** transmitter and receiver, including FSMs, serializer/deserializer, counters, parity checks, start/stop checks, and RX sampling.
- **Asynchronous FIFO:** independent write/read clock domains, pointer logic, memory control, and cross-domain pointer synchronizers.
- **Clock and reset:** clock dividers, prescale selection, clock gating, reset synchronizers, pulse generation, and data synchronization.
- **Datapath:** ALU and register file.

## Repository layout

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
└── README.md
```

## Verification

The integrated testbench is included in `Verification/SYSTEM_TB.v`. It exercises serial UART commands for register-file access, ALU operations, and configuration updates. The source contains output comparisons, but a complete simulator transcript is not currently included; accordingly, no PASS count or coverage percentage is claimed here. See [Verification](Verification/README.md).

## ASIC implementation

The available project evidence covers synthesis, scan DFT, formal equivalence, and physical-design stages. Summaries and qualifications are documented separately:

- [Synthesis](Synthesis/README.md)
- [DFT](DFT/README.md)
- [Formality](Formality/README.md)
- [Physical Design](Physical_Design/README.md)

The reported implementation results apply to the exact tool runs, netlists, constraints, and checks documented in the source reports. In particular, the geometry/connectivity checks should not be interpreted as full foundry DRC/LVS sign-off, and the reported power is a preliminary estimate.

## Tools

The available artifacts indicate use of Synopsys Design Compiler, Synopsys Formality, DFT tooling, and Cadence Encounter.

## Reproduction and exclusions

The original EDA scripts, complete constraints, licensed technology libraries, and tool setup files are not included in this initial public snapshot. Proprietary PDK/library files, license material, extracted implementation databases, and environment-specific absolute paths are intentionally excluded. Reproducing the complete ASIC flow requires access to the relevant licensed tools, technology files, and project constraints.

## License

No license has been added. Until a license is selected, this repository is source-available for viewing but does not grant reuse rights.
