# CIMPLC

<!--CIMPLC-HardwareDocs adds this topic when you create a new documentation project.
You can use it as a sandbox to play with CIMPLC-HardwareDocs features, and remove it from the TOC when you don't need it anymore.-->

## About the project
The CIMPLC is a low-cost, open source high pin-count programmable logic controller, designed as a project while
studying at the University of Politehnica, Bucharest. It is designed as a replacement for the aging hardware found
inside the CIM ( Computer Integrated Manufacturing ) located in our faculty.

Designed to replace aging hardware (old Festo PLCs from cca 1993, whose datasheets and manuals are unavailable), the
goal of the CIMPLC is to emulate the functionality of its industrial-grade counterparts, but maintain an accessible
price point. First and foremost, however, it is a learning project, in order to help understand what designing such a
system would entail.

While I took all the necessary precautions to ensure that the device is functional and operational, note that it is a
student project and should absolutely **not** be used in an industrial application. Your mileage may vary. Please see
the "errata" section for errors in the design, and how they were remedied.

## Version 1
### Overview
The CIMPLC is based, as much as possible, on readily-available parts. Since the hardware development time had to be
reduced as much as possible, it was decided to simplify the control hardware, by using an ESP32 Devkit v4 at the core.
Beyond that, the goal was to employ as many interfaces as possible compatible to the CIM.
### General hardware design and specifications
- RS232
- RS485
- ~~CAN~~ (See limitations)
- WiFi / Bluetooth

### Input / Output
- 12 Inputs
- 32 Outputs

### Program memory
- 125KB of EEPROM for user program storage
- 4MB of external SRAM, used for instruction caching

### Programmability
- Over the air (OTA) firmware updates
- Built-in optimizing compiler to translate IEC 61131-3 instructions to bytecode which can be loaded faster from EEPROM.

### Limitations

- Due to the fast development cycle and my inexperience with electronics, an oversight was introduced, which means that
pin states are not well defined: they are either at 24v, or at ???. This is due to lack of any mechanism to pull to 
ground, which also means that the outputs are only able to source current, not sink. The implementation, using
solid-state relays, allow to source +24v when the pin is driven high, but otherwise leaves the pin floating.

- Similarly, due to my inexperience, I avoided implementing onboard power management, relying on an external +24v power\
supply, able to drive the pin outputs, as well as a +5v rail to power the control side.

- An oversight has been the fact that strapping pins 0 and 2 have been used, which control going into the bootloader.
As such, all reboots would necessitate the CANH line being high. With that in mind, for this version,
it has been removed and functionality abandoned.