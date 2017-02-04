PORT = coco3fpga
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= --preprocess -DLevel=2
PERMDEFS	= Defsfile
DEFS		= os9defs rbfdefs scfdefs cocodefs vtiodefs
ALLOBJS		= $(DEFS) $(PERMDEFS)

all:	$(ALLOBJS)

os9defs: $(DEFSDIR)/os9.d
	$(AS) $(AFLAGS) $(DEFOPTS) -DOS9.D=0 $< > $@

rbfdefs: $(DEFSDIR)/rbf.d
	$(AS) $(AFLAGS) $(DEFOPTS) -DRBF.D=0 $< > $@

scfdefs: $(DEFSDIR)/scf.d
	$(AS) $(AFLAGS) $(DEFOPTS) -DSCF.D=0 $< > $@

cocodefs: $(DEFSDIR)/coco.d
	$(AS) $(AFLAGS) $(DEFOPTS) -DCOCO.D=0 $< > $@

vtiodefs: $(DEFSDIR)/cocovtio.d
	$(AS) $(AFLAGS) $(DEFOPTS) -DCOCOVTIO.D=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
