include ../../../rules.mak

vpath %.asm $(6809L2)/modules/kernel

DEPENDS		= ./makefile
ADDOPTS		= -e

KERNEL		= kernel
KERNELP2	= kernelp2
SYSCALLS	= fallimg.asm fallram.asm falltsk.asm faproc.asm fcmpnam.asm \
		fcpymem.asm fdatlog.asm fdelram.asm ffmodul.asm ffreehb.asm \
		fld.asm fldabx.asm flink.asm fmove.asm fnproc.asm fprsnam.asm \
		freboot.asm fsrqmem.asm fssvc.asm fvmodul.asm \
		fallbit.asm fallprc.asm fchain.asm fclrblk.asm fcrcmod.asm \
		fdelimg.asm fexit.asm ffind64.asm ffork.asm fgblkmp.asm \
		fgcmdir.asm fgmoddr.asm fgprdsc.asm fgprocp.asm ficpt.asm \
		fid.asm fmapblk.asm fmem.asm fsend.asm fsleep.asm fsprior.asm \
		fsswi.asm fstime.asm fsuser.asm funlink.asm funload.asm

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
