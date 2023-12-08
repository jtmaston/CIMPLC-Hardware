# Hardware design

The hardware design was done to be as modular as possible: The problem was broken down into sub-modules, each utilizing
a hierarchical sheet. This way, modifications down the line can be brought without any need to perform complex operations
on the schematic (and, with a little luck, also on the PCB).

![overallDiagram.png](overallDiagram.png)
Overall schematic

We'll analyze the structure and modules, from left to right, top to bottom, explaining goals and functionality.

## IO Terminal
More of an aesthetic choice than anything, this block houses the individual 3 x 10 pin headers to the outside.

## [O Block](Output-Block.md)
Short for output block, houses components necessary to generate output signals to the headers. Takes pairs of signals,
low-side command signals (marked O_ACT_#), and high-side outputs (O_DAT_#). Implicit nets are power lines (+24v, +3.3v,
GND). At a logic level, a TRUE signal on O_ACT_X triggers O_DAT_X to switch to high voltage. ~~a FALSE signal on O_ACT_X
causes O_DAT_X to be pulled to ground~~ (see [Errata (1)](Errata.md))

## Power management
For V1, this is a placeholder block: due to me wanting to restrict the amount of variables (as well as the fact that
very early designs considered using mechanical relays for switching), I decided to move power delivery off-board, via
an external voltage regulator. In the current configuration, contains headers to bring +24v, +3.3V and GND, all sourced
externally. (See [Errata (3)](Errata.md))

## [Remote I/O Block](Remote-I-O.md)
This block implements the I/O controllers utilized in the project. Due do the high pin count of the PLC, it was
necessary to extend the default pinout of the microcontroller. The solution adopted is to use I2C-based extenders.
This block takes, as inputs, standard I2C data and clock lines (SDA, SCL), as well as address selector bits (in cases,
like in the V1, where multiple extenders were used). Outputs signals from the extenders, as either logic level high
or low, depending on the situation. Default behavior is, on boot, to drive all outputs low.

## [RS232](RS232.md)
Houses the RS232 transceiver, as well as supporting components. Internally, RS232 (as well as 485, as we'll touch on
later), are mapped to the UART pins of the ESP32, with the additional flow control signals getting dedicated pins (in
V1, these hardware flow control pins go largely unused). Please also see [Errata(2)](Errata.md) for how programming the
ESP32 can interfere with the RS232 bus and vice-versa. Connects to the outside via DB9 connector.

## RTC
This block is designed to house an RTC (real-time clock) module, with associated components (battery included), to be 
used in synchronizing the PLC and ensuring proper timestamping of events and time management. Connects via I2C to the
controller. Please note that, for the V1, an external module is used, namely
[this](https://cleste.ro/modul-rtc-ds3231-at24c32.html).

## [CAN](CAN.md)
Houses the CAN transceiver and supporting components. Takes CAN_RX and CAN_TX data lines from the CAN controller
integrated in the MCU, and outputs data via a screw terminal located on the side of the board. Please see
[Errata(4)](Errata.md) to the reason why this had to be disabled on V1.

## [RS485](RS485.md)
Houses the RS232 transceiver, as well as supporting components. Internally, it is mapped to the UART pins of the ESP32.
Connects to the outside via a DB9 connector.

## [EEPROM](EEPROM.md)
Houses the eeprom, used to store program data. In order to keep the design simple, a two-wire I2C eeprom was chosen.

## ESP32-DEVKITC
The microcontroller board. This houses the ESP32, as well as allowing for it to be removed and replaced via socketed pins.

## [I Block](I-Block.md)
Short for input block. This houses the pre-processing of signals, before being fed into the MCU's ADC, which handles
sampling of data, conversion from discrete to logical values, and conversion from analog to digital. Somewhat reversed
to the O Blocks, I_DAT_X represents the physical pin of the PLC, connecting it to the outside world, while I_ACT_X
represents the pre-processed signal to be fed into the ADC.