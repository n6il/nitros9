PORT = atari
include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

BOOTFILE_P1 = $(MD)/krnp2 $(MD)/init \
		$(MD)/ioman $(MD)/scf.mn $(MD)/vtio.dr $(MD)/term.dt \
		$(MD)/sysgo \
		$(MD)/clock_60hz $(MD)/clock2_soft \
		$(MD)/krn

BOOTFILE_P2 = $(MD)/rbf.mn $(MD)/rbdw3.dr \
		$(MD)/x0.dd $(MD)/x1.dd $(MD)/dw3.sb \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(CD)/shell_21 $(CD)/ded $(CD)/iniz $(CD)/deiniz

BOOTFILES	= bootfile

ALLOBJS		= $(BOOTFILES)

all:	$(ALLOBJS)

bootfile: $(BOOTFILE_P1) $(BOOTFILE_P2) $(DEPENDS)
	$(MERGE) $(BOOTFILE_P1)>$@_p1
	$(MERGE) $(BOOTFILE_P2)>$@_p2
	$(PADROM) -b 10240 $@_p1
	$(PADROM) -b 12288 $@_p1
	$(MERGE) $@_p2 $@_p1>$@
	$(RM) $@_p2 $@_p1
	$(PADROM) -b 32768 $@

clean:
	$(RM) $(ALLOBJS)

