include $(NITROS9DIR)/rules.mak

all: lib6809l1.a lib6809l2.a lib6309l2.a libnet.a libalib.a libdw.a

lib6809l1.a: sys6809l1.o
	lwar -c $@ $?

lib6809l2.a: sys6809l2.o
	lwar -c $@ $?

lib6309l2.a: sys6309l2.o
	lwar -c $@ $?

libnet.a: net.o
	lwar -c $@ $?

libdw.a: dw.o
	lwar -c $@ $?

libalib.a:
	cd alib; make

clean:
	$(RM) *.a *.o
	cd alib; make clean
