include $(NITROS9DIR)/rules.mak

vpath %.asm ../objs_lsl

DEPENDS		= ./makefile

DISK_40D	= kingsquest1_40d.dsk

DSKS		= $(DISK_40D)

DISK_40D_NAME	= "King's Quest I"

CMDS		= sierra mnln scrn shdw tocgen
MD		= $(LEVEL2)/coco3/modules

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_32 $(MD)/boot_1773_6ms $(MD)/krn

OS9BOOT_40D	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rb1773.dr $(MD)/ddd0_40d.dd \
		$(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
		$(MD)/covdg_small.io $(MD)/term_vdg.dt \
		$(MD)/vrn.dr $(MD)/vi.dd \
		$(MD)/clock_60hz $(MD)/clock2_soft $(MD)/sysgo_dd

BOOTCMDS	= $(LEVEL2)/coco3/cmds/shell_21 $(LEVEL2)/coco3/cmds/date \
		$(LEVEL2)/coco3/cmds/echo $(LEVEL2)/coco3/cmds/link \
		$(LEVEL2)/coco3/cmds/setime

TEXTFILES	= startup tOC_40d.txt

SUPPORTFILES	= logDir object picDir sndDir viewDir vol.0 \
		vol.1 vol.2 words.tok

ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK_40D)
	$(CD) $(LEVEL2)/coco3; make
	$(OS9FORMAT_DS40) -q $(DISK_40D) -n$(DISK_40D_NAME)
	$(OS9FORMAT_DS40) -q $(DISK_2_40D) -n$(DISK_2_40D_NAME)
	$(MERGE) $(OS9BOOT_40D)>os9boot_40d
	$(MERGE) $(KERNEL)>kernel_1773
	$(OS9GEN) $(DISK_40D) -b=os9boot_40d -t=kernel_1773
	$(RM) os9boot_40d kernel_1773
	$(MAKDIR) $(DISK_40D),CMDS
	$(CP) $(CMDS) $(DISK_40D),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK_40D),CMDS/$(file);)
	$(MERGE) $(BOOTCMDS)>shell
	$(CP) shell $(DISK_40D),CMDS
	$(RM) shell
	$(OS9ATTR) $(DISK_40D),CMDS/shell -e -pe -pr -e -w -r
	$(OS9RENAME) $(DISK_40D),CMDS/sierra AutoEx
	$(CPL) $(TEXTFILES) $(DISK_40D),.
	$(OS9RENAME) $(DISK_40D),tOC_40d.txt tOC.txt
	tocgen $(DISK_40D),tOC.txt $(DISK_40D),tOC
	$(CP) $(SUPPORTFILES) $(DISK_40D),.

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** King's Quest I ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
