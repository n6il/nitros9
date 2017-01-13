include ../port.mak

DEPENDS		= ./makefile

index.html:	$(LEVEL1)/wwwroot/index.html
	@sed -e 's|%PORT%|$(PORT)|' -e 's|%MACHINE%|$(MACHINE)|' $^ > $@

all:	index.html $(DEPENDS)

clean:
	$(RM) index.html

showobjs:
	@$(ECHO) index.html
