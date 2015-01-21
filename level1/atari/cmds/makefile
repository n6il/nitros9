include ../port.mak

vpath %.as $(LEVEL1)/cmds
vpath %.asm $(LEVEL1)/cmds:$(3RDPARTY)/packages/basic09

DEPENDS		= ./makefile

AFLAGS          += --includedir=$(3RDPARTY)/packages/basic09
LFLAGS          += -L $(NITROS9DIR)/lib -lnet -latari -lalib

BASIC09FILES	= basic09.asm runb.asm gfx.asm inkey.asm syscall.asm
CMDS		= asm attr backup binex build calldbg cmp copy cputype \
		date dcheck debug ded deiniz del deldir devs dir dirsort disasm \
		display dmode dsave dump echo edit error exbin format \
		free help ident iniz irqs link list load login makdir \
		megaread mdir merge mfree os9gen padrom park printerr procs prompt pwd pxd \
		rename save setime shellplus shell_21 sleep \
		tee tmode touch tsmon tuneport unlink verify xmode\
          basic09 runb gfx inkey syscall 

CMDS_DW		= inetd telnet dw httpd

CMDS_DEMO      = fuji

SUBS		= gfx inkey syscall
ALLOBJS		= $(CMDS) $(CMDS_D2) $(CMDS_DW) $(CMDS_DEMO) $(SUBS)

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

showobjs_dw:
	@$(ECHO) $(CMDS) $(CMDS_DW)

showobjs_demo:
	@$(ECHO) $(CMDS_DEMO)

showallobjs:
	@$(ECHO) $(ALLOBJS)
