include ../../rules.mak

vpath %.asm $(6809L1)/cmds:$(3RDPARTY)/packages/basic09

DEPENDS		= ./makefile

CMDS		= asm attr backup binex build cmp cobbler copy cputype \
		date dcheck debug ded deiniz del deldir devs dir dirm disasm \
		display dmem dmode dsave dump echo edit error exbin exmode \
		format free grfdrv help ident iniz irqs link list load login \
		makdir mdir merge mfree mmap modpatch montype mpi os9gen padrom park \
		prompt pmap proc procs pwd pxd reboot rename runb save setime \
		shell_21 shellplus sleep smap tee tmode touch \
		tsmon tuneport unlink verify wcreate xmode
SUBS            = gfx2 gfx inkey syscall

SHELLMODS	= shellplus date deiniz echo iniz link load save unlink
UTILPAK1	= attr build copy del deldir dir display list makdir mdir \
		merge mfree procs rename sleep tmode

ALLOBJS		= $(CMDS) $(SUBS)

# Files not compilable by os9asm: config
all:	$(ALLOBJS) shell utilpak1 $(DEPENDS)

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
	$(RM) shell utilpak1 $(ALLOBJS)

showobjs:
	@$(ECHO) shell utilpak1 $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
