BOOKL1		= os9l1guide
BOOKL2		= os9l2guide
STYLESHEET	= ../stylesheets/docbook-utils.dsl

all:	$(BOOKL1).pdf $(BOOKL2).pdf

$(BOOKL1).pdf: $(BOOKL1).docbook $(SRCS)
	 docbook2pdf -d $(STYLESHEET)#print $(BOOKL1).docbook

$(BOOKL2).pdf: $(BOOKL2).docbook $(SRCS)
	 docbook2pdf -d $(STYLESHEET)#print $(BOOKL2).docbook

$(BOOKL1).ps: $(BOOKL1).docbook $(SRCS)
	 docbook2ps -d $(STYLESHEET)#print $(BOOKL1).docbook

$(BOOKL2).ps: $(BOOKL2).docbook $(SRCS)
	 docbook2ps -d $(STYLESHEET)#print $(BOOKL2).docbook

$(BOOKL1).html: $(BOOKL1).docbook $(SRCS)
	$(RM) *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(BOOKL1).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d $(STYLESHEET)#html $(BOOKL1).docbook

$(BOOKL2).html: $(BOOKL2).docbook $(SRCS)
	$(RM) *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(BOOKL2).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d $(STYLESHEET)#html $(BOOKL2).docbook

print: $(BOOKL1).ps $(BOOKL2).ps
	psnup -2 $(BOOKL1).ps | lpr
	psnup -2 $(BOOKL2).ps | lpr

clean:
	$(RM) *.html $(BOOKL1).pdf $(BOOKL1).ps $(BOOKL2).pdf \
	      $(BOOKL2).ps *.log *.out *.aux

SRCS          = $(CHAPS) $(APXS) $(REFS)
CHAPS         = intro.preface \
                chap1.chapter chap2.chapter chap3.chapter chap4.chapter \
                chap5.chapter chap6.chapter chap7.chapter
APXS          = acia51.appendix display.appendix errorcodes.appendix keys.appendix
REFS          = asm.refentry \
                attr.refentry \
                backup.refentry \
                binex.refentry \
                build.refentry \
                chd.refentry \
                cmp.refentry \
                cobbler.refentry \
                config.refentry \
                copy.refentry \
                date.refentry \
                dcheck.refentry \
                debug.refentry \
                deiniz.refentry \
                deldir.refentry \
                del.refentry \
                dir.refentry \
                display.refentry \
                dsave.refentry \
                dump.refentry \
                echo.refentry \
                error.refentry \
                ex.refentry \
                format.refentry \
                free.refentry \
                go51.appendix \
                go51.refentry \
                help.refentry \
                ident.refentry \
                iniz.refentry \
                kill.refentry \
                link.refentry \
                list.refentry \
                load.refentry \
                login.refentry \
                makdir.refentry \
                mdir.refentry \
                merge.refentry \
                mfree.refentry \
                os9gen.refentry \
                park.refentry \
                printerr.refentry \
                procs.refentry \
                pwd.refentry \
                rename.refentry \
                save.refentry \
                setime.refentry \
                setpr.refentry \
                shell.refentry \
                sleep.refentry \
                tee.refentry \
                tmode.refentry \
                tsmon.refentry \
                tuneport.refentry \
                unlink.refentry \
                verify.refentry \
                xmode.refentry
