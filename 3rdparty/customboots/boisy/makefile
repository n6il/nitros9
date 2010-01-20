include $(NITROS9DIR)/rules.mak

vpath %.asm ../../../utils/boisy:..:$(LEVEL2)/cmds:$(LEVEL1)/cmds:$(LEVEL1)/modules:$(NITROS9DIR)/3rdparty/packages/basic09

AFLAGS		+= -aNoTerm=1 -acoco3=1

LFLAGS		+= -y -l=$(NITROS9DIR)/3rdparty/packages/drivewire/netlib/netlib.l -l=$(NITROS9DIR)/3rdparty/libs/alib/alib.l -l=../netlib/netlib.l -l=$(NITROS9DIR)/lib/sys6309l2.l 
3PDW63          = $(3RDPARTY)/packages/drivewire/6309l2

DEPENDS		= ./makefile

AFLAGS          += -e -aH6309=1

DSK 		= thesis.dsk
CD		= $(LEVEL2)/coco3_6309/cmds
MD		= $(LEVEL2)/coco3_6309/modules
SYSTEXT		= motd password
DSKS		= $(DSK)

CMDS		= $(CD)/attr $(CD)/build $(CD)/cmp $(CD)/copy $(CD)/cputype $(CD)/date \
		$(CD)/deiniz $(CD)/del $(CD)/deldir $(CD)/devs $(CD)/dir $(CD)/display \
		$(CD)/dmem $(CD)/dmode $(CD)/dump $(CD)/echo $(CD)/edit $(CD)/error \
		$(CD)/free $(CD)/grfdrv $(CD)/help $(CD)/ident $(CD)/iniz $(CD)/link \
		$(CD)/list $(CD)/load $(CD)/login $(CD)/makdir $(CD)/mdir $(CD)/merge \
                $(CD)/mfree $(CD)/mmap $(CD)/mpi $(CD)/pmap $(CD)/proc $(CD)/procs \
		$(CD)/prompt $(CD)/pwd $(CD)/pxd $(CD)/rename $(CD)/save $(CD)/shell \
		$(CD)/sleep $(CD)/smap $(CD)/tee $(CD)/tmode $(CD)/touch $(CD)/tsmon \
		$(CD)/unlink $(CD)/verify $(CD)/xmode $(CD)/utilpak1 $(CD)/basic09 $(CD)/syscall

CMDS_DW		= $(3PDW63)/telnetd $(3PDW63)/inetd $(3PDW63)/dw \
		$(3PDW63)/telnet

CMDS_THESIS	= testmul

# We make our own bootfile and kernel track
KERNEL		= $(MD)/rel_80 $(MD)/boot_dw3 $(MD)/krn
BOOTFILE	= $(MD)/krnp2 $(MD)/ioman $(MD)/init \
		$(MD)/rbf.mn \
		$(MD)/rbdw3.dr $(MD)/dw3.sb \
		$(MD)/rammer.dr $(MD)/r0_128k.dd \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd \
		$(MD)/scf.mn \
		$(MD)/scdwn.dr $(MD)/term_scdwn.dt \
		$(MD)/n1_scdwn.dd $(MD)/n2_scdwn.dd $(MD)/n3_scdwn.dd \
		$(MD)/n4_scdwn.dd $(MD)/n5_scdwn.dd $(MD)/n6_scdwn.dd \
		$(MD)/n7_scdwn.dd $(MD)/n8_scdwn.dd $(MD)/n9_scdwn.dd \
		$(MD)/n10_scdwn.dd $(MD)/n11_scdwn.dd $(MD)/n12_scdwn.dd \
		$(MD)/n13_scdwn.dd $(MD)/n14_scdwn.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(MD)/vrn.dr $(MD)/nil.dd \
		$(MD)/pipeman.mn $(MD)/piper.dr $(MD)/pipe.dd \
		$(MD)/clock_60hz $(MD)/clock2_dw3 \
		$(MD)/sysgo_dd
#		$(MD)/vtio.dr \
#		$(MD)/keydrv_cc3.sb $(MD)/joydrv_joy.sb $(MD)/snddrv_cc3.sb \
#		$(MD)/cowin.io $(MD)/covdg.io \
#		$(MD)/term_win80.dt \

SUPPORTFILES	= startup

ALLOBJS		= $(CMDS) $(CMDS_DW) $(CMDS_THESIS)

all:	$(ALLOBJS)

clean:	dskclean

dsk:	all $(DSKS)

$(DSK):
	cd $(3RDPARTY)/utils/supercomm; make
	$(RM) $@
	$(CD) $(LEVEL2)/coco3_6309; make
	$(OS9FORMAT_SS80) -q $@ -n"NitrOS-9 Level 2 DriveWire Server"
	$(MERGE) $(BOOTFILE)>os9boot
	$(MERGE) $(KERNEL)>kernel
	$(OS9GEN) $@ -b=os9boot -t=kernel
	$(RM) os9boot kernel
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(CP) $(CMDS) $(CMDS_DW) $(CMDS_THESIS) $@,CMDS
	$(foreach file, $(CMDS) $(CMDS_DW) $(CMDS_THESIS), $(OS9ATTR_EXEC) $@,CMDS/$(notdir $(file));)
	$(CP) $(3RDPARTY)/utils/supercomm/supercomm $@,CMDS
	$(OS9ATTR_EXEC) $@,CMDS/supercomm
	$(CPL) $(SYSTEXT) $@,SYS
	$(foreach file, $(SYSTEXT), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CPL) $(SUPPORTFILES) $@,.
	$(foreach file, $(SUPPORTFILES), $(OS9ATTR_TEXT) $@,$(file);)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

dskclean:
	$(RM) $(DSKS)

info:
	@$(ECHO) "*** NitrOS-9/6309 Level 2 DriveWire Server ***"
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
