# Verification

## Included testbench

- `SYSTEM_TB.v`: integrated testbench for `SYSTEM_TOP`.

The testbench drives UART serial frames and exercises register-file write/read commands, ALU operations, and a prescale/configuration update sequence. It includes output comparisons that print a succeeded/failed message.

## Current evidence status

The source testbench is included, but a simulator transcript with the exact simulator/version, compile command, final exit status, and complete test output is not currently part of this repository. Therefore this repository does **not** claim a verified PASS count or functional-coverage percentage.

The standalone UART RX/TX testbenches are not included in this initial snapshot. They will be added only after checking their module-port compatibility and syntax against the RTL snapshot.
