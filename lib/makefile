include $(NITROS9DIR)/rules.mak

SRC = os9s.a scfs.a rbfs.a pipes.a systype.a net.a drivewire.a

all: sys6809l1.l sys6809l2.l sys6309l2.l net.l alib.l

sys6809l1.l: sys6809l1.a

sys6809l2.l: sys6809l2.a

sys6309l2.l: sys6309l2.a

net.l: net.a

drivewire.l: drivewire.a

alib.l:
	cd alib; make

clean:
	$(RM) *.l *.r *.zip
	cd alib; make clean
