PORT = coco3
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= -ls -x -z -aLevel=2
PERMDEFS	= Defsfile
DEFS		= os9.d rbf.d scf.d coco.d coco3vtio.d
ALLOBJS		= $(DEFS) $(PERMDEFS)

all:	$(ALLOBJS)

os9.d: $(DEFSDIR)/os9.d
	$(AS) $(AFLAGS) $(DEFOPTS) -aOS9.D=0 $< > $@

rbf.d: $(DEFSDIR)/rbf.d
	$(AS) $(AFLAGS) $(DEFOPTS) -aRBF.D=0 $< > $@

scf.d: $(DEFSDIR)/scf.d
	$(AS) $(AFLAGS) $(DEFOPTS) -aSCF.D=0 $< > $@

coco.d: $(DEFSDIR)/coco.d
	$(AS) $(AFLAGS) $(DEFOPTS) -aCOCO.D=0 $< > $@

coco3vtio.d: $(DEFSDIR)/cocovtio.d
	$(AS) $(AFLAGS) $(DEFOPTS) -aCOCOVTIO.D=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
