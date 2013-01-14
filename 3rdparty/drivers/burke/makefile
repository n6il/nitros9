ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

DEPENDS		= ./makefile
DRVRS		= bb1fhdisk.dr bb1hd.dr bb1hdisk.dr bb1th.dr bb1thdisk.dr \
		bbhd.dr bbxfhdisk.dr bbxhdisk.dr \
		bbxthd.dr bkfhdisk.dr bbfhdisk.dr bbhdisk.dr
DESCS		=

ALLOBJS		= $(DRVRS) $(DESCS)

all:	$(ALLOBJS) $(DEPENDS)

clean:
	$(RM) $(ALLOBJS)

