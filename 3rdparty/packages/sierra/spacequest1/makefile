ifndef	NITROS9DIR
NITROS9DIR	= $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DISK_1_40D	= spacequest1_d1_40d.dsk
DISK_2_40D	= spacequest1_d2_40d.dsk
DISK_80D	= spacequest1_80d.dsk
DISK_DW	= spacequest1_dw.dsk

DSKS		= $(DISK_1_40D) $(DISK_2_40D) $(DISK_80D) $(DISK_DW)

DISK_1_40D_NAME	= "Space Quest I Disk 1"
DISK_2_40D_NAME	= "Space Quest I Disk 2"
DISK_80D_NAME	= "Space Quest I"
DISK_DW_NAME	= "Space Quest I"

CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW		= $(MD)/rel_32 $(MD)/boot_dw $(MD)/krn
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

OS9BOOT_DW = $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw.dr $(MD)/dwio.sb $(MD)/ddx0.dd \
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

SUPPORTFILES	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 vol.2 words.tok

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk_40d:	all
	$(RM) $(DISK_1_40D) $(DISK_2_40D)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS40) -q $(DISK_1_40D) -n$(DISK_1_40D_NAME)
	$(OS9FORMAT_DS40) -q $(DISK_2_40D) -n$(DISK_2_40D_NAME)
	$(MERGE) $(OS9BOOT_40D)>os9boot_40d
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK_1_40D) -b=os9boot_40d -t=kernel_1773
	$(RM) os9boot_40d kernel_1773
	$(MAKDIR) $(DISK_1_40D),CMDS
	$(CP) $(CMDS) $(DISK_1_40D),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK_1_40D),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DISK_1_40D),CMDS
	$(RM) shell
	$(OS9ATTR) $(DISK_1_40D),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DISK_1_40D),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES_D1) $(DISK_1_40D),.
	$(OS9RENAME) $(DISK_1_40D),tOC_40d.txt tOC.txt
	$(MOVE) tocgen toctmp
	tocgen $(DISK_1_40D),tOC.txt $(DISK_1_40D),tOC
	$(MOVE) toctmp tocgen
	$(CP) $(SUPPORTFILES_D1) $(DISK_1_40D),.
	$(CP) $(SUPPORTFILES_D2) $(DISK_2_40D),.

dsk_80d:	all
	$(RM) $(DISK_80D)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS80) -q $(DISK_80D) -n$(DISK_80D_NAME)
	$(MERGE) $(OS9BOOT_80D)>os9boot_80d
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK_80D) -b=os9boot_80d -t=kernel_1773
	$(RM) os9boot_80d kernel_1773
	$(MAKDIR) $(DISK_80D),CMDS
	$(CP) $(CMDS) $(DISK_80D),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK_80D),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DISK_80D),CMDS
	$(RM) shell
	$(OS9ATTR) $(DISK_80D),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DISK_80D),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DISK_80D),.
	$(OS9RENAME) $(DISK_80D),tOC_80d.txt tOC.txt
	$(MOVE) tocgen toctmp
	tocgen $(DISK_80D),tOC.txt $(DISK_80D),tOC
	$(MOVE) toctmp tocgen
	$(CP) $(SUPPORTFILES) $(DISK_80D),.

dsk_dw:	all
	$(RM) $(DISK_DW)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW) -q $(DISK_DW) -n$(DISK_DW_NAME)
	$(MERGE) $(OS9BOOT_DW)>os9boot_dw
	$(MERGE) $(KERNEL_DW)>kernel_dw
	$(OS9GEN) $(DISK_DW) -b=os9boot_dw -t=kernel_dw
	$(RM) os9boot_dw kernel_dw
	$(MAKDIR) $(DISK_DW),CMDS
	$(CP) $(CMDS) $(DISK_DW),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK_DW),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DISK_DW),CMDS
	$(RM) shell
	$(OS9ATTR) $(DISK_DW),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DISK_DW),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DISK_DW),.
	$(OS9RENAME) $(DISK_DW),tOC_80d.txt tOC.txt
	$(RM) tocgen
	tocgen $(DISK_DW),tOC.txt $(DISK_DW),tOC
	$(CP) $(SUPPORTFILES) $(DISK_DW),.


dsk:	dsk_40d dsk_80d dsk_dw

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** Space Quest I ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)

