include ../../../../rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DSK_1_40D	= blackcauldron_d1_40d.dsk
DSK_2_40D	= blackcauldron_d2_40d.dsk
DSK_80D		= blackcauldron_80d.dsk
DSK_DW		= blackcauldron_dw.dsk
DSK_DW_BECKER	= blackcauldron_becker.dsk

DSKS		= $(DSK_1_40D) $(DSK_2_40D) $(DSK_80D) $(DSK_DW) $(DSK_DW_BECKER)

DSK_1_40D_NAME = "The Black Cauldron Disk 1"
DSK_2_40D_NAME = "The Black Cauldron Disk 2"
DSK_80D_NAME   = "The Black Cauldron"
DSK_DW_NAME   = $(DSK_80D_NAME)

CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and KERNEL_FLOPPY track
KERNEL_FLOPPY	= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn
KERNEL_DW	= $(MD)/rel_32 $(MD)/boot_dw $(MD)/krn
KERNEL_DW_BECKER	= $(MD)/rel_32 $(MD)/boot_dw_becker $(MD)/krn
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

BOOTFILE_DW	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw.dr $(MD)/dwio.sb $(MD)/ddx0.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw $(MD)/sysgo_dd

BOOTFILE_DW_BECKER	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
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
TEXTFILES	= ../startup tOC_40d.txt

SUPPORTFILES_D1	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 words.tok

SUPPORTFILES_D2	= object vol.0 vol.2

SUPPORTFILES	= $(sort $(SUPPORTFILES_D1) $(SUPPORTFILES_D2))

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
	$(OS9COPY) $(CMDS) $(DSK_1_40D),CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$(DSK_1_40D),CMDS/$(file))
	$(MERGE) $(BOOTCMDS)>shell
	$(OS9COPY) shell $(DSK_1_40D),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_1_40D),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_1_40D),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES_D1) $(DSK_1_40D),.
	$(OS9RENAME) $(DSK_1_40D),tOC_40d.txt tOC.txt
	$(OS9COPY) $(SUPPORTFILES_D1) $(DSK_1_40D),.
	$(MOVE) tocgen toctmp	# to not confuse Windows hosts
	tocgen $(DSK_1_40D),tOC.txt $(DSK_1_40D),tOC
	$(MOVE) toctmp tocgen
	$(OS9FORMAT_DS40) -q $(DSK_2_40D) -n$(DSK_2_40D_NAME)
	$(OS9COPY) $(SUPPORTFILES_D2) $(DSK_2_40D),.

dsk_80d:	all
	$(RM) $(DSK_80D)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS80) -q $(DSK_80D) -n$(DSK_80D_NAME)
	$(MERGE) $(BOOTFILE_80D)>os9boot
	$(MERGE) $(KERNEL_FLOPPY)>kernel
	$(OS9GEN) $(DSK_80D) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DSK_80D),CMDS
	$(OS9COPY) $(CMDS) $(DSK_80D),CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$(DSK_80D),CMDS/$(file))
	$(MERGE) $(BOOTCMDS)>shell
	$(OS9COPY) shell $(DSK_80D),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_80D),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_80D),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DSK_80D),.
	$(OS9RENAME) $(DSK_80D),tOC_40d.txt tOC.txt
	$(OS9COPY) $(SUPPORTFILES) $(DSK_80D),.
	$(MOVE) tocgen toctmp	# to not confuse Windows hosts
	tocgen $(DSK_80D),tOC.txt $(DSK_80D),tOC
	$(MOVE) toctmp tocgen

dsk_dw:	all
	$(RM) $(DSK_DW)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW) -q $(DSK_DW) -n$(DSK_DW_NAME)
	$(MERGE) $(BOOTFILE_DW)>os9boot
	$(MERGE) $(KERNEL_DW)>kernel
	$(OS9GEN) $(DSK_DW) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DSK_DW),CMDS
	$(OS9COPY) $(CMDS) $(DSK_DW),CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$(DSK_DW),CMDS/$(file))
	$(MERGE) $(BOOTCMDS)>shell
	$(OS9COPY) shell $(DSK_DW),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_DW),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_DW),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DSK_DW),.
	$(OS9RENAME) $(DSK_DW),tOC_40d.txt tOC.txt
	$(OS9COPY) $(SUPPORTFILES) $(DSK_DW),.
	$(MOVE) tocgen toctmp	# to not confuse Windows hosts
	tocgen $(DSK_DW),tOC.txt $(DSK_DW),tOC
	$(MOVE) toctmp tocgen

dsk_dw_becker:	all
	$(RM) $(DSK_DW_BECKER)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW) -q $(DSK_DW_BECKER) -n$(DSK_DW_NAME)
	$(MERGE) $(BOOTFILE_DW_BECKER)>os9boot
	$(MERGE) $(KERNEL_DW_BECKER)>kernel
	$(OS9GEN) $(DSK_DW_BECKER) -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $(DSK_DW_BECKER),CMDS
	$(OS9COPY) $(CMDS) $(DSK_DW_BECKER),CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(CMDS),$(DSK_DW_BECKER),CMDS/$(file))
	$(MERGE) $(BOOTCMDS)>shell
	$(OS9COPY) shell $(DSK_DW_BECKER),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_DW_BECKER),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_DW_BECKER),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DSK_DW_BECKER),.
	$(OS9RENAME) $(DSK_DW_BECKER),tOC_40d.txt tOC.txt
	$(OS9COPY) $(SUPPORTFILES) $(DSK_DW_BECKER),.
	$(MOVE) tocgen toctmp	# to not confuse Windows hosts
	tocgen $(DSK_DW_BECKER),tOC.txt $(DSK_DW_BECKER),tOC
	$(MOVE) toctmp tocgen


dsk:	dsk_40d dsk_80d dsk_dw dsk_dw_becker

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** The Black Cauldron ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
