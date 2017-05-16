include ../port.mak

# Module directory
MD		= ../modules
# Commands directory
CMDSDIR		= ../cmds

DEPENDS		= ./makefile

BOOTROM		= $(MD)/kernel/krn $(MD)/kernel/krnp2 $(MD)/init $(MD)/boot_cshsd
ALLOBJS		= $(BOOTROM)

all:	bootrom

bootrom: $(BOOTROM)
	$(MERGE) $(BOOTROM) > bootrom_p1
	ls -l bootrom_p1
	$(PADROM) 3840 bootrom_p1
	$(MERGE) bootrom_p1 $(MD)/rel > $@
	ls -l $@
	$(PADROM) 8192 -b $@
	$(RM) bootrom_p1

clean:
	$(RM) bootrom bootrom_p1

