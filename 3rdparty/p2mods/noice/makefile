include $(NITROS9DIR)/rules.mak

AFLAGS		+= #-ASWI

MD              = $(6809L1)/modules
CMD             = $(6809L1)/cmds
BD              = ../../booters


all:	calldbg krnp3_6309 krnp3_6809

calldbg: calldbg.asm
#	$(AS) $(ASOUT)$@ $<

krnp3_6309: noice.asm
	$(AS) $(ASOUT)$@ $< -aKRNMOD -aH6309 -e $(AFLAGS)

krnp3_6809: noice.asm
	$(AS) $(ASOUT)$@ $< -aKRNMOD $(AFLAGS)

clean:
	$(RM) calldbg krnp3_6309 krnp3_6809
