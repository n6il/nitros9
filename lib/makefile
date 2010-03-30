include $(NITROS9DIR)/rules.mak

all: sys6809l1.l sys6809l2.l sys6309l2.l net.l alib.l

sys6809l1.l: sys6809l1.a

sys6809l2.l: sys6809l2.a

sys6309l2.l: sys6309l2.a

net.l: net.a

alib.l:
	cd alib; make; cp alib.l ..

clean:
	$(RM) *.l *.r
	$(RM) alib/*.r
