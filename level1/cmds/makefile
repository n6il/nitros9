include ../../Makefile.rules

DEPENDS		= ./Makefile

COCOCMDS_D1	= attr backup binex build cmp copy date \
		dcheck debug deiniz del deldir dir display dsave dump \
		echo edit error exbin free help ident iniz link \
		list load login makdir mdir merge mfree \
		printerr procs pwd pxd \
		rename save setime shell sleep tee tmode tsmon \
		tuneport unlink verify xmode gfx inkey syscall
COCOCMDS_D2	= asm config help copy del dir os9gen rename park
COCOCMDS	= cobbler format os9gen grfo
DRAGONCMDS	= cobbler_d64 format_d64 os9gen_d64 drvr51.dr go51
ALLOBJS		= $(COCOCMDS_D1) $(COCOCMDS_D2) $(COCOCMDS) $(DRAGONCMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(ALLOBJS)

clean:
	$(RM) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showallobjs:
	@$(ECHO) $(ALLOBJS)

showcocoobjs:
	@$(ECHO) $(CMDS) $(COCOCMDS_D1) $(COCOCMDS_D2) $(COCOCMDS)

showcocoobjs_d1:
	@$(ECHO) $(CMDS) $(COCOCMDS_D1)

showcocoobjs_d2:
	@$(ECHO) $(CMDS) $(COCOCMDS_D2)

showdragonobjs:
	@$(ECHO) $(CMDS) $(DRAGONCMDS)
