SRC=ccguide
STYLESHEET=docbook-utils.dsl

PREFACE=intro.preface
CHAPTERS=chap1.chapter chap2.chapter chap3.chapter chap4.chapter
STDLIB= atof.refentry fflush.refentry feof.refentry findstr.refentry \
    fopen.refentry fread.refentry fseek.refentry getc.refentry \
    gets.refentry isalpha.refentry l3tol.refentry longjmp.refentry \
    malloc.refentry mktemp.refentry putc.refentry puts.refentry \
    qsort.refentry scanf.refentry setbuf.refentry sleep.refentry \
    strcat.refentry system.refentry toupper.refentry ungetc.refentry

APPS=asm.appendix basic09.appendix errors.appendix phases.appendix

SYSCALL= abort.refentry abs.refentry access.refentry chain.refentry \
    chdir.refentry chmod.refentry chown.refentry close.refentry \
    crc.refentry creat.refentry defdrive.refentry dup.refentry \
    exit.refentry getpid.refentry getstat.refentry getuid.refentry \
    intercept.refentry kill.refentry lseek.refentry mknod.refentry \
    modload.refentry munlink.refentry open.refentry os9fork.refentry \
    os9.refentry pause.refentry prerr.refentry printf.refentry \
    read.refentry sbrk.refentry setime.refentry setpr.refentry \
    setstat.refentry setuid.refentry signal.refentry stacksize.refentry \
    strass.refentry tsleep.refentry unlink.refentry wait.refentry \
    write.refentry

SUPPORT=$(PREFACE) $(CHAPTERS) $(APPS) $(STDLIB) $(SYSCALL)

all: $(SRC).pdf

$(SRC).pdf: $(SRC).docbook $(SUPPORT)
	 docbook2pdf -d docbook-utils-a4.dsl#print $(SRC).docbook

$(SRC).ps: $(SRC).docbook
	 docbook2ps -d docbook-utils-a4.dsl#print $(SRC).docbook
#	 docbook2ps -d $(STYLESHEET) $(SRC).docbook

$(SRC).html: $(SRC).docbook
	rm -f *.htm *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(SRC).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d docbook-utils-a4.dsl#html $(SRC).docbook

clean:
	rm -f *.htm *.html $(SRC).pdf $(SRC).ps
print: $(SRC).ps
	psnup -2 $(SRC).ps | lpr
