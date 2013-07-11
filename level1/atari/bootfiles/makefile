include ../port.mak

# Module directory
MD		= ../modules
# Commands directory
CMDSDIR		= ../cmds

DEPENDS		= ./makefile

RBDW       = $(MD)/rbdw.dr \
		$(MD)/ddx0.dd $(MD)/x1.dd $(MD)/x2.dd $(MD)/x3.dd
SCDWV_NET  = $(MD)/n_scdwv.dd $(MD)/n1_scdwv.dd $(MD)/n2_scdwv.dd \
		$(MD)/n3_scdwv.dd $(MD)/n4_scdwv.dd $(MD)/n5_scdwv.dd \
		$(MD)/n6_scdwv.dd $(MD)/n7_scdwv.dd $(MD)/n8_scdwv.dd \
		$(MD)/n9_scdwv.dd $(MD)/n10_scdwv.dd $(MD)/n11_scdwv.dd \
		$(MD)/n12_scdwv.dd $(MD)/n13_scdwv.dd $(MD)/midi_scdwv.dd
SCDWV_WIN  = $(MD)/z1_scdwv.dd $(MD)/z2_scdwv.dd $(MD)/z3_scdwv.dd \
		$(MD)/z4_scdwv.dd $(MD)/z5_scdwv.dd $(MD)/z6_scdwv.dd \
		$(MD)/z7_scdwv.dd 
SCDWP     = $(MD)/scdwp.dr $(MD)/p_scdwp.dd

# IMPORTANT! KRN MUST BE THE LAST MODULE IN BOOTFILE_P1!!
BOOTFILE_P1 = $(MD)/krnp2 $(MD)/init $(MD)/ioman $(MD)/sysgo \
		$(MD)/dwio.sb \
		$(MD)/clock_60hz $(MD)/clock2_dw \
          $(MD)/krn

BOOTFILE_P2 = $(MD)/scf.mn \
		$(MD)/vtio.dr $(MD)/term.dt \
		$(MD)/rbf.mn \
		$(RBDW) \
		$(MD)/scdwv.dr \
		$(SCDWV_NET) \
		$(SCDWV_WIN) \
		$(CMDSDIR)/shell_21

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
	$(RM) $(ALLOBJS) bootfile_p1 bootfile_p2

