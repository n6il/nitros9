include $(NITROS9DIR)/rules.mak

%.rom:
# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

BOOTFILE_ROM_P1	= $(MD)/krnp2 $(MD)/init \
				$(MD)/ioman $(MD)/scf.mn $(MD)/vtio.dr $(MD)/term.dt \
				$(MD)/sysgo \
				$(MD)/clock_60hz $(MD)/clock2_soft \
				$(MD)/krn

BOOTFILE_ROM_P2	= $(MD)/rbf.mn $(MD)/rbdw3.dr \
                    $(MD)/x0.dd $(MD)/dw3.sb \
                    $(MD)/scdwp.dr $(MD)/p_scdwp.dd \
                    $(CD)/shell_21 $(CD)/dir \
                    $(CD)/mdir $(CD)/dump
                    

BOOTROMS	= nos96809l1.rom liber809.rom

ALLROMS		= $(BOOTROMS)

all:	$(ALLROMS)

# Boot ROMs
liber809.rom: liber809.asm
	$(AS) $(AFLAGS) -mr -I../modules $< $(ASOUT)$@

nos96809l1.rom: $(BOOTFILE_ROM) $(DEPENDS)
	$(MERGE) $(BOOTFILE_ROM_P1)>$@_p1
	$(MERGE) $(BOOTFILE_ROM_P2)>$@_p2
	$(PADROM) -b 10240 $@_p1
	$(PADROM) -b 12288 $@_p1
	$(MERGE) $@_p2 $@_p1>$@
	$(PADROM) -b 32768 $@
	$(CP) $@ nos96809l1.dsk
	$(RM) $@_p2 $@_p1
	
clean:
	$(RM) $(ALLROMS)
