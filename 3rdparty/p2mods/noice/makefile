include $(NITROS9DIR)/rules.mak

AFLAGS		+= #-ASWI

MD              = $(6809L1)/modules
CMD             = $(6809L1)/cmds
BD              = ../../booters


all:	calldbg krnp3_6309 krnp3_6809 krnp3_6309_mpi krnp3_6809_mpi

calldbg: calldbg.asm
#	$(AS) $(ASOUT)$@ $<

krnp3_6309: noice.asm
	$(AS) $(ASOUT)$@ $< -aKRNMOD -aH6309 -e $(AFLAGS)

krnp3_6309_mpi: noice.asm
	$(AS) $(ASOUT)$@ $< -aKRNMOD -aH6309 -e $(AFLAGS) -aMPI=1

krnp3_6809: noice.asm
	$(AS) $(ASOUT)$@ $< -aKRNMOD $(AFLAGS)

krnp3_6809_mpi: noice.asm
	$(AS) $(ASOUT)$@ $< -aKRNMOD $(AFLAGS) -aMPI=1

clean:
	$(RM) calldbg krnp3_6309 krnp3_6809 krnp3_6309_mpi krnp3_6809_mpi
