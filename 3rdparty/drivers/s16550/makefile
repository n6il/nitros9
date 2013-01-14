ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DRIVERS		= s16550_large.dr
DESCS		= t2_s16550.dd
ALLOBJS		= $(DRIVERS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)

