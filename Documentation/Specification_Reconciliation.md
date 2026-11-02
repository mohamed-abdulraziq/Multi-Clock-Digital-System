# Specification and RTL Reconciliation Notes

This note records differences found by comparing the supplied `Final_System` specification document with the RTL/testbench snapshot currently published in this repository. It intentionally does not silently alter either source.

## 1. Reference clock

- Specification: `REF_CLK = 50 MHz` (20 ns period).
- Integrated testbench default: `REF_Clock_Period = 10` ns (100 MHz).

The intended simulation/synthesis clock should be confirmed before claiming that the included testbench or a timing run exactly matches the specification.

## 2. Register-file address range

- Specification text describes normal register-file read/write addresses from `0x4` to `0x15`.
- Current RTL defaults: `ADDR = 4` and `DEPTH = 16`, so the address bus can represent only `0x0` through `0xF`.

The documented upper range cannot be represented by the current default address width/depth. The intended depth and address width need confirmation.

## 3. ALU result width

The RTL parameterizes the ALU output as `OUT_WIDTH = 2 * OPER_WIDTH`; with the default 8-bit operands, the result bus is 16 bits. The system specification's ALU table and system-controller interface descriptions are not fully consistent about the result width. This repository documents the RTL declaration as implemented.

## 4. Verification status

The integrated testbench source is included, but a full simulator transcript showing the exact compile/run setup and final exit status is not currently included. No new simulation result is claimed by publishing the source.

## 5. Physical implementation scope

The repository documents the available post-route timing, geometry, connectivity, and power-report summaries with their limitations. The Encounter screenshot is visual context; it is not, by itself, proof of complete DRC/LVS or foundry sign-off.
