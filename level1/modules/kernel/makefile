include ../../../rules.mak

DEPENDS		= ./makefile

KERNEL		= kernel
KERNELP2	= kernelp2
SYSCALLS	= fcmpnam.asm fprsnam.asm

ALLOBJS		= $(KERNEL) $(KERNELP2)

all:	$(ALLOBJS)

$(KERNEL):	kernel.asm $(SYSCALLS)

$(KERNELP2):	kernelp2.asm $(SYSCALLS)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

showcopyobjs:
	@$(ECHO) $(COPYOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
