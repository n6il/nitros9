include ../port.mak

vpath %.as $(LEVEL1)/cmds
vpath %.asm $(LEVEL1)/cmds:$(3RDPARTY)/packages/basic09

DEPENDS		= ./makefile

AFLAGS		+= --includedir=$(3RDPARTY)/packages/basic09
LFLAGS		+= -L $(NITROS9DIR)/lib -lnet -lmc09 -lalib

BASIC09FILES	= basic09.asm runb.asm gfx.asm inkey.asm syscall.asm
CMDS		= asm attr backup binex build calldbg cmp cobbler copy cputype \
		date dcheck debug ded deiniz del deldir devs dir dirsort disasm \
		display dmode dsave dump echo edit error exbin format \
		free grfdrv help ident iniz irqs link list load login makdir mc09rtc \
		megaread mdir merge mfree minted mpi os9gen padrom park printerr procs prompt pwd pxd \
		rename save setime shellplus shell_21 sleep \
		tee tmode touch tsmon tuneport unlink verify xmode

CMDS_D2		= basic09 runb gfx inkey syscall copy del echo format \
		merge os9gen prompt tmode

CMDS_DW		= inetd telnet dw httpd

SUBS		= gfx inkey syscall
ALLOBJS		= $(CMDS) $(CMDS_D2) $(CMDS_DW) $(SUBS)

all:	$(ALLOBJS)

pwd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -DPWD=1

xmode:	xmode.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -DXMODE=1

tmode:	xmode.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -DTMODE=1

pxd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -DPXD=1

clean:
	$(RM) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showobjs:
	@$(ECHO) $(CMDS)

showobjs_d2:
	@$(ECHO) $(CMDS_D2)

showobjs_dw:
	@$(ECHO) $(sort $(CMDS) $(CMDS_DW))

showallobjs:
	@$(ECHO) $(ALLOBJS)
