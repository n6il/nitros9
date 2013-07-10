include $(NITROS9DIR)/rules.mak

DISK	= basic09v010100.dsk

# NitrOS-9
H6309		= $(AFLAGS) -DH6309=1
# Non-NitrOS-9
M6809		= $(AFLAGS)

DEPENDS		= ./makefile

TXTFILES	= ReadMe install6809 install6309
OBJS		= gfx gfx2 inkey syscall
OBJS6809	= basic09_6809 runb_6809
OBJS6309	= basic09_6309 runb_6309
ALLOBJS		= $(OBJS) $(OBJS6809) $(OBJS6309)

all:	banner $(ALLOBJS) $(DEPENDS)

banner:
	@$(ECHO) "**************************************************"
	@$(ECHO) "*                                                *"
	@$(ECHO) "*                     Basic09                    *"
	@$(ECHO) "*                                                *"
	@$(ECHO) "**************************************************"

basic09_6309: basic09.asm
	$(AS) $(ASOUT)$@ $< $(H6309)

basic09_6809: basic09.asm
	$(AS) $(ASOUT)$@ $< $(M6809)

runb_6309: runb.asm
	$(AS) $(ASOUT)$@ $< $(H6309)

runb_6809: runb.asm
	$(AS) $(ASOUT)$@ $< $(M6809)

runbt_6809: basic09.asm
	$(AS) $(ASOUT)$@ $< $(M6809) -aRUNTIME=1

clean: dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT_SS35) $(DISK) -n"Basic09"
	$(MAKDIR) $(DISK),CMDS
	$(CP) $(ALLOBJS) $(DISK),CMDS
	$(foreach file, $(ALLOBJS), $(OS9ATTR_EXEC) $(DISK),CMDS/$(file);)
	$(CPL) $(TXTFILES) $(DISK),.
	$(foreach file, $(TXTFILES), $(OS9ATTR_TEXT) $(DISK),$(file);)

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	$(RM) $(DISK)

info:
	@$(ECHO) "*** Basic09 ***"
	@$(ECHO) $(DISK)
