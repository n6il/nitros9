ifndef	NITROS9DIR
NITROS9DIR	= $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DISK_40D	= kingsquest1_40d.dsk
DSKDW3		= kingsquest1_dw3.dsk

DSKS		= $(DISK_40D) $(DSKDW3)

DISK_40D_NAME	= "King's Quest I"
DSKDW3_NAME	= $(DISK_40D_NAME)

CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and kernel track
KERNEL_FLOPPY	= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW3	= $(MD)/rel_32 $(MD)/boot_dw3 $(MD)/krn

BOOTFILE_40D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

BOOTFILE_DW3	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3.sb $(MD)/ddx0.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 $(MD)/sysgo_dd

BOOTCMDS	= $(LEVEL2)/coco3/cmds/shell_21 $(LEVEL2)/coco3/cmds/date \
		$(LEVEL2)/coco3/cmds/echo $(LEVEL2)/coco3/cmds/link \
		$(LEVEL2)/coco3/cmds/setime

TEXTFILES	= ../startup tOC_40d.txt

SUPPORTFILES	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 vol.2 words.tok

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all $(DISK_40D) $(DSKDW3)

$(DISK_40D):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS40) -q $@ -n$(DISK_40D_NAME)
	$(MERGE) $(BOOTFILE_40D)>os9boot
	$(MERGE) $(KERNEL_FLOPPY)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(CP) $(CMDS) $@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $@,CMDS
	$(RM) shell
	$(OS9ATTR) $@,CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $@,CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $@,.
	$(OS9RENAME) $@,tOC_40d.txt tOC.txt
	$(MOVE) tocgen toctmp
	tocgen $@,tOC.txt $@,tOC
	$(MOVE) toctmp tocgen
	$(CP) $(SUPPORTFILES) $@,.

$(DSKDW3):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW3) -q $@ -n$(DISK_40D_NAME)
	$(MERGE) $(BOOTFILE_DW3)>os9boot
	$(MERGE) $(KERNEL_DW3)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(CP) $(CMDS) $@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $@,CMDS
	$(RM) shell
	$(OS9ATTR) $@,CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $@,CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $@,.
	$(OS9RENAME) $@,tOC_40d.txt tOC.txt
	$(RM) tocgen
	tocgen $@,tOC.txt $@,tOC
	$(CP) $(SUPPORTFILES) $@,.

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** King's Quest I ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
