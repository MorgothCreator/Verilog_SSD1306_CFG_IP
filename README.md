# Verilog_SPI_MASTER_INTERFACE
FPGA SPI MODULE

This is a hardware SPI interface optimized for Artix-7 FPGA.

The test and simulation library is a SSD1306 driver configured for <a href="http://store.digilentinc.com/nexys-video-artix-7-fpga-trainer-board-for-multimedia-applications/">DIGILENT Nexis Video Artix-7 FPGA.</a> board.

The SSD1306 driver generates all signals to power up initialize and clear the video ram on the display.

Down is the description of .mem file that contain all steps to configure and clear the video ram of the SSD1306 display device, the ROM memory is configured as 48bit word length, the config library is made to read a script from memory with loops and jump instructions.

Jump offset[4]|Exec time[28]|Data[8]|Load|VDD|VBAT|RES|D/C|WR|RD|WAIT SPI|Description
-|-|-|-|-|-|-|-|-|-|-|-
1h|0000000h|00h|0|1|1|1|0|0|0|0|All inactive
1h|0000010h|00h|0|0|1|1|0|0|0|0|Apply vdd
1h|0011020h|00h|0|0|1|0|0|0|0|0|Assert reset
1h|0011030h|00h|0|0|1|1|0|0|0|0|Deasert reset
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022000h|8Dh|0|0|1|1|0|0|0|0|Put 8Dh to spi
1h|0022001h|8Dh|0|0|1|1|0|1|0|0|Assert WR
1h|0022002h|8Dh|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022003h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022004h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022010h|14h|0|0|1|1|0|0|0|0|Put 14h to spi
1h|0022011h|14h|0|0|1|1|0|1|0|0|Assert WR
1h|0022012h|14h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022013h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022014h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022020h|D9h|0|0|1|1|0|0|0|0|Put D9h to spi
1h|0022021h|D9h|0|0|1|1|0|1|0|0|Assert WR
1h|0022022h|D9h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022023h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022024h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022030h|F1h|0|0|1|1|0|0|0|0|Put F1h to spi
1h|0022031h|F1h|0|0|1|1|0|1|0|0|Assert WR
1h|0022032h|F1h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022033h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022034h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022040h|81h|0|0|1|1|0|0|0|0|Put 81h to spi
1h|0022041h|81h|0|0|1|1|0|1|0|0|Assert WR
1h|0022042h|81h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022043h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022044h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022050h|0Fh|0|0|1|1|0|0|0|0|Put 0Fh to spi
1h|0022051h|0Fh|0|0|1|1|0|1|0|0|Assert WR
1h|0022052h|0Fh|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022053h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022054h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022060h|A0h|0|0|1|1|0|0|0|0|Put A0h to spi
1h|0022061h|A0h|0|0|1|1|0|1|0|0|Assert WR
1h|0022062h|A0h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022063h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022064h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022070h|C0h|0|0|1|1|0|0|0|0|Put C0h to spi
1h|0022071h|C0h|0|0|1|1|0|1|0|0|Assert WR
1h|0022072h|C0h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022073h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022074h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022080h|DAh|0|0|1|1|0|0|0|0|Put DAh to spi
1h|0022081h|DAh|0|0|1|1|0|1|0|0|Assert WR
1h|0022082h|DAh|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022083h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022084h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|0022090h|00h|0|0|1|1|0|0|0|0|Put 00h to spi
1h|0022091h|00h|0|0|1|1|0|1|0|0|Assert WR
1h|0022092h|00h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|0022093h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|0022094h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|00220A0h|20h|0|0|1|1|0|0|0|0|Put 20h to spi
1h|00220A1h|20h|0|0|1|1|0|1|0|0|Assert WR
1h|00220A2h|20h|0|0|1|1|0|0|0|1|Deasert WR and wait SPI finish
1h|00220A3h|00h|0|0|1|1|0|0|1|0|Assert RD
1h|00220A4h|00h|0|0|1|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|00020A8h|00h|0|0|0|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|00BDE00h|00h|0|0|0|1|0|0|0|0|Put 00h to spi to set SETLOWCOLUMN
1h|00BDE01h|00h|0|0|0|1|0|1|0|0|Assert WR
1h|00BDE02h|00h|0|0|0|1|0|0|0|1|Deasert WR and wait SPI finish
1h|00BDE03h|00h|0|0|0|1|0|0|1|0|Assert RD
1h|00BDE04h|00h|0|0|0|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|00BDE10h|10h|0|0|0|1|0|0|0|0|Put 10h to spi to set SETHIGHCOLUMN
1h|00BDE11h|10h|0|0|0|1|0|1|0|0|Assert WR
1h|00BDE12h|10h|0|0|0|1|0|0|0|1|Deasert WR and wait SPI finish
1h|00BDE13h|00h|0|0|0|1|0|0|1|0|Assert RD
1h|00BDE14h|00h|0|0|0|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|00BDE20h|40h|0|0|0|1|0|0|0|0|Put 40h to spi to set SETSTARTLINE
1h|00BDE21h|40h|0|0|0|1|0|1|0|0|Assert WR
1h|00BDE22h|40h|0|0|0|1|0|0|0|1|Deasert WR and wait SPI finish
1h|00BDE23h|00h|0|0|0|1|0|0|1|0|Assert RD
1h|00BDE24h|00h|0|0|0|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
1h|00BDE28h|00h|1|0|0|0|0|0|1|0|Load repeat count with 512.
-|-|-|-|-|-|-|-|-|-|-|-
1h|00BDE30h|FFh|0|0|0|1|1|0|0|0|Put FFh to spi to clear vram, and set to data
1h|00BDE31h|FFh|0|0|0|1|1|1|0|0|Assert WR
1h|00BDE32h|FFh|0|0|0|1|1|0|0|1|Deasert WR and wait SPI finish
1h|00BDE33h|00h|0|0|0|1|1|0|1|0|Assert RD
(-5)Bh|00BDE34h|00h|0|0|0|1|1|0|0|0|Deasert RD, and repeat from -5.
-|-|-|-|-|-|-|-|-|-|-|-
1h|00BDE40h|AFh|0|0|0|1|0|0|0|0|Put AFh to spi to enable display, and set to cmd
1h|00BDE41h|AFh|0|0|0|1|0|1|0|0|Assert WR
1h|00BDE42h|AFh|0|0|0|1|0|0|0|1|Deasert WR and wait SPI finish
1h|00BDE43h|00h|0|0|0|1|0|0|1|0|Assert RD
1h|00BDE44h|00h|0|0|0|1|0|0|0|0|Deasert RD
-|-|-|-|-|-|-|-|-|-|-|-
0h|00BDE45h|00h|0|0|0|1|1|0|0|0|Infinite loop (STOP)

Repeat count = {rom_bus[6:0], rom_bus[15:8]}.

A bounch of lines can be repeated of maximum 32767 times.

The maximum jump is -7 to +7 lines
