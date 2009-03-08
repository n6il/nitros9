********************************************************************
* dwdefs - DriveWire Definitions File
*
* $Id$
*
* Ed.    Comments                                       Who YY/MM/DD
* ------------------------------------------------------------------
*   1    Started                                        BGP 03/04/03

         nam   dwdefs
         ttl   DriveWire Definitions File

* Opcodes
OP_NOP      equ    $00		No-Op
OP_RESET1   equ    $FE		Server Reset
OP_RESET2   equ    $FF		Server Reset
OP_TIME     equ   '#	 	Current time requested
OP_INIT     equ   'I		Init routine called
OP_READ     equ   'R		Read one sector
OP_REREAD   equ   'r		Re-read one sector
OP_READEX   equ   'R+128	Read one sector
OP_REREADEX equ   'r+128	Re-read one sector
OP_WRITE    equ   'W		Write one sector
OP_REWRIT   equ   'w		Re-write one sector
OP_GETSTA   equ   'G		GetStat routine called
OP_SETSTA   equ   'S		SetStat routine called
OP_TERM     equ   'T		Term routine called

* Printer opcodes
OP_PRINT    equ   'P		Print byte to the print buffer
OP_PRINTFLUSH equ 'F		Flush the server print buffer

* WireBug opcodes (Server-initiated)
OP_WIREBUG_MODE  equ   'B
* WireBug opcodes (Server-initiated)
OP_WIREBUG_READREGS   equ  'R	Read the CoCo's registers
OP_WIREBUG_WRITEREGS  equ  'r	Write the CoCo's registers
OP_WIREBUG_READMEM    equ  'M	Read the CoCo's memory
OP_WIREBUG_WRITEMEM   equ  'm	Write the CoCo's memory
OP_WIREBUG_GO         equ  'G	Tell CoCo to get out of WireBug mode and continue execution

* Error definitions
E_CRC      equ   $F3            Same as NitrOS-9 E$CRC
