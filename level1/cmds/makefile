include ../../Makefile.rules

DEPENDS		= ./Makefile

CMDS		= asm attr backup binex build date del deldir dir dump echo exbin free ident link list \
		load login makdir printerr pwd pxd rename save setime shell sleep tee unlink verify
ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) a+rx $(ALLOBJS)

clean:
	$(RM) $(ALLOBJS)

