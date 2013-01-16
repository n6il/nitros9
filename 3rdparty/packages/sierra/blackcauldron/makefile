ifndef	NITROS9DIR
NITROS9DIR	= $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DSK_1_40D	= blackcauldron_d1_40d.dsk
DSK_2_40D	= blackcauldron_d2_40d.dsk
DSK_80D		= blackcauldron_80d.dsk
DSK_DW3		= blackcauldron_dw3.dsk
DSK_DW3_BECKER	= blackcauldron_becker.dsk

DSKS		= $(DSK_1_40D) $(DSK_2_40D) $(DSK_80D) $(DSK_DW3) $(DSK_DW3_BECKER)

DSK_1_40D_NAME = "The Black Cauldron Disk 1"
DSK_2_40D_NAME = "The Black Cauldron Disk 2"
DSK_80D_NAME   = "The Black Cauldron"
DSK_DW3_NAME   = $(DSK_80D_NAME)

CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and KERNEL_FLOPPY track
KERNEL_FLOPPY	= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW3	= $(MD)/rel_32 $(MD)/boot_dw3 $(MD)/krn
KERNEL_DW3_BECKER	= $(MD)/rel_32 $(MD)/boot_dw3_becker $(MD)/krn
BOOTFILE_40D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

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

BOOTFILE_DW3_BECKER	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3_becker.sb $(MD)/ddx0.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 $(MD)/sysgo_dd


BOOTCMDS	= $(LEVEL2)/coco3/cmds/shell_21 $(LEVEL2)/coco3/cmds/date \
		$(LEVEL2)/coco3/cmds/echo $(LEVEL2)/coco3/cmds/link \
		$(LEVEL2)/coco3/cmds/setime

TEXTFILES_D1	= ../startup tOC_40d.txt
TEXTFILES	= ../startup tOC_40d.txt

SUPPORTFILES_D1	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 words.tok

SUPPORTFILES_D2	= object vol.0 vol.2

SUPPORTFILES	= $(SUPPORTFILES_D1) $(SUPPORTFILES_D2)

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk_40d:	all
	$(RM) $(DSK_1_40D) $(DSK_2_40D)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS40) -q $(DSK_1_40D) -n$(DSK_1_40D_NAME)
	$(MERGE) $(BOOTFILE_40D)>os9boot
	$(MERGE) $(KERNEL_FLOPPY)>kernel
	$(OS9GEN) $(DSK_1_40D) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DSK_1_40D),CMDS
	$(CP) $(CMDS) $(DSK_1_40D),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DSK_1_40D),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DSK_1_40D),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_1_40D),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_1_40D),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES_D1) $(DSK_1_40D),.
	$(OS9RENAME) $(DSK_1_40D),tOC_40d.txt tOC.txt
	$(CP) $(SUPPORTFILES_D1) $(DSK_1_40D),.
	$(MOVE) tocgen toctmp
	tocgen $(DSK_1_40D),tOC.txt $(DSK_1_40D),tOC
	$(MOVE) toctmp tocgen
	$(OS9FORMAT_DS40) -q $(DSK_2_40D) -n$(DSK_2_40D_NAME)
	$(CP) $(SUPPORTFILES_D2) $(DSK_2_40D),.

dsk_80d:	all
	$(RM) $(DSK_80D)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS80) -q $(DSK_80D) -n$(DSK_80D_NAME)
	$(MERGE) $(BOOTFILE_80D)>os9boot
	$(MERGE) $(KERNEL_FLOPPY)>kernel
	$(OS9GEN) $(DSK_80D) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DSK_80D),CMDS
	$(CP) $(CMDS) $(DSK_80D),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DSK_80D),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DSK_80D),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_80D),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_80D),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DSK_80D),.
	$(OS9RENAME) $(DSK_80D),tOC_40d.txt tOC.txt
	$(CP) $(SUPPORTFILES) $(DSK_80D),.
	$(MOVE) tocgen toctmp
	tocgen $(DSK_80D),tOC.txt $(DSK_80D),tOC
	$(MOVE) toctmp tocgen

dsk_dw3:	all
	$(RM) $(DSK_DW3)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW3) -q $(DSK_DW3) -n$(DSK_DW3_NAME)
	$(MERGE) $(BOOTFILE_DW3)>os9boot
	$(MERGE) $(KERNEL_DW3)>kernel
	$(OS9GEN) $(DSK_DW3) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DSK_DW3),CMDS
	$(CP) $(CMDS) $(DSK_DW3),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DSK_DW3),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DSK_DW3),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_DW3),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_DW3),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DSK_DW3),.
	$(OS9RENAME) $(DSK_DW3),tOC_40d.txt tOC.txt
	$(CP) $(SUPPORTFILES) $(DSK_DW3),.
	$(MOVE) tocgen toctmp
	tocgen $(DSK_DW3),tOC.txt $(DSK_DW3),tOC
	$(MOVE) toctmp tocgen

dsk_dw3_becker:	all
	$(RM) $(DSK_DW3_BECKER)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW3) -q $(DSK_DW3_BECKER) -n$(DSK_DW3_NAME)
	$(MERGE) $(BOOTFILE_DW3_BECKER)>os9boot
	$(MERGE) $(KERNEL_DW3_BECKER)>kernel
	$(OS9GEN) $(DSK_DW3_BECKER) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DSK_DW3_BECKER),CMDS
	$(CP) $(CMDS) $(DSK_DW3_BECKER),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DSK_DW3_BECKER),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DSK_DW3_BECKER),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_DW3_BECKER),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_DW3_BECKER),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DSK_DW3_BECKER),.
	$(OS9RENAME) $(DSK_DW3_BECKER),tOC_40d.txt tOC.txt
	$(CP) $(SUPPORTFILES) $(DSK_DW3_BECKER),.
	$(MOVE) tocgen toctmp
	tocgen $(DSK_DW3_BECKER),tOC.txt $(DSK_DW3_BECKER),tOC
	$(MOVE) toctmp tocgen


dsk:	dsk_40d dsk_80d dsk_dw3 dsk_dw3_becker

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** The Black Cauldron ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
