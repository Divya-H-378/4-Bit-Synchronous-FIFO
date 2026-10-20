# 4-bit Synchronous FIFO Memory

## Project Overview
This project implements a synchronous First-In, First-Out (FIFO)
memory using Verilog HDL. It stores 16 entries, with each entry
containing 4 bits of data.

## Features
- 4-bit data input and output
- 16 memory locations
- Synchronous reset
- Read and write pointer management
- FIFO full and empty status flags
- Protection against writing when full
- Protection against reading when empty
- Simultaneous read and write support
- Simulation using a Verilog testbench

## Tools Used
- Verilog HDL
- EDA Playground
- Icarus Verilog simulator
- EPWave waveform viewer

## Project Files
- `design.sv` - FIFO RTL design
- `testbench.sv` - Simulation testbench
-  Simulation logs and waveform - Images are uploaded

## How to Run
1. Open EDA Playground.
2. Select SystemVerilog/Verilog.
3. Paste the design into `design.sv`.
4. Paste the testbench into `testbench.sv`.
5. Select Icarus Verilog as the simulator.
6. Click Run and check the simulation log.

## Applications
FIFO buffers are used in digital systems for temporary data
storage, data transfer between modules, and communication systems.

## Learning Outcomes
- Basic Verilog RTL design
- Clocked sequential logic
- Memory and pointer management
- Functional simulation and verification
