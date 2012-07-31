PORT = atari
include $(NITROS9DIR)/rules.mak

CPU		= 6809
LEVEL		= 1

# Level 1 - Specify which shell should be used
#WHICHSHELL	= shellplus
WHICHSHELL	= shell_21

DISTRO		= $(CPU)L$(LEVEL)
DISTRONAME	= nos9$(CPU)l$(LEVEL)
DISTROVER	= $(DISTRONAME)$(NITROS9VER)$(PORT)
BOOTFILE	= bootfiles/bootfile
DIRS		= cmds modules defs sys bootfiles


CMDS		= $(shell $(CD) cmds; make --no-print-directory showobjs_dw)
CMDS_DEMO = $(shell $(CD) cmds; make --no-print-directory showobjs_demo)
SYS		= $(shell $(CD) sys; make --no-print-directory showobjs)
DEFS		= $(shell $(CD) defs; make --no-print-directory showobjs)
STARTUP		= startup

PACKAGENAME	= $(DISTROVER).zip
DSK		     = $(DISTROVER).dsk
DSK_DEMO       = ataridemo.dsk

DSKS		= $(DSK) $(DSK_DEMO)

# Make all components
all:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*        NitrOS-9/$(CPU) Level 1 Atari Port        *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"
	$(foreach dir, $(DIRS), ($(CD) $(dir); make);)

# Clean all components
clean:	dskclean
	$(foreach dir, $(DIRS), ($(CD) $(dir); make clean);)

dskclean:
	-$(RM) $(PACKAGENAME) $(DSKS)

dsk: all $(PACKAGENAME)

dskcopy: dsk
	$(CP) $(DSKS) $(DSKDIR)

scp: dsk
	scp $(PACKAGENAME) boisy@cvs.nitros9.org:/home/nitros9/public_html

$(PACKAGENAME): $(DSKS) ../../ReadMe ../../ChangeLog
	$(ARCHIVE) $@ $^

#	$(OS9GEN) $@ -b=$(BOOTFILE)	
$(DSK):
	$(RM) $@
	$(OS9FORMAT_DW) -q $@ -n"NitrOS-9/$(CPU) Level 1"
	$(MAKDIR) $@,CMDS
	$(MAKDIR) $@,SYS
	$(MAKDIR) $@,DEFS
	$(CD) cmds; $(CP) $(CMDS) ../$@,CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $@,CMDS/$(file);)
	$(OS9RENAME) $@,CMDS/$(WHICHSHELL) shell
	$(CD) sys; $(CPL) $(SYS) ../$@,SYS
	$(foreach file, $(SYS), $(OS9ATTR_TEXT) $@,SYS/$(file);)
	$(CD) defs; $(CPL) $(DEFS) ../$@,DEFS
	$(foreach file, $(DEFS), $(OS9ATTR_TEXT) $@,DEFS/$(file);)
	$(CPL) $(STARTUP) $@,startup
	$(OS9ATTR_TEXT) $@,startup

$(DSK_DEMO):
	$(RM) $@
	$(OS9FORMAT_DW) -q $@ -n"NitrOS-9 Atari Demo Disk"
	$(MAKDIR) $@,CMDS
	$(CD) cmds; $(CP) $(CMDS_DEMO) ../$@,CMDS
	$(foreach file, $(CMDS_DEMO), $(OS9ATTR_EXEC) $@,CMDS/$(file);)

info:
	@echo "*** NitrOS-9/6809 Level 1 for the Atari XL/XE ***" 
	@$(foreach dsk, $(DSKS), $(ECHO) $(dsk);)
	
