include ../../Makefile.rules

DEPENDS		= ./Makefile

DEFOPTS		= -ls -x -z -aLevel=2
DEFSDIR		= $(BASEDIR)/defs
DEFS		= Defsfile OS9Defs RBFDefs SCFDefs SysType
ALLOBJS		= $(DEFS)

all:	$(ALLOBJS)
	$(CHMOD) 644 $(ALLOBJS)

Defsfile: defsfile
	$(AS) $(DEFOPTS) -p $< > $@

OS9Defs: $(DEFSDIR)/os9defs
	$(AS) $(DEFOPTS) $< > $@

RBFDefs: $(DEFSDIR)/rbfdefs
	$(AS) $(DEFOPTS) $< > $@

SCFDefs: $(DEFSDIR)/scfdefs
	$(AS) $(DEFOPTS) $< > $@

SysType: $(DEFSDIR)/systype
	$(AS) $(DEFOPTS) $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
