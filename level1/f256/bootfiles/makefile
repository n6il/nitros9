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

BOOTFILE = $(MD)/krn $(MD)/krnp2 $(MD)/init $(MD)/ioman $(MD)/scf.mn $(MD)/vtio.dr \
		$(MD)/term.dt $(MD)/clock_60hz $(MD)/clock2_f256 $(MD)/sysgo $(CMDSDIR)/shell_21 \
		$(CMDSDIR)/setime $(CMDSDIR)/date $(CMDSDIR)/mdir $(CMDSDIR)/mfree $(CMDSDIR)/procs \
	      	$(CMDSDIR)/devs $(CMDSDIR)/irqs $(CMDSDIR)/display $(CMDSDIR)/debug $(CMDSDIR)/ident

ALLOBJS		= booter example

all:	$(ALLOBJS)

booter: booter.asm
	$(AS) $< -o$@ --raw
	$(PADROM) 4096 $@
	$(MERGE) $(BOOTFILE)>bootfile
	$(PADROM) -b
	$(PADROM) -b 56560 bootfile
	$(PADROM) 57328 bootfile
	printf "\x00\x00\x01\x00\x01\x03\x01\x0f\x01\x0c\x01\x06\x01\x09\x10\x00" > vectors
	cat $@ bootfile vectors > booter2
	mv booter2 $@

example: example.asm
	$(AS) $< -o$@ --raw

upload: booter
	upload booter 1000

clean:
	$(RM) $(ALLOBJS) bootfile booter vectors