include ../../../Makefile.rules

vpath %.asm $(LEVEL2)/MODULES/KERNEL

DEPENDS		= ./Makefile
ADDOPTS		= -e

OS9P1		= os9p1
OS9P2		= os9p2
SYSCALLS	= fallimg.asm fallram.asm falltsk.asm faproc.asm fcmpnam.asm \
		fcpymem.asm fdatlog.asm fdelram.asm ffmodul.asm ffreehb.asm \
		fld.asm fldabx.asm flink.asm fmove.asm fnproc.asm fprsnam.asm \
		freboot.asm fsrqmem.asm fssvc.asm fvmodul.asm \
		fallbit.asm fallprc.asm fchain.asm fclrblk.asm fcrcmod.asm \
		fdelimg.asm fexit.asm ffind64.asm ffork.asm fgblkmp.asm \
		fgcmdir.asm fgmoddr.asm fgprdsc.asm fgprocp.asm ficpt.asm \
		fid.asm fmapblk.asm fmem.asm fsend.asm fsleep.asm fsprior.asm \
		fsswi.asm fstime.asm fsuser.asm funlink.asm funload.asm

ALLOBJS		= $(OS9P1) $(OS9P2)

all:	$(ALLOBJS)

$(OS9P1):	os9p1.asm $(SYSCALLS)

$(OS9P2):	os9p2.asm $(SYSCALLS)

clean:
	$(RM) $(ALLOBJS)

showobjs:
	@$(ECHO) $(ALLOBJS)

showcopyobjs:
	@$(ECHO) $(COPYOBJS)

identify:
	$(IDENT_SHORT) $(ALLOBJS)
