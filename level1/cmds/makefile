include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= asm attr backup binex build copy date del deldir dir display dump echo exbin free grfo ident link list \
		load login makdir mdir mfree printerr procs pwd pxd rename save setime shell sleep tee unlink verify
ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) a+rx $(ALLOBJS)

clean:
	$(RM) $(ALLOBJS)

