include ../../rules.mak

vpath %.asm $(3RDPARTY)/packages/basic09

DEPENDS		= ./makefile

BASIC09FILES	= runb.asm gfx.asm inkey.asm syscall.asm
CMDS		= asm attr backup binex build cmp cobbler config copy cputype \
		date dcheck debug ded deiniz del deldir devs dir disasm \
		display dmode dsave dump echo edit error exbin format \
		free grfo help ident iniz irqs link list load login makdir \
		megaread mdir merge mfree mpi os9gen padrom park prompt printerr procs pwd pxd \
		rename runb save setime shellplus shell_21 sleep \
		tee tmode touch tsmon tuneport unlink verify xmode
SUBS		= gfx inkey syscall
ALLOBJS		= $(CMDS) $(DRAGONCMDS) $(SUBS)

all:	$(ALLOBJS)

pwd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPWD=1

xmode:	xmode.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aXMODE=1

tmode:	xmode.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aTMODE=1

pxd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPXD=1

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
