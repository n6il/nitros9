include ../../../Makefile.rules

DEPENDS		= ./Makefile

DRIVERS		= sdisk.dr
DESCS		= d0_40d.dd
PROGRAMS	= bootfix
ALLOBJS		= $(DRIVERS) $(DESCS) $(PROGRAMS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)

