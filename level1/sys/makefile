include ../../Makefile.rules

DEPENDS		= ./Makefile

DEFS		= errmsg motd password
ALLOBJS		= $(DEFS)

all:	$(ALLOBJS)
	$(UNIX2OS9) $(ALLOBJS)

clean:
	$(OS92UNIX) $(ALLOBJS)

showobjs:
	@echo $(ALLOBJS)
