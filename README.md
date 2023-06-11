
<div style="text-align: justify">

# CIMPLC
The CIMPLC is a low-cost, open source high pin-count programmable logic controller, designed as a project while studying at the University of Politehnica, Bucharest. It is designed as a replacement for the aging hardware found inside the CIM ( Computer Integrated Manufacturing ) located in our faculty.

# The hardware
The CIMPLC is based, as much as possible, on readily-available parts. Since the hardware development time had to be reduced as much as possible, it was decided to simplify the control hardware, by using an ESP32 Devkit v4 at the core. Beyond that, the goal was to employ as many interfaces as possible compatible to the CIM.


## Features

### Interfaces
- RS232
- RS485
- CAN
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
## Limitations

Due to the fast development cycle and my inexperience with electronics, the outputs are only able to source current, not sink. The implementation, using solid-state relays, allow to source +12v when the pin is driven high, but otherwise leaves the pin floating.

Similarly, due to my inexperience, I avoided implementing onboard power management, relying on an external +12v power supply, able to drive the pin outputs, as well as a +5v rail to power the control side. There will probably be more things , but this is all I've discovered up at this point.


## License

This project is licensed under the [CERN OHL v2 Weakly Reciprocal](https://choosealicense.com/licenses/cern-ohl-w-2.0/).


</div>