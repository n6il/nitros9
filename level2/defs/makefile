PORT = coco3
include ../../rules.mak

DEPENDS		= ./makefile

DEFOPTS		= -ls -x -z -aLevel=2
PERMDEFS	= Defsfile
DEFS		= OS9Defs RBFDefs SCFDefs SysType VTIODefs
ALLOBJS		= $(DEFS) $(PERMDEFS)

all:	$(ALLOBJS)

OS9Defs: $(DEFSDIR)/os9defs
	$(AS) $(DEFOPTS) -aOS9DEFS=0 $< > $@

RBFDefs: $(DEFSDIR)/rbfdefs
	$(AS) $(DEFOPTS) -aRBFDEFS=0 $< > $@

SCFDefs: $(DEFSDIR)/scfdefs
	$(AS) $(DEFOPTS) -aSCFDEFS=0 $< > $@

SysType: $(DEFSDIR)/systype
	$(AS) $(DEFOPTS) -aSYSTYPE=0 $< > $@

VTIODefs: $(DEFSDIR)/vtiodefs_cc3
	$(AS) $(DEFOPTS) -aVTIODEFS=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
