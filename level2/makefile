include ../Makefile.rules

RELEASE		= os9l2v030100
BOOTFILE	= bootfile_vdg
KERNEL		= kernel_stock

CMDS		= $(shell $(CD) CMDS; make showobjs)
MODULES		= $(shell $(CD) MODULES; make showcopyobjs)
DEFS		= $(shell $(CD) DEFS; make showobjs)
SYSBIN		= $(shell $(CD) SYS; make showbinobjs)
SYSTEXT		= $(shell $(CD) SYS; make showtextobjs)
ROOTFILES	= startup upgrade_song
SYSGO		= MODULES/cc3go

PACKAGENAME	= $(RELEASE).zip
DSK1		= $(RELEASE)_ds40_1.dsk
DSK2		= $(RELEASE)_ds40_2.dsk
TESTDSK		= test.dsk


# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*      OS-9 Level Two Vr3 Distribution      *"
	@$(ECHO) "*        The Rumored Upgrade Version        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) CMDS; make
	$(CD) MODULES; make
	$(CD) DEFS; make
	$(CD) SYS; make
	$(CD) BOOTFILES; make
	$(CHMOD) 644 $(ROOTFILES)

# Clean all components
clean: dskclean
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) DEFS; make clean
	-$(CD) SYS; make clean
	-$(CD) BOOTFILES; make clean

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK1) $(DSK2)

dsk: all $(PACKAGENAME)

$(PACKAGENAME): $(DSK1) $(DSK2)
	$(ZIP) $(PACKAGENAME) $(DSK1) $(DSK2) ReadMe ChangeLog

$(DSK1):
	-$(RM) $(DSK1)
	$(OS9FORMAT_DS40) $(DSK1) -n"OS-9 Level Two System Disk"
	$(OS9GEN) $(DSK1) -b=BOOTFILES/$(BOOTFILE) -t=BOOTFILES/$(KERNEL)
	$(MAKDIR) $(DSK1),CMDS
	$(MAKDIR) $(DSK1),SYS
	$(MAKDIR) $(DSK1),DEFS
	$(CP) $(SYSGO) $(DSK1),
	$(CD) CMDS; $(CP) $(CMDS) ../$(DSK1),CMDS
	$(CD) SYS; $(CP) $(SYSBIN) ../$(DSK1),SYS
	$(CD) SYS; $(CPL) $(SYSTEXT) ../$(DSK1),SYS
	$(CD) DEFS; $(CPL) $(DEFS) ../$(DSK1),DEFS
	$(CPL) $(ROOTFILES) $(DSK1),.

$(DSK2):
	-$(RM) $(DSK2)
	$(OS9FORMAT_DS40) $(DSK2) -n"OS-9 Level Two Modules Disk"
	$(MAKDIR) $(DSK2),MODULES
	$(CD) MODULES; $(CP) $(MODULES) ../$(DSK2),MODULES
