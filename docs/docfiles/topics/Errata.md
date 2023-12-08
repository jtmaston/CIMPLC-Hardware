# Errata

1. **Output pins left undefined in logic level "False state":** <br/> {id="ov1"}
   Due to the fast development cycle and my inexperience with electronics, an oversight was introduced, which means that
   pin states are not well-defined: they are either at 24v, or at ???. This is due to lack of any mechanism to pull to
   ground, which also means that the outputs are only able to source current, not sink. The implementation, using
   solid-state relays, allow to source +24v when the pin is driven high, but otherwise leaves the pin floating.
2. **Commands sent to the ESP32 for programming via USB get sent to the RS232 bus, and vice-versa**<br/>
   Due to the reusing of pins, during initial programming (via the bootloader), commands sent to the ESP32 are also
   sent to the RS232 transceiver, which relays them onto the bus. This results in unwanted noise, but also note that
   other devices on the bus might also hamper program upload if connected and active. It is advised to disconnect the
   PLC during factory firmware programming. Please note that OTA (Over-The-Air) programming is unaffected by this bug.

3. **External power delivery required:**<br/> {id="ov2"}
   Similarly, due to my inexperience, I avoided implementing onboard power management, relying on an external +24v power
   supply, able to drive the pin outputs, as well as a +5v rail to power the control side.

4. **CAN Interface rendered unusable due to strapping pins** <br/> {id="ov3"}
   An oversight has been the fact that strapping pins 0 and 2 have been used, which control going into the bootloader.
   As such, all reboots would necessitate the CANH line being high. With that in mind, for this version,
   it has been removed and functionality abandoned.