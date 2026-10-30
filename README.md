# ECE 128 Lab 7 - Multi-Digit Display

## Description
This lab focuses on designing a 12-bit UP counter that counts from 0 to 4095 and displays the result on the Basys 3 FPGA board using Verilog HDL. The design includes a clock enable, binary-to-BCD converter, and multi-digit seven-segment display driver

## Simulation
1. Open the project in Vivado
2. Set `lab7_top_tb` as the simulation top
3. Run Behavioral Simulation
4. Observe the anode and cathode outputs in the waveform

## FPGA Implementation
1. Set `lab7_top` as the top module
2. Add the Basys 3 constraints file
3. Run synthesis and implementation
4. Generate the bitstream and program the Basys 3 board
5. Observe the counter output on the seven-segment display
