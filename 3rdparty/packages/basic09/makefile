include ../../../Makefile.rules

DEBUGFLAG	= -aDEBUG=1    # 1 = DEBUG Mode, 0 = Normal Mode
EXTCMDFLAG	= -aEXTCMD=0   # 1 = Use READEX/WRITEX SCSI CDB, 0 = Use READ/WRITE
FLAGS		= $(DEBUGFLAG) $(EXTCMDFLAG)

# NitrOS-9
NITROSFLAGS	= $(AFLAGS) -aH6309=1 $(FLAGS)
# Non-NitrOS-9
OS9FLAGS	= $(AFLAGS) $(FLAGS)

DEPENDS		= ./Makefile
ALLOBJS		= basic09_6809 basic09_6309

all:	$(ALLOBJS) $(DEPENDS)

basic09_6309: basic09.asm
	$(AS) $(ASOUT)$@ $< $(NITROSFLAGS)

basic09_6809: basic09.asm
	$(AS) $(ASOUT)$@ $< $(OS9FLAGS)

clean:
	$(RM) $(ALLOBJS)

