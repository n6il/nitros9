include ../../Makefile.rules

DEPENDS		= ./Makefile

BASIC09FILES	= runb.asm gfx.asm inkey.asm syscall.asm
COCOCMDS	= asm attr backup binex build cmp cobbler config copy date \
		dcheck debug deiniz del deldir dir display dsave dump \
		echo edit error exbin format free grfo help ident iniz link \
		list load login makdir mdir merge mfree \
		os9gen park printerr procs pwd pxd \
		rename runb save setime shell sleep tee tmode tsmon \
		tuneport unlink verify xmode gfx inkey syscall
DRAGONCMDS	= cobbler_d64 format_d64 os9gen_d64 drvr51.dr go51
ALLOBJS		= $(COCOCMDS) $(DRAGONCMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(ALLOBJS)

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
