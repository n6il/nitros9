PORT = tano
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= -ls -x -z -aLevel=1
DEFSDIR		= ../../../defs
DEFS		= Defsfile OS9Defs RBFDefs SCFDefs SysType VTIODefs
ALLOBJS		= $(DEFS)

all:	$(ALLOBJS)

Defsfile: defsfile.asm
	$(AS) $(AFLAGS) $(DEFOPTS) -p $< > $@

OS9Defs: $(DEFSDIR)/os9defs
	$(AS) $(AFLAGS) $(DEFOPTS) -aOS9DEFS=0 $< > $@

RBFDefs: $(DEFSDIR)/rbfdefs
	$(AS) $(AFLAGS) $(DEFOPTS) -aRBFDEFS=0 $< > $@

SCFDefs: $(DEFSDIR)/scfdefs
	$(AS) $(AFLAGS) $(DEFOPTS) -aSCFDEFS=0 $< > $@

SysType: $(DEFSDIR)/systype
	$(AS) $(AFLAGS) $(DEFOPTS) -aSYSTYPE=0 $< > $@

VTIODefs: $(DEFSDIR)/vtiodefs
	$(AS) $(AFLAGS) $(DEFOPTS) -aVTIODEFS=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
