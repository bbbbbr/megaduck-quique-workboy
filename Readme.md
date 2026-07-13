
# Workboy running on the Mega Duck Laptop
A port / rom patch of the fabled Game Boy Workboy accessory to the MegaDuck Super Quique / Super Junior Computer clone console.

### Keyboard
* Mega Duck -> Shift: Selects between Mega Duck regular keys vs alternates (printed on keyboard)
* Mega Duck -> Caps Lock: Selects between Workboy regular keys vs alternates (printed on keyboard). When pressed down it emulates a Workboy `NUM` button press, and when released it emulates the a `CAPS` button press.

### Thanks, References, Tools
- [Same Boy](https://github.com/LIJI32/SameBoy) / LIJI32 : Same Boy emu and Workboy reference
  - [Super Junior Same Duck](https://github.com/bbbbbr/SuperJuniorSameDuck): My fork of Same Boy with Mega Duck laptop emulation
- Liam Robertson's [research and documentary](https://www.youtube.com/watch?v=SZcrPM-jDqY)
- [Emulicious](https://emulicious.net): Game Boy emulator with a very useful debugger and disassembler
- [RGBDS](https://rgbds.gbdev.io) assembler

### Building
Prereq: rgbds 0.6.0 (in the system path)

`make duck` to build the Mega Duck patched ROM
