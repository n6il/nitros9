include ../../Makefile.rules

DEPENDS		= ./Makefile

# Files not compilable by os9asm: dcheck dsave format tmode
CMDS		= asm attr backup binex build cobbler copy date \
		debug del deldir dir display dump \
		echo exbin free grfo ident iniz link list \
		load login makdir mdir merge mfree os9gen \
		printerr procs pwd pxd \
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
