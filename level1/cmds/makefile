# Makefile for OS-9 Level One CMDS/

include ../../Makefile.rules

vpath %.asm $(3RDPARTY)/packages/basic09

DEPENDS		= ./Makefile

BASIC09FILES	= runb.asm gfx.asm inkey.asm syscall.asm
COCOCMDS	= asm attr backup binex build cmp cobbler config copy cputype \
		date dcheck debug ded deiniz del deldir devs dir disasm \
		display dmode dsave dump echo edit error exbin exmode format \
		free grfo help ident iniz irqs link list load login makdir \
		mdir merge mfree os9gen padrom park prompt printerr procs pwd pxd \
		rename runb save setime shell sleep tee tmode touch tsmon \
		tuneport unlink verify xmode
SUBS		= gfx inkey syscall
DRAGONCMDS	= cobbler_d64 format_d64 os9gen_d64 go51
ALLOBJS		= $(COCOCMDS) $(DRAGONCMDS) $(SUBS)

all:	$(ALLOBJS)

pwd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPWD=1

pxd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPXD=1

clean:
	$(RM) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showallobjs:
	@$(ECHO) $(ALLOBJS)

showcocoobjs:
	@$(ECHO) $(COCOCMDS) $(SUBS)

showdragonobjs:
	@$(ECHO) $(CMDS) $(DRAGONCMDS)
