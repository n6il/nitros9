include $(NITROS9DIR)/rules.mak

all: libnos96809l1.a libnos96809l2.a libnos96309l2.a libnet.a libalib.a \
	libcoco.a libcoco3.a libcoco3_6309.a libdragon.a libatari.a

libnos96809l1.a: sys6809l1.o
	lwar -c $@ $?

libnos96809l2.a: sys6809l2.o
	lwar -c $@ $?

libnos96309l2.a: sys6309l2.o
	lwar -c $@ $?

libnet.a: net.o
	lwar -c $@ $?

libcoco.a: coco.o
	lwar -c $@ $?

libcoco3.a: coco3.o
	lwar -c $@ $?

libcoco3_6309.a: coco3_6309.o
	lwar -c $@ $?

libatari.a: atari.o
	lwar -c $@ $?

libdragon.a: dragon.o
	lwar -c $@ $?

libalib.a:
	cd alib; make

clean:
	$(RM) *.a *.o
	cd alib; make clean
