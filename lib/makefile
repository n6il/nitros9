include $(NITROS9DIR)/rules.mak

all: libnos96809l1.a libnos96809l2.a libnos96309l2.a libnet.a libalib.a

libnos96809l1.a: sys6809l1.o
	lwar -c $@ $?

libnos96809l2.a: sys6809l2.o
	lwar -c $@ $?

libnos96309l2.a: sys6309l2.o
	lwar -c $@ $?

libnet.a: net.o
	lwar -c $@ $?

libalib.a:
	cd alib; make

clean:
	$(RM) *.a *.o
	cd alib; make clean
