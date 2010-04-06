ifndef	NITROS9DIR
NITROS9DIR	= $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DSKDW3		= goldrush_dw3.dsk
DISK_1_80D	= goldrush_d1_80d.dsk
DISK_2_80D	= goldrush_d2_80d.dsk
DISK_3_80D	= goldrush_d3_80d.dsk

DSKS		= $(DISK_1_80D) $(DISK_2_80D) $(DISK_3_80D) $(DSKDW3)

DISK_1_80D_NAME = "Gold Rush Disk 1"
DISK_2_80D_NAME = "Gold Rush Disk 2"
DISK_3_80D_NAME = "Gold Rush Disk 3"
DSKDW3_NAME	= "Gold Rush"

CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and kernel track
KERNEL_FLOPPY	= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW3	= $(MD)/rel_32 $(MD)/boot_dw3 $(MD)/krn
BOOTFILE_80D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_80d.dd \
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

TEXTFILES_D1	= startup tOC_80d.txt
TEXTFILES_DW3	= startup tOC_dw3.txt

SUPPORTFILES_D1	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 vol.2 vol.9 vol.10 vol.11 vol.12 words.tok

SUPPORTFILES_D2	= object vol.0 vol.3 vol.9 vol.11

SUPPORTFILES_D3	= object vol.0 vol.4 vol.5 vol.9 vol.11 vol.12

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all $(DSKDW3) $(DISK_1_80D) $(DISK_2_80D) $(DISK_3_80D)

$(DSKDW3):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW3) -q $@ -n$(DSKDW3_NAME)
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
	$(CPL) $(TEXTFILES_DW3) $@,.
	$(OS9RENAME) $@,tOC_dw3.txt tOC.txt
	$(CP) $(SUPPORTFILES_D1) $@,.
	$(CP) $(SUPPORTFILES_D2) $@,.
	$(CP) $(SUPPORTFILES_D3) $@,.
	$(MOVE) tocgen toctmp
	tocgen $@,tOC.txt $@,tOC

$(DISK_1_80D):
	$(RM) $@
	$(MOVE) toctmp tocgen
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS80) -q $@ -n$(DISK_1_80D_NAME)
	$(MERGE) $(BOOTFILE_80D)>os9boot
	$(MERGE) $(KERNEL_FLOPPY)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot_80d os9boot_80d kernel_1773
	$(MAKDIR) $@,CMDS
	$(CP) $(CMDS) $@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $@,CMDS
	$(RM) shell
	$(OS9ATTR) $@,CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $@,CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES_D1) $@,.
	$(OS9RENAME) $@,tOC_80d.txt tOC.txt
	$(CP) $(SUPPORTFILES_D1) $@,.
	$(RM) tocgen
	tocgen $@,tOC.txt $@,tOC


$(DISK_2_80D):
	$(RM) $@
	$(OS9FORMAT_DS80) -q $@ -n$(DISK_2_80D_NAME)
	$(CP) $(SUPPORTFILES_D2) $@,.

$(DISK_3_80D):
	$(RM) $@
	$(OS9FORMAT_DS80) -q $@ -n$(DISK_3_80D_NAME)
	$(CP) $(SUPPORTFILES_D3) $@,.

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** Gold Rush ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
