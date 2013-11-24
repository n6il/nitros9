ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DISK	= basic09v010100.dsk

# NitrOS-9
H6309		= $(AFLAGS) -aH6309=1 -e
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
	$(OS9COPY) $(ALLOBJS) $(DISK),CMDS
	$(OS9ATTR_EXEC) $(foreach file,$(ALLOBJS),$(DISK),CMDS/$(file))
	$(CPL) $(TXTFILES) $(DISK),.
	$(OS9ATTR_TEXT) $(foreach file,$(TXTFILES),$(DISK),$(file))

dskcopy: dsk
	$(CP) $(DISK) $(DSKDIR)

dskclean:
	-$(RM) $(DISK)

info:
	@$(ECHO) "*** Basic09 ***"
	@$(ECHO) $(DISK)
