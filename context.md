# Project Context for Code Generation

## Language
This project is developed using **SystemVerilog** for hardware design and simulation.

## Module Generation Guidelines
When creating new SystemVerilog modules:

- **Module Name**: The module name must match the file name (excluding the `.sv` extension). For example, a file named `example_module.sv` should contain a module named `example_module`.

- **Default Inputs**: On initial generation, include the following standard inputs:
  - `input logic clk` - Clock signal
  - `input logic rst` - Reset signal (active high or low as appropriate for the design)

These conventions ensure consistency across the project and facilitate integration with existing simulation and synthesis workflows.