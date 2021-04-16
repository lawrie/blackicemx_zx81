# Blackice MX ZX81

## Introduction

This is a port of the Mist version of the Sinclair ZX81 to the Blackice MX ice40 FPGA board.

It has VGA output and requires a PS/2 keyboard.

It is a 1KB version of the ZX81, and has no support for software loading or saving, so you can only use it to type in and run Basic programs.

Sound output has not been tested.

You really need a template of the ZX81 keyboard to see what keys to press to type in Basic programs.

## Hardware

You need a Digilent VGA Pmod attached to the Mixmod opposite the usb connector, and a Diligent PS/2 keyboard Pmod connected to the bottom left of the Mixmod next to the USB connector.

## Development

The code is all Verilog. Only BRAM is used: 1KB for the RAM and 12KB for the ROM which is actually a concatenation of the 8KB ZX81 ROM and the 4KB ZX80 ROM.

The 25MHz clock, divided by 2 ois used as the system clock, so no PLL is used.  A scan doubler produces a 25MHz VGA signal. The Z80 CPU runs a little slower than the real ZX81.

There is a nasty hack in the video code that seemeed to be necessary to get characters to display correctly.

Overall, a lot of work would be needed to get ZX81 software to run accurately on it.

The code has a ZX80 mode but that is not currently supported.

## Bugs

The VGA signal is not very accurate and does not work on all monitors.

I am not sure if the working of the keyboard, particularly the shift key, is correct.

Sound might work but hasn't been tested. You would need to connect a speaker to pin 22.

The CPU speed is a little slow.

There is a glitch in the screen output in the top left of the screen.
