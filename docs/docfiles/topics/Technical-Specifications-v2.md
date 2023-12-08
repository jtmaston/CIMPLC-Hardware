# Technical Specifications
### Electrical parameters

|           Parameter           | Minimum | Recommended | Maximum | Unit |
|:-----------------------------:|---------|:-----------:|:-------:|:----:|
|        Supply voltage         | -       |      -      |    -    |  V   |
|         Load voltage          | -       |      -      |    -    |  V   |
|    Reverse voltage, IO pin    | -       |      -      |    -    |  V   |
|  Reverse voltage, power pin   | -       |      -      |    -    |  V   |
|     Brown-out protection      | -       |      -      |    -    |  V   |
|       Operating current       | -       |      -      |    -    |  mA  |
|    Load current (per pin)     | -       |      -      |    -    |  mA  |
| Load inrush current (per pin) | -       |      -      |    -    |  A   |
|  Operating temperature range  | -       |      -      |    -    |  °C  |

### Programming characteristics

| Parameter                                          | Value                | Unit           |
|----------------------------------------------------|----------------------|----------------|
| Available user program memory (shared among vPLCs) | 125                  | KB             |
| Available user program instruction count           | 64k                  | -              |
| Available variable storage space                   | 20                   | KB             |
| Effective interpreter speed                        | 10 -> 30             | MHz            |
| Dynamic frequency scaling                          | Experimental support | -              |
| Maximum number of vPLC per single core             | 4                    | -              |
| CPU processing times - bit operations              | TBD                  | μs/instruction |
| CPU processing times - word opreations             | TBD                  | μs/instruction |
| CPU processing times - floating point operations*  | TBD                  | μs/instruction |
*Internally, floating-point operations are cast to fixed-point.

### Programmability
- Over the air (OTA) firmware updates
- Built-in optimizing compiler to translate IEC 61131-3 instructions to bytecode which can be loaded faster from EEPROM.

### Peripherals
- I/O
    - 12 analog / digital inputs
    - 12-bit ADC
    - 5% maximum deviation
    - High-impedance inputs via voltage followers
    - 32 high-side outputs
- RS232
    - Baudrate: 9600 bps -> 1Mbps
    - Hardware flow-control, DTR, CTS
    - Industrial voltage range: -25V -> 25V
    - DB9 connector
- RS485
    - Baudrate: 9600 bps -> 1Mbps
    - Experimental ProfiBus implementation
    - Industrial voltage range: -13V -> 16.5V
    - DB9 connector
- ~~CAN~~ (see limitations section)
    - ~~Support data rate up to 1Mbps~~
- Wi-Fi
    - 802.11b/g/n
    - 802.11n (2.4 GHz), up to 150 Mbps
    - WMM
    - TX/RX A-MPDU, RX A-MSDU
    - Immediate Block ACK
    - Defragmentation
- Bluetooth
    - Compliant with Bluetooth v4.2 BR/EDR and Bluetooth LE specifications
    - 9 dBm transmitting power


==========
### General hardware design and specifications {id="general-hardware-design-and-specifications_1"}
- RS232
- RS485
- CAN
- Wi-Fi / Bluetooth
- Current loop sensors

### Input / Output {id="input-output_1"}
- 24 Inputs
- 24 Outputs

### Program memory {id="program-memory_1"}
- 4MB of flash for user program storage
- 8MB of external SRAM, used for program and interpreter caching

### Programmability {id="programmability_1"}
- Over the air (OTA) firmware updates
- Built-in optimizing compiler to translate IEC 61131-3 instructions to bytecode which can be loaded faster from Flash.

### Limitations {id="limitations_1"}

- ???