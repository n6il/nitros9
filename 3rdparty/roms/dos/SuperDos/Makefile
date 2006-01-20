#
# Makefile for SuperDos rom.
#
# 21/11/2004, P.Harvey-Smith.
#

AS=mamou
ASFLAGS=-r 
ZIP=pkzip
RM=rm
FILESD32=dragon32/d32.rom dragon32/ddos10.rom
FILESD64=dragon64/d64_1.rom dragon64/d64_2.rom dragon64/ddos10.rom
FILESTANOD64=tanodr64/d64_1.rom tanodr64/d64_2.rom tanodr64/sdtandy.rom
FILESDALPHA=dgnalpha/alpha_bt.rom dgnalpha/alpha_ba.rom dgnalpha/alpdos10.rom
SUPERDOSASM=superdos-e6-03.asm

all: sdd32 sdd64 sddalpha

alpha: sdos12.asm
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonAlpha=1 -osuperdos-alpha.bin
		
sdos: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonDos=1 -osuperdos-ddos.bin 
		
sdd32: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonDos=1 -odragon32/ddos10.rom 
		$(ZIP) dragon32.zip $(FILESD32)
		
sdd64: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonDos=1 -odragon64/ddos10.rom 
		$(ZIP) dragon64.zip $(FILESD64)
		
sddalpha: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonAlpha=1 -odgnalpha/alpdos10.rom 
		$(ZIP) dgnalpha.zip $(FILESDALPHA)
		
sdtano: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aRSDos=1 -l -otanodr64/sdtandy.rom > superdos.lst
		$(ZIP) tanodr64.zip $(FILESTANOD64)
	
		
listing: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -l -aDragonDos=1 -osuperdos-ddos.bin > superdos.lst
	
		
clean:
		$(RM) -f *.bin
		$(RM) -f *.zip
		