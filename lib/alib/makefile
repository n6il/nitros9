# Makefile to create assembler library
include $(NITROS9DIR)/rules.mak


SRC = stimestr.as datestr.as getfmd.as mktemp.as linedit.as sho_regs.as \
	print_dec.as print_hex.as print_asc.as \
	mult16x8.as mult16x16.as div16x8.as div16x16.as div8x8.as \
	dec_bin.as bin_dec.as asc_bin.as bin_asc.as hex_bin.as \
	bin_hex.as bin2hex.as dectab.as bin_rom.as \
	strcat.as strcpy.as strncpy.as parsnstr.as strhcpy.as strhlen.as \
	strcmp.as strncmp.as strlen.as memmove.as ptsearch.as compare.as \
	b09strlen.as \
	to_upprs.as to_upper.as to_lowrs.as to_lower.as \
	is_punct.as is_print.as is_cntrl.as is_space.as is_xdigit.as \
	is_alnum.as is_alpha.as is_digit.as is_lower.as is_upper.as is_termin.as \
	prints.as puts.as fputs.as putcr.as fputcr.as putspace.as fputspace.as \
	putc.as fputc.as inkey.as getc.as fgetc.as gets.as fgets.as puty.as fputy.as \
	gety.as fgety.as ftrans.as \
	frewind.as ftoeof.as \
	jsr_cmd.as jsr_cmd2.as \
	to_sp.as to_non_sp.as memset.as rnd.as

MODS = stimestr.o datestr.o getfmd.o mktemp.o linedit.o sho_regs.o \
	print_dec.o print_hex.o print_asc.o \
	mult16x8.o mult16x16.o div16x8.o div16x16.o div8x8.o \
	dec_bin.o bin_dec.o asc_bin.o bin_asc.o hex_bin.o \
	bin_hex.o bin2hex.o dectab.o bin_rom.o \
	strcat.o strcpy.o strncpy.o parsnstr.o strhcpy.o strhlen.o \
	strcmp.o strncmp.o strlen.o memmove.o ptsearch.o compare.o \
	b09strlen.o \
	to_upprs.o to_upper.o to_lowrs.o to_lower.o \
	is_punct.o is_print.o is_cntrl.o is_space.o is_xdigit.o \
	is_alnum.o is_alpha.o is_digit.o is_lower.o is_upper.o is_termin.o \
	prints.o puts.o fputs.o putcr.o fputcr.o putspace.o fputspace.o \
	putc.o fputc.o inkey.o getc.o fgetc.o gets.o fgets.o puty.o fputy.o \
	gety.o fgety.o ftrans.o \
	frewind.o ftoeof.o \
	jsr_cmd.o jsr_cmd2.o \
	to_sp.o to_non_sp.o memset.o rnd.o


all:	../libalib.a

../libalib.a: $(MODS)
	$(LWAR) $@ $?

dskclean: clean

clean:
	$(RM) *.o ../libalib.a
