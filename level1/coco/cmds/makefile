PORT = coco
include $(NITROS9DIR)/rules.mak

vpath %.a $(LEVEL1)/cmds
vpath %.asm $(LEVEL1)/cmds:$(NITROS9DIR)/3rdparty/packages/basic09

DEPENDS		= ./makefile

AFLAGS		+= -i=$(NITROS9DIR)/3rdparty/packages/basic09
LFLAGS		+= -l=$(NITROS9DIR)/lib/net.l -l=$(NITROS9DIR)/lib/alib.l -l=$(NITROS9DIR)/lib/sys6809l1.l

BASIC09FILES	= basic09.asm runb.asm gfx.asm inkey.asm syscall.asm
CMDS		= asm attr backup binex build calldbg cmp cobbler copy cputype \
		date dcheck debug ded deiniz del deldir devs dir dirsort disasm \
		display dmode dsave dump echo edit error exbin format \
		free grfdrv help ident iniz irqs link list load login makdir \
		megaread mdir merge mfree mpi os9gen padrom park printerr procs prompt pwd pxd \
		rename save setime shellplus shell_21 sleep \
		tee tmode touch tsmon tuneport unlink verify xmode

CMDS_D2		= basic09 runb gfx inkey syscall copy del echo format \
		merge os9gen prompt tmode

CMDS_DW		= inetd telnet dw

SUBS		= gfx inkey syscall
ALLOBJS		= $(CMDS) $(CMDS_D2) $(CMDS_DW) $(SUBS)

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

showobjs:
	@$(ECHO) $(CMDS)

showobjs_d2:
	@$(ECHO) $(CMDS_D2)

showobjs_dw:
	@$(ECHO) $(CMDS) $(CMDS_DW)

showallobjs:
	@$(ECHO) $(ALLOBJS)
