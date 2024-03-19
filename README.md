﻿# **Digital Clock Design**
This is a digital clock, which supports the display of two different time, using (mode) signal to decide which time to show on the 8-segment displays. Users could use (nextP0), (nextP1), and (add) signals, signals originally generated by pressing buttons, to correctly set second, minute, and hour units of the clock after reset.

## Arithmetic Part ##
The design integrates the designs of ripple carry adders and carry-lookahead adders.

## 8-Segment Display Logic ##
The 8-segment displays of the Altera FPGA board with EP4CE10F17C8 chip in Cyclone IV Series are designed based on dynamic scanning method. To show different digits on the different displays simultaneously, the logic of activating displays in turns, 1ms at a time is designed. 

## 74HC595 Chip Drive ##
The correct logic of setting DS, OE, STCP, and SHCP signals of the chip is designed, which achieves the linear input and parallel output function of the chip. Thus, the digits of the time can be correctly shown on the FPGA board.
