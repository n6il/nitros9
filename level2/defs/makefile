include ../../Makefile.rules

DEPENDS		= ./Makefile

DEFOPTS		= -ls -x -z -aLevel=2
DEFSDIR		= $(BASEDIR)/defs
PERMDEFS	= Defsfile
DEFS		= OS9Defs RBFDefs SCFDefs SysType
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

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
