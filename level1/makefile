include ../Makefile.rules

RELEASE		= os9l1v030101
BOOTFILE	= bootfile_stock
KERNEL		= kernel_stock

CMDS		= $(shell $(CD) CMDS; make showcocoobjs)
MODULES		= $(shell $(CD) MODULES; make showcopyobjs)
SYS		= $(shell $(CD) SYS; make showobjs)
DEFS		= $(shell $(CD) DEFS; make showobjs)
ROOTFILES	= startup

PACKAGENAME	= $(RELEASE).zip
DSK1		= $(RELEASE)_ds40_1.dsk
DSK2		= $(RELEASE)_ds40_2.dsk

# Make all components
all:
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*        OS-9 Level One Distribution        *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"
	$(CD) CMDS; make
	$(CD) MODULES; make
	$(CD) DEFS; make
	$(CD) SYS; make
	$(CD) BOOTFILES; make
	$(CHMOD) 644 $(ROOTFILES)

# Clean all components
clean:	dskclean
	-$(CD) CMDS; make clean
	-$(CD) MODULES; make clean
	-$(CD) DEFS; make clean
	-$(CD) SYS; make clean
	-$(CD) BOOTFILES; make clean

dskclean:
	-$(RM) $(PACKAGENAME) $(DSK1) $(DSK2)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSK1) $(DSK2) $(PACKAGENAME) $(DSKDIR)

$(PACKAGENAME): $(DSK1) $(DSK2)
	$(ARCHIVE) $(PACKAGENAME) $(DSK1) $(DSK2) ReadMe ChangeLog

$(DSK1):
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -n"OS-9 Level One System Disk"
	$(OS9GEN) $@ -b=BOOTFILES/$(BOOTFILE) -t=BOOTFILES/$(KERNEL)
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(CD) CMDS; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR) $@,CMDS/$(file) -ewr -pepr;)
	$(CD) SYS; $(CPL) $(SYS) ../$@,SYS
	$(MAKDIR) $@,DEFS
	$(CD) DEFS; $(CPL) $(DEFS) ../$@,DEFS
	$(CPL) $(ROOTFILES) $@,.

$(DSK2):
	$(RM) $@
	$(OS9FORMAT_DS40) $@ -n"OS-9 Level One Modules Disk"
	$(MAKDIR) $@,MODULES
	$(CD) MODULES; $(CP) $(MODULES) ../$@,MODULES

