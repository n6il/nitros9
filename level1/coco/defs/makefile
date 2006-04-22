PORT = coco
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= -ls -x -z -aLevel=1
DEFSDIR		= ../../../defs
DEFS		= Defsfile OS9Defs RBFDefs SCFDefs SysType VTIODefs
ALLOBJS		= $(DEFS)

all:	$(ALLOBJS)

Defsfile: defsfile.asm
	$(AS) $(DEFOPTS) -p $< > $@

OS9Defs: $(DEFSDIR)/os9defs
	$(AS) $(DEFOPTS) -aOS9DEFS=0 $< > $@

RBFDefs: $(DEFSDIR)/rbfdefs
	$(AS) $(DEFOPTS) -aRBFDEFS=0 $< > $@

SCFDefs: $(DEFSDIR)/scfdefs
	$(AS) $(DEFOPTS) -aSCFDEFS=0 $< > $@

SysType: $(DEFSDIR)/systype
	$(AS) $(DEFOPTS) -aSYSTYPE=0 $< > $@

VTIODefs: $(DEFSDIR)/vtiodefs
	$(AS) $(DEFOPTS) -aVTIODEFS=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
