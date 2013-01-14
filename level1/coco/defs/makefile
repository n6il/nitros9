PORT = coco
ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= -ls -x -z -aLevel=1
DEFSDIR		= ../../../defs
DEFS		= defsfile os9.d rbf.d scf.d coco.d cocovtio.d
ALLOBJS		= $(DEFS)

all:	$(ALLOBJS)

defsfile: defsfile.asm
	$(AS) $(DEFOPTS) -p $< > $@

os9.d: $(DEFSDIR)/os9.d
	$(AS) $(DEFOPTS) -aOS9.D=0 $< > $@

rbf.d: $(DEFSDIR)/rbf.d
	$(AS) $(DEFOPTS) -aRBF.D=0 $< > $@

scf.d: $(DEFSDIR)/scf.d
	$(AS) $(DEFOPTS) -aSCF.D=0 $< > $@

coco.d: $(DEFSDIR)/coco.d
	$(AS) $(DEFOPTS) -aCOCO.D=0 $< > $@

cocovtio.d: $(DEFSDIR)/cocovtio.d
	$(AS) $(DEFOPTS) -aCOCOVTIO.D=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
