include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= asm attr backup binex build cobbler cobbler_cc copy date \
		dcheck debug del deldir dir display dsave dump \
		echo exbin format free grfo ident iniz link list \
		load login makdir mdir merge mfree os9gen os9gen_cc \
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
