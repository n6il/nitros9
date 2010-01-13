include $(NITROS9DIR)/rules.mak

all: sys6809l1.l sys6809l2.l sys6309l2.l

sys6809l1.l: sys6809l1.a

sys6809l2.l: sys6809l2.a

sys6309l2.l: sys6309l2.a

sys6809l1.a:
	echo "DRAGON equ 0" > dragon
	echo "Level equ 1" > level
	echo "H6309 equ 0" > h6309
	$(MERGE) dragon level h6309 sys.a > $@

sys6809l2.a:
	echo "DRAGON equ 0" > dragon
	echo "Level equ 2" > level
	echo "H6309 equ 0" > h6309
	$(MERGE) dragon level h6309 sys.a > $@

sys6309l2.a:
	echo "DRAGON equ 0" > dragon
	echo "Level equ 2" > level
	echo "H6309 equ 1" > h6309
	$(MERGE) dragon level h6309 sys.a > $@

clean:
	$(RM) *.l *.r sys6809l1.a sys6809l2.a sys6309l2.a
