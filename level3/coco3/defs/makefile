PORT = coco3
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= --preprocess -DLevel=3
PERMDEFS	= Defsfile
DEFS		= OS9Defs RBFDefs SCFDefs SysType VTIODefs
ALLOBJS		= $(DEFS) $(PERMDEFS)

all:	$(ALLOBJS)

OS9Defs: $(DEFSDIR)/os9defs
	$(AS) $(AFLAGS) $(DEFOPTS) -DOS9DEFS=0 $< > $@

RBFDefs: $(DEFSDIR)/rbfdefs
	$(AS) $(AFLAGS) $(DEFOPTS) -DRBFDEFS=0 $< > $@

SCFDefs: $(DEFSDIR)/scfdefs
	$(AS) $(AFLAGS) $(DEFOPTS) -DSCFDEFS=0 $< > $@

SysType: $(DEFSDIR)/systype
	$(AS) $(AFLAGS) $(DEFOPTS) -DSYSTYPE=0 $< > $@

VTIODefs: $(DEFSDIR)/vtiodefs_cc3
	$(AS) $(AFLAGS) $(DEFOPTS) -DVTIODEFS=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
