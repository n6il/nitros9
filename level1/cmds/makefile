include ../../Makefile.rules

DEPENDS		= ./Makefile

BASIC09FILES	= runb.asm gfx.asm inkey.asm syscall.asm
COCOCMDS	= asm attr backup binex build cmp cobbler config copy date \
		dcheck debug ded deiniz del deldir devs dir disasm display \
		dmode dsave dump echo edit error exbin exmode format free grfo \
		help ident iniz irqs link list load login makdir mdir merge \
		mfree os9gen park printerr procs pwd pxd \
		rename runb save setime shell sleep tee tmode touch tsmon \
		tuneport unlink verify xmode gfx inkey syscall
DRAGONCMDS	= cobbler_d64 format_d64 os9gen_d64 go51
ALLOBJS		= $(COCOCMDS) $(DRAGONCMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(ALLOBJS)

pwd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPWD=1

pxd:	pd.asm
	$(AS) $(AFLAGS) $< $(ASOUT)$@ -aPXD=1

clean:
	$(RM) $(ALLOBJS) $(BASIC09FILES)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showallobjs:
	@$(ECHO) $(ALLOBJS)

showcocoobjs:
	@$(ECHO) $(COCOCMDS)

showdragonobjs:
	@$(ECHO) $(CMDS) $(DRAGONCMDS)

$(BASIC09FILES): $(BASEDIR)/3rdparty/packages/basic09/$@
	-$(SOFTLINK) $(BASEDIR)/3rdparty/packages/basic09/$@
