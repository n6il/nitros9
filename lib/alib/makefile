# Makefile to create assembler library
include $(NITROS9DIR)/rules.mak


SRC = stimestr.a datestr.a getfmd.a mktemp.a linedit.a sho_regs.a \
	print_dec.a print_hex.a print_asc.a \
	mult16x8.a mult16x16.a div16x8.a div16x16.a div8x8.a \
	dec_bin.a bin_dec.a asc_bin.a bin_asc.a hex_bin.a \
	bin_hex.a bin2hex.a dectab.a bin_rom.a \
	strcat.a strcpy.a strncpy.a parsnstr.a strhcpy.a strhlen.a \
	strcmp.a strncmp.a strlen.a memmove.a ptsearch.a compare.a \
	b09strlen.a \
	to_upprs.a to_upper.a to_lowrs.a to_lower.a \
	is_punct.a is_print.a is_cntrl.a is_space.a is_xdigit.a \
	is_alnum.a is_alpha.a is_digit.a is_lower.a is_upper.a is_termin.a \
	prints.a puts.a fputs.a putcr.a fputcr.a putspace.a fputspace.a \
	putc.a fputc.a inkey.a getc.a fgetc.a gets.a fgets.a puty.a fputy.a \
	gety.a fgety.a ftrans.a \
	frewind.a ftoeof.a \
	jsr_cmd.a jsr_cmd2.a \
	to_sp.a to_non_sp.a memset.a rnd.a

MODS = stimestr.r datestr.r getfmd.r mktemp.r linedit.r sho_regs.r \
	print_dec.r print_hex.r print_asc.r \
	mult16x8.r mult16x16.r div16x8.r div16x16.r div8x8.r \
	dec_bin.r bin_dec.r asc_bin.r bin_asc.r hex_bin.r \
	bin_hex.r bin2hex.r dectab.r bin_rom.r \
	strcat.r strcpy.r strncpy.r parsnstr.r strhcpy.r strhlen.r \
	strcmp.r strncmp.r strlen.r memmove.r ptsearch.r compare.r \
	b09strlen.r \
	to_upprs.r to_upper.r to_lowrs.r to_lower.r \
	is_punct.r is_print.r is_cntrl.r is_space.r is_xdigit.r \
	is_alnum.r is_alpha.r is_digit.r is_lower.r is_upper.r is_termin.r \
	prints.r puts.r fputs.r putcr.r fputcr.r putspace.r fputspace.r \
	putc.r fputc.r inkey.r getc.r fgetc.r gets.r fgets.r puty.r fputy.r \
	gety.r fgety.r ftrans.r \
	frewind.r ftoeof.r \
	jsr_cmd.r jsr_cmd2.r \
	to_sp.r to_non_sp.r memset.r rnd.r


all:	../alib.l

../alib.l: $(MODS)
	lwar -c $@ $?

dskclean: clean

clean:
	$(RM) *.r ../alib.l ../alib.zip
