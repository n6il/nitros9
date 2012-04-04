PORT = atari
include $(NITROS9DIR)/rules.mak

# Module directory
MD		= ../modules
# Commands directory
CD		= ../cmds

DEPENDS		= ./makefile

# IMPORTANT! KRN MUST BE THE LAST MODULE IN BOOTFILE_P1!!
BOOTFILE_P1 = $(MD)/krnp2 $(MD)/init $(MD)/ioman $(MD)/sysgo \
		$(MD)/dw3.sb \
		$(MD)/clock_60hz $(MD)/clock2_soft \
          $(MD)/krn

BOOTFILE_P2 = $(MD)/scf.mn $(MD)/vtio.dr $(MD)/term.dt \
		$(MD)/rbf.mn $(MD)/rbdw3.dr \
		$(MD)/ddx0.dd $(MD)/x1.dd \
		$(MD)/scdwp.dr $(MD)/p_scdwp.dd \
		$(CD)/shell_21

BOOTFILES	= bootfile

ALLOBJS		= $(BOOTFILES)

all:	$(ALLOBJS)

bootfile: $(BOOTFILE_P1) $(BOOTFILE_P2) $(DEPENDS)
	$(MERGE) $(BOOTFILE_P1)>$@_p1
	ls -l $@_p1
	$(PADROM) -b 7168 $@_p1
	$(PADROM) -b 9216 $@_p1
	$(MERGE) $(BOOTFILE_P2)>$@_p2
	ls -l $@_p2
	$(MERGE) $@_p2 $@_p1>$@
	$(PADROM) -b 29696 $@

clean:
	$(RM) $(ALLOBJS)

