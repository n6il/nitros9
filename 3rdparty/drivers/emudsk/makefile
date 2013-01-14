ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile

DRIVERS		= emudsk.dr
DESCS		= h0.dd ddh0.dd h1.dd
ALLOBJS		= $(DRIVERS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)

