include ../../Makefile.rules

DEPENDS		= ./Makefile
CMDS		= os9p3_perr os9p4_regdump_6809 os9p4_regdump_6309 os9p3_sayhi sayhi tsayhi
ALLOBJS		= $(CMDS)

all:	$(ALLOBJS)
	@$(ECHO) "*********************************************"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*         3rd Party System Modules          *"
	@$(ECHO) "*                                           *"
	@$(ECHO) "*********************************************"

os9p4_regdump_6809: os9p4_regdump.asm
	$(AS) $(AFLAGS) $(ASOUT)$@ $<

os9p4_regdump_6309: os9p4_regdump.asm
	$(AS)  $(AFLAGS) $(ASOUT)$@ $< -aH6309=1

clean:
	$(RM) $(ALLOBJS)
