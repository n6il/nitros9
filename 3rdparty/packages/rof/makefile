include ../../../Makefile.rules

DEPENDS		= ./Makefile

DISK		= rof.dsk
CMDS		= rescue
SUPPORTFILES	= body heads larms legs lips panel1 rofvar rship.c rtitle.c \
		scores
ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	$(CHMOD) 755 $(CMDS)

clean:	dskclean
	$(RM) $(ALLOBJS)

dsk:	all
	$(RM) $(DISK)
	$(OS9FORMAT) $(DISK)
	$(OS9GEN) $(DISK) $(LEVEL2)/BOOTFILES/bootfile_stock $(LEVEL2)/BOOTFILES/kernel_stock
	$(MAKDIR) $(DISK):CMDS
	$(CP) $(CMDS) $(DISK):CMDS
	$(OS9RENAME) $(DISK):CMDS/rescue AutoEx
	$(CP) $(SUPPORTFILES) $(DISK):.

dskclean:
	$(RM) $(DISK)
