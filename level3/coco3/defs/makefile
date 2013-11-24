PORT = coco3
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= -ls -x -z -aLevel=3
PERMDEFS	= Defsfile
DEFS		= OS9Defs RBFDefs SCFDefs SysType VTIODefs
ALLOBJS		= $(DEFS) $(PERMDEFS)

all:	$(ALLOBJS)

OS9Defs: $(DEFSDIR)/os9defs
	$(AS) $(AFLAGS) $(DEFOPTS) -aOS9DEFS=0 $< > $@

RBFDefs: $(DEFSDIR)/rbfdefs
	$(AS) $(AFLAGS) $(DEFOPTS) -aRBFDEFS=0 $< > $@

SCFDefs: $(DEFSDIR)/scfdefs
	$(AS) $(AFLAGS) $(DEFOPTS) -aSCFDEFS=0 $< > $@

SysType: $(DEFSDIR)/systype
	$(AS) $(AFLAGS) $(DEFOPTS) -aSYSTYPE=0 $< > $@

VTIODefs: $(DEFSDIR)/vtiodefs_cc3
	$(AS) $(AFLAGS) $(DEFOPTS) -aVTIODEFS=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
