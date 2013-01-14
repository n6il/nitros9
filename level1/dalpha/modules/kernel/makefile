PORT = dalpha
ifndef  NITROS9DIR
NITROS9DIR      = $(HOME)/nitros9
endif
include $(NITROS9DIR)/rules.mak

vpath %.asm $(LEVEL1)/modules/kernel

AFLAGS		+= -I$(LEVEL1)/modules/kernel
DEPENDS		= ./makefile

KERNEL		= krn
KERNELP2	= krnp2
SYSCALLS	= fcmpnam.asm fprsnam.asm

ALLOBJS		= $(KERNEL) $(KERNELP2)

all:	$(ALLOBJS)

$(KERNEL):	krn.asm $(SYSCALLS)

$(KERNELP2):	krnp2.asm $(SYSCALLS)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

showcopyobjs:
	@$(ECHO) $(COPYOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
