include ../../rules.mak

vpath %.asm $(6809L1)/cmds:$(3RDPARTY)/packages/basic09

DEPENDS		= ./makefile

CMDS		= asm attr backup binex build cmp cobbler copy cputype \
		date dcheck debug ded deiniz del deldir devs dir disasm \
		display dmem dmode dsave dump echo edit error exbin \
		format free grfdrv help ident iniz irqs link list load login \
		makdir mdir megaread merge mfree mmap modpatch montype mpi os9gen padrom park \
		prompt pmap proc procs pwd pxd reboot rename runb save setime \
		shell_21 sleep smap tee tmode touch \
		tsmon tuneport unlink verify wcreate xmode
SUBS            = gfx2 gfx inkey syscall

SHELLMODS	= shellplus date deiniz echo iniz link load save unlink
UTILPAK1	= attr build copy del deldir dir display list makdir mdir \
		merge mfree procs rename tmode

# Files not compilable by os9asm: config
all:	$(SUBS) $(CMDS) shell utilpak1 $(DEPENDS)

runb:	runb.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPWD=1
	$(MERGE) $@ $(SUBS)>$@.tmp
	$(RM) $@
	$(MOVE) $@.tmp $@

pwd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPWD=1

pxd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPXD=1

shell:  $(SHELLMODS) $(DEPENDS)
	$(MERGE) $(SHELLMODS)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO) ""

utilpak1:  $(UTILPAK1) $(DEPENDS)
	$(MERGE) $(UTILPAK1)>$@
	@$(ECHO) "*** Be sure the size of this file is less than 7681 bytes! ***"
	@ls -l $@
	@$(ECHO) ""

clean:
	$(RM) shell utilpak1 $(SUBS) $(SHELLMODS) $(CMDS)

# Only $(CMDS) are shown here
showobjs:
	@$(ECHO) shell utilpak1 $(CMDS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
