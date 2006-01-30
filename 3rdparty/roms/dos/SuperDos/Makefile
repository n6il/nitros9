#
# Makefile for SuperDos rom.
#
# 21/11/2004, P.Harvey-Smith.
#
# 2006-01-16, P.Harvey-Smith, added support for RS-DOS cartrage on Tano.
#
# 2006-01-30, P.Harvey-Smith, added support for RS-DOS cartrage on CoCo.
#

AS=mamou
ASFLAGS=-r 
ZIP=pkzip
RM=rm
FILESD32=dragon32/d32.rom dragon32/ddos10.rom
FILESD64=dragon64/d64_1.rom dragon64/d64_2.rom dragon64/ddos10.rom
FILESTANOD64=tanodr64/d64_1.rom tanodr64/d64_2.rom tanodr64/sdtandy.rom
FILESDALPHA=dgnalpha/alpha_bt.rom dgnalpha/alpha_ba.rom dgnalpha/alpdos10.rom
FILESCOCO2=coco2/bas12.rom coco2/extbas11.rom coco2/disk11.rom
SUPERDOSASM=superdos-e6-03.asm

all: sdd32 sdd64 sddalpha

alpha: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonAlpha=1 -aDragon=1 -osuperdos-alpha.bin
		
sdos: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonDos=1 -aDragon=1 -osuperdos-ddos.bin 

sdcoco: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aRSDos=1 -aTandy=1 -osuperdos-tandy.rom 
		
sdd32: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonDos=1 -aDragon=1 -odragon32/ddos10.rom 
		$(ZIP) dragon32.zip $(FILESD32)
		
sdd64: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonDos=1 -aDragon=1 -odragon64/ddos10.rom 
		$(ZIP) dragon64.zip $(FILESD64)
		
sddalpha: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aDragonAlpha=1 -aDragon=1 -odgnalpha/alpdos10.rom 
		$(ZIP) dgnalpha.zip $(FILESDALPHA)
		
sdtano: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aRSDos=1 -aDragon=1 -otanodr64/sdtandy.rom 
		$(ZIP) tanodr64.zip $(FILESTANOD64)
	
sdcoco2: $(SUPERDOSASM) 
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -aRSDos=1 -l -aTandy=1 -ococo2/disk11.rom > superdos.lst
		$(ZIP) coco2.zip $(FILESCOCO2)
 
	

		
listing: $(SUPERDOSASM)
		$(AS) $(SUPERDOSASM) $(ASFLAGS) -l -aDragonDos=1 -aDragon=1 -osuperdos-ddos.bin > superdos.lst
	
		
clean:
		$(RM) -f *.bin
		$(RM) -f *.zip
		