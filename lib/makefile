ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

SRC = os9defs.a scfdefs.a rbfdefs.a pipedefs.a systype.a net.a

all: sys6809l1.l sys6809l2.l sys6309l2.l net.l alib.l sys.zip

sys.zip: $(SRC)
	zip $@ $(SRC)

sys6809l1.l: sys6809l1.a

sys6809l2.l: sys6809l2.a

sys6309l2.l: sys6309l2.a

net.l: net.a

alib.l:
	cd alib; make

clean:
	$(RM) *.l *.r *.zip
	cd alib; make clean
