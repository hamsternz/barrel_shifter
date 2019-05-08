# barrel_shifter
A VHDL clocked 32-bit barrel shifter 

It can perform the following functions, through stting the
 'sign_extend' and 'left_shift' inputs:

*  Shift Left

*  Shift Right Unsigned

*  Shift Right Signed 

This happens to be the operations requried to support the 
RISC-V SLL, SRL, SRA, SLLI, SRLI and SRAI instructions

Includes a test bench file (tb_shifter.vhd) that cycles thorugh all modes.

The design is written to hint at efficiently using LUT-6 lookup tables as used in Artix-7.

# Resource usage and performance
In ARTIX-7 this uses about 130 LUTs and 32 FFs, and runs at over 200 MHz with registered inputs.
