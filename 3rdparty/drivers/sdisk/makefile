include ../../../Makefile.rules

DEPENDS		= ./Makefile

DRIVERS		= sdisk.dr
DESCS		= d0_35s.dd d0_40d.dd d0_80d.dd \
		d1_35s.dd d1_40d.dd d1_80d.dd
PROGRAMS	= bootfix
ALLOBJS		= $(DRIVERS) $(DESCS) $(PROGRAMS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)

