include ../../../../rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DISK_1_40D	= kingsquest3_d1_40d.dsk
DISK_2_40D	= kingsquest3_d2_40d.dsk
DISK_3_40D	= kingsquest3_d3_40d.dsk
DISK_80D	= kingsquest3_80d.dsk
DSK_DW		= kingsquest3_dw.dsk
DSK_DW_BECKER	= kingsquest3_becker.dsk

DSKS		= $(DISK_1_40D) $(DISK_2_40D) $(DISK_3_40D) $(DISK_80D) $(DSK_DW) $(DSK_DW_BECKER)

DISK_1_40D_NAME = "King's Quest III Disk 1"
DISK_2_40D_NAME = "King's Quest III Disk 2"
DISK_3_40D_NAME = "King's Quest III Disk 3"
DISK_80D_NAME   = "King's Quest III"
DSK_DW_NAME	= "King's Quest III"

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
TEXTFILES	= ../startup tOC_80d.txt
TEXTFILES_DW = ../startup tOC_dw.txt

SUPPORTFILES_D1	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 vol.2 vol.3 vol.4 vol.12 vol.14 words.tok

SUPPORTFILES_D2	= object vol.0 vol.5 vol.6 vol.7 vol.8 vol.11 vol.12 vol.14

SUPPORTFILES_D3	= object vol.0 vol.5 vol.6 vol.7 vol.9 vol.11 vol.12 vol.14

SUPPORTFILES	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 vol.2 vol.3 vol.4 vol.5 vol.6 vol.7 vol.8 vol.9 \
		vol.11 vol.12 vol.14 words.tok

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk_40d:	all
	$(RM) $(DISK_1_40D) $(DISK_2_40D) $(DISK_3_40D)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS40) -q $(DISK_1_40D) -n$(DISK_1_40D_NAME)
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
	$(CP) $(SUPPORTFILES_D1) $(DISK_1_40D),.
	$(MOVE) tocgen toctmp
	tocgen $(DISK_1_40D),tOC.txt $(DISK_1_40D),tOC
	$(MOVE) toctmp tocgen
	$(OS9FORMAT_DS40) -q $(DISK_2_40D) -n$(DISK_2_40D_NAME)
	$(CP) $(SUPPORTFILES_D2) $(DISK_2_40D),.
	$(OS9FORMAT_DS40) -q $(DISK_3_40D) -n$(DISK_3_40D_NAME)
	$(CP) $(SUPPORTFILES_D3) $(DISK_3_40D),.

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
	$(CP) $(SUPPORTFILES) $(DISK_80D),.
	$(MOVE) tocgen toctmp
	tocgen $(DISK_80D),tOC.txt $(DISK_80D),tOC
	$(MOVE) toctmp tocgen

dsk_dw:	all
	$(RM) $(DSK_DW)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW) -q $(DSK_DW) -n$(DSK_DW_NAME)
	$(MERGE) $(BOOTFILE_DW)>os9boot_dw
	$(MERGE) $(KERNEL_DW)>kernel_dw
	$(OS9GEN) $(DSK_DW) -b=os9boot_dw -t=kernel_dw
	$(RM) os9boot_dw kernel_dw
	$(MAKDIR) $(DSK_DW),CMDS
	$(CP) $(CMDS) $(DSK_DW),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DSK_DW),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DSK_DW),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_DW),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_DW),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES_DW) $(DSK_DW),.
	$(OS9RENAME) $(DSK_DW),tOC_dw.txt tOC.txt
	$(CP) $(SUPPORTFILES) $(DSK_DW),.
	$(MOVE) tocgen toctmp
	tocgen $(DSK_DW),tOC.txt $(DSK_DW),tOC
	$(MOVE) toctmp tocgen

dsk_dw_becker:	all
	$(RM) $(DSK_DW_BECKER)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DW) -q $(DSK_DW_BECKER) -n$(DSK_DW_NAME)
	$(MERGE) $(BOOTFILE_DW_BECKER)>os9boot_dw
	$(MERGE) $(KERNEL_DW_BECKER)>kernel_dw
	$(OS9GEN) $(DSK_DW_BECKER) -b=os9boot_dw -t=kernel_dw
	$(RM) os9boot_dw kernel_dw
	$(MAKDIR) $(DSK_DW_BECKER),CMDS
	$(CP) $(CMDS) $(DSK_DW_BECKER),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DSK_DW_BECKER),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DSK_DW_BECKER),CMDS
	$(RM) shell
	$(OS9ATTR) $(DSK_DW_BECKER),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DSK_DW_BECKER),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES_DW) $(DSK_DW_BECKER),.
	$(OS9RENAME) $(DSK_DW_BECKER),tOC_dw.txt tOC.txt
	$(CP) $(SUPPORTFILES) $(DSK_DW_BECKER),.
	$(MOVE) tocgen toctmp
	tocgen $(DSK_DW_BECKER),tOC.txt $(DSK_DW_BECKER),tOC
	$(MOVE) toctmp tocgen

dsk:	dsk_40d dsk_80d dsk_dw dsk_dw_becker

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** King's Quest III ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
