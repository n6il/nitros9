#  makefile for Micro emacs for os9/68000
# temp files on ram disk
CFLAGS = -t=/r0

MAINR  = uemain1.r uemain2.r uemain3.r uemain4.r uemaintable.r
DISPR  = uedisplay1.r uedisplay2.r uedisplay3.r
RESTR  = uebasic.r uebuffer1.r uebuffer2.r uefile1.r uefile2.r uefileio.r \
  ueline1.r ueline2.r uerandom1.r uerandom2.r ueregion.r uesearch.r uespawn.r \
  uetermio.r uevt52.r uewindow.r ueword.r
RFILES = $(MAINR) $(DISPR) $(RESTR)

# use cio libarary
umacs: $(RFILES)
  cc -i $(RFILES) -f=umacs
  
$(MAINR): ueed.h uemain.h
$(DISPR): ueed.h uedisplay.h
$(RESTR): ueed.h

