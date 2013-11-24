ifndef	NITROS9DIR
NITROS9DIR	= $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DISK_1_40D	= spacequest2_d1_40d.dsk
DISK_2_40D	= spacequest2_d2_40d.dsk
DISK_3_40D	= spacequest2_d3_40d.dsk
DISK_80D	= spacequest2_80d.dsk
DISK_DW	= spacequest2_dw.dsk
DISK_DW_BECKER	= spacequest2_becker.dsk

DSKS		= $(DISK_1_40D) $(DISK_2_40D) $(DISK_3_40D) $(DISK_80D) \
		$(DISK_DW) $(DISK_DW_BECKER)

DISK_1_40D_NAME = "Space Quest II Disk 1"
DISK_2_40D_NAME = "Space Quest II Disk 2"
DISK_3_40D_NAME = "Space Quest II Disk 3"
DISK_80D_NAME   = "Space Quest II"
DISK_DW_NAME   = "Space Quest II"

CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW	= $(MD)/rel_32 $(MD)/boot_dw $(MD)/krn
KERNEL_DW_BECKER	= $(MD)/rel_32 $(MD)/boot_dw_becker $(MD)/krn

OS9BOOT_40D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

OS9BOOT_80D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_80d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

OS9BOOT_DW	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw.dr $(MD)/dwio.sb $(MD)/ddx0.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw $(MD)/sysgo_dd

OS9BOOT_DW_BECKER	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw.dr $(MD)/dwio_becker.sb $(MD)/ddx0.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw $(MD)/sysgo_dd

BOOTCMDS	= $(LEVEL2)/coco3/cmds/shell_21 $(LEVEL2)/coco3/cmds/date \
		$(LEVEL2)/coco3/cmds/echo $(LEVEL2)/coco3/cmds/link \
		$(LEVEL2)/coco3/cmds/setime

TEXTFILES_D1	= ../startup tOC_40d.txt
TEXTFILES	= ../startup tOC_80d.txt

SUPPORTFILES_D1	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 words.tok

SUPPORTFILES_D2	= object vol.0 vol.2

SUPPORTFILES_D3	= object vol.0 vol.3

SUPPORTFILES	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 vol.2 vol.3 words.tok

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

$(DISK_1_40D):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS40) -q $(DISK_1_40D) -n$(DISK_1_40D_NAME)
	$(MERGE) $(OS9BOOT_40D)>os9boot
	$(MERGE) $(KERNEL)>kernel
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
	$(CPL) $(TEXTFILES_D1) $@,.
	$(OS9RENAME) $@,tOC_40d.txt tOC.txt
	$(CP) $(SUPPORTFILES_D1) $@,.
	$(MOVE) tocgen toctmp
	tocgen $@,tOC.txt $@,tOC
	$(MOVE) toctmp tocgen

$(DISK_2_40D):
	$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n$(DISK_2_40D_NAME)
	$(CP) $(SUPPORTFILES_D2) $@,.

$(DISK_3_40D):
	$(RM) $@
	$(OS9FORMAT_DS40) -q $@ -n$(DISK_3_40D_NAME)
	$(CP) $(SUPPORTFILES_D3) $@,.

$(DISK_80D):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS80) -q $@ -n$(DISK_80D_NAME)
	$(MERGE) $(OS9BOOT_80D)>os9boot
	$(MERGE) $(KERNEL)>kernel
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
	$(OS9RENAME) $@,tOC_80d.txt tOC.txt
	$(CP) $(SUPPORTFILES) $@,.
	$(MOVE) tocgen toctmp
	tocgen $@,tOC.txt $@,tOC
	$(MOVE) toctmp tocgen

$(DISK_DW):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW) -q $@ -n$(DISK_DW_NAME)
	$(MERGE) $(OS9BOOT_DW)>os9boot
	$(MERGE) $(KERNEL_DW)>kernel
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
	$(OS9RENAME) $@,tOC_80d.txt tOC.txt
	$(MOVE) tocgen toctmp
	tocgen $@,tOC.txt $@,tOC
	$(MOVE) toctmp tocgen
	$(CP) $(SUPPORTFILES) $@,.

$(DISK_DW_BECKER):
	$(RM) $@
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW) -q $@ -n$(DISK_DW_NAME)
	$(MERGE) $(OS9BOOT_DW_BECKER)>os9boot
	$(MERGE) $(KERNEL_DW_BECKER)>kernel
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
	$(OS9RENAME) $@,tOC_80d.txt tOC.txt
	$(MOVE) tocgen toctmp
	tocgen $@,tOC.txt $@,tOC
	$(MOVE) toctmp tocgen
	$(CP) $(SUPPORTFILES) $@,.

dsk:	all $(DSKS)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** Space Quest II ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
