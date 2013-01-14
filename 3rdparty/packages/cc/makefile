ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DISK		= cc.dsk
CMDS		= cc1 c.prep c.pass1 c.pass2 c.opt c.asm c.link make

ALLOBJS		= $(CMDS)

# Make all components
all:	banner $(ALLOBJS)

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                    C Compiler                  *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

# Clean all components
clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT_DS40) -q $(DISK) -n"C Compiler"
	$(MAKDIR) $(DISK),CMDS
	$(MAKDIR) $(DISK),LIB
	$(MAKDIR) $(DISK),DEFS
	$(MAKDIR) $(DISK),SOURCES
	$(MAKDIR) $(DISK),SOURCES/SYS
	$(CP) $(CMDS) $(DISK),CMDS
	$(foreach file, $(CMDS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(CPL) defs/*.h $(DISK),DEFS
	$(CP) lib/*.l LIB/*.r $(DISK),LIB
	$(CPL) sources/*.c $(DISK),SOURCES
	$(CPL) sources/*.a $(DISK),SOURCES/SYS

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)

info:
	@$(ECHO) "*** Microware C Compiler ***"
	@$(ECHO) $(DISK)
