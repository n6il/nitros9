DOCBOOKDSL      = /usr/share/sgml/docbook/dsssl-stylesheets/print/docbook.dsl
XMLDCL          = /usr/share/doc/openjade-1.3.1/pubtext/xml.dcl
BOOK		= ccguide
STYLESHEET	= ../stylesheets/docbook-utils.dsl

PREFACE		= intro.preface
CHAPTERS	= chap1.chapter chap2.chapter chap3.chapter chap4.chapter
STDLIB		= atof.refentry fclose.refentry feof.refentry \
		findstr.refentry fopen.refentry fread.refentry \
		fseek.refentry getc.refentry gets.refentry isalpha.refentry \
		l3tol.refentry longjmp.refentry malloc.refentry \
		mktemp.refentry printf.refentry putc.refentry puts.refentry \
		qsort.refentry scanf.refentry setbuf.refentry sleep.refentry \
		strcat.refentry system.refentry toupper.refentry \
		ungetc.refentry

APPS		= asm.appendix basic09.appendix errors.appendix phases.appendix \
                creference.appendix

SYSCALL		= abort.refentry abs.refentry access.refentry chain.refentry \
		chdir.refentry chmod.refentry chown.refentry close.refentry \
		crc.refentry creat.refentry defdrive.refentry dup.refentry \
		exit.refentry getpid.refentry getstat.refentry \
		getuid.refentry intercept.refentry kill.refentry \
		lseek.refentry mknod.refentry modload.refentry \
		munlink.refentry open.refentry os9fork.refentry \
		os9.refentry pause.refentry prerr.refentry read.refentry \
		sbrk.refentry setime.refentry setpr.refentry setstat.refentry \
		setuid.refentry signal.refentry stacksize.refentry \
		strass.refentry tsleep.refentry unlink.refentry \
		wait.refentry write.refentry

SUPPORT		= $(PREFACE) $(CHAPTERS) $(APPS) $(STDLIB) $(SYSCALL)

all:	$(BOOK).pdf

# Check for syntax errors in XML
lint:
	xmllint --valid --noout $(BOOK).docbook

$(BOOK).pdf: $(BOOK).docbook $(SUPPORT)
	docbook2pdf -d "$(STYLESHEET)#print" $(BOOK).docbook

xmlto: $(BOOK).docbook
	xmlto pdf $(BOOK).docbook

$(BOOK).ps: $(BOOK).docbook
	docbook2ps -d "$(STYLESHEET)#print" $(BOOK).docbook

# This rule is an alternative way to produce a PDF document
xml-pdf:
	openjade -t tex -o $(BOOK).tex -d $(DOCBOOKDSL) $(XMLDCL) $(BOOK).docbook
	pdfjadetex $(BOOK).tex


$(BOOK).html: $(BOOK).docbook
	$(RM) *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(BOOK).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d "$(STYLESHEET)#html" $(BOOK).docbook

print: $(BOOK).ps
	psnup -2 $(BOOK).ps | lpr

clean:
	$(RM) *.html *.tex *.out $(BOOK).pdf $(BOOK).ps
