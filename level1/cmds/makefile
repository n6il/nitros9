include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= asm attr backup binex build cobbler cobbler_d64 copy date \
		dcheck debug del deldir dir display dsave dump \
		echo edit exbin format format_d64 free grfo ident iniz link list \
		load login makdir mdir merge mfree os9gen os9gen_d64 \
		park printerr procs pwd pxd \
		rename save setime shell sleep tee tmode tsmon \
		tuneport unlink verify xmode
ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) a+rx $(ALLOBJS)

clean:
	$(RM) $(ALLOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)

showobjs:
	@echo $(ALLOBJS)
