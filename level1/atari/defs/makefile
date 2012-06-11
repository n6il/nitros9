PORT = coco
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DEFOPTS		= --preprocess -DLevel=1
DEFSDIR		= ../../../defs
DEFS		= defsfile os9.d rbf.d scf.d atari.d atarivtio.d
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

atari.d: $(DEFSDIR)/atari.d
	$(AS) $(DEFOPTS) -aATARI.D=0 $< > $@

atarivtio.d: $(DEFSDIR)/atarivtio.d
	$(AS) $(DEFOPTS) -aATARIVTIO.D=0 $< > $@

clean:
	$(RM) $(DEFS)

showobjs:
	@$(ECHO) $(ALLOBJS)
