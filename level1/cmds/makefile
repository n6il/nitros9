include ../../rules.mak

vpath %.asm $(3RDPARTY)/packages/basic09

DEPENDS		= ./makefile

BASIC09FILES	= runb.asm gfx.asm inkey.asm syscall.asm
CMDS		= asm attr backup binex build cmp cobbler config copy cputype \
		date dcheck debug ded deiniz del deldir devs dir disasm \
		display dmode dsave dump echo edit error exbin exmode format \
		free grfo help ident iniz irqs link list load login makdir \
		mdir merge mfree os9gen padrom park prompt printerr procs pwd pxd \
		rename runb save setime shell_21 shellplus sleep \
		tee tmode touch tsmon tuneport unlink verify xmode
SUBS		= gfx inkey syscall
ALLOBJS		= $(CMDS) $(DRAGONCMDS) $(SUBS)

all:	$(ALLOBJS)

pwd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPWD=1

pxd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPXD=1

shell:	shellplus.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@

clean:
	$(RM) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showallobjs:
	@$(ECHO) $(ALLOBJS)

showcocoobjs:
	@$(ECHO) $(CMDS) $(SUBS)

showdragonobjs:
	@$(ECHO) $(CMDS) $(DRAGONCMDS)
