include $(NITROS9DIR)/rules.mak

SRC = os9s.as scfs.as rbfs.as pipes.as systype.as net.as drivewire.as

all: sys6809l1.a sys6809l2.a sys6309l2.a net.a alib.a drivewire.a

sys6809l1.a: sys6809l1.o
sys6809l2.a: sys6809l2.o
sys6309l2.a: sys6309l2.o
net.a: net.o

sys6809l1.o: sys6809l1.as
sys6809l2.o: sys6809l2.as
sys6309l2.o: sys6309l2.as
net.o: net.as

drivewire.a: drivewire.o

alib.a:
	cd alib; make

clean:
	$(RM) *.a *.o
	cd alib; make clean
