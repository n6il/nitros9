AS = rma

%.r: %.a
	$(AS) $(ASFLAGS) $< -O=$@

SRCFILES = prof.r pwent.r getopt.r adump.r defdrive.r popen.r swab.r\
		   pwcryp.r bsearch.r dirutil.r errmsg.r rgname.r datmods.r\
		   utime.r devtyp.r skip.r sets.r pflinit.r pffinit.r fopen.r\
		   puts.r gets.r mktemp.r fread.r fwrite.r printf.r scanf.r\
		   setbuf.r fseek.r putc.r ftelldummy.r getc.r fflush.r setbase.r\
		   findstr.r pfldummy.r pffdummy.r htoi.r htol.r ltoa.r xtoa.r\
		   system.r reverse.r strings.r strcmp.r strlen.r strncpy.r\
		   strncat.r strncmp.r strhcpy.r strtok.r strpbrk.r strspn.r index.r\
		   patmatch.r stringsu.r strucmp.r strnucmp.r case.r strclr.r\
		   memccpy.r memchr.r memcmp.r memcpy.r memset.r atol.r atoi.r\
		   iobata_a.r chcodes.r l3tol.r ltol3.r qsort.r sleep.r setjmp.r\
		   strass.r realloc.r calloc.r memory.r rand.r atof.r scale.r\
		   gs1.r gs2.r ss1.r ss2.r ss3.r dtrig.r hyp.r log.r trnser.r\
		   dsqrt.r dinc.r dtype.r dmul.r ddiv.r daddsub.r dser.r dcmpr.r\
		   abs.r minmax.r uminmax.r clmul.r cldiv.r claddsub.r clcompare.r\
		   clbits.r clnegcompl.r clconvert.r clmove.r clincdec.r clshifts.r\
		   clcommon.r ccmult.r ccmod.r ccdiv.r cshifts.r rpterr.r abort.r\
		   signal.r chown.r chmod.r stat.r access.r create.r open.r read.r\
		   write.r lseek.r misc.r mod.r dir.r mem.r time.r process.r id.r\
		   intercept.r syscall.r syscommon.r cfinish.r profdummy.r tidyup.r

clib.l: $(SRCFILES)
	@cat $(SRCFILES) >clib.l
	@echo didit

$(SRCFILES):

clean:
	rm -f *.r clib.l
