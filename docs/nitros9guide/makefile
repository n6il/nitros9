BOOK		= os9guide
STYLESHEET	= docbook-utils.dsl

all:	$(BOOK).pdf

$(BOOK).pdf: $(BOOK).docbook $(SRCS)
	 docbook2pdf -d docbook-utils-a4.dsl#print $(BOOK).docbook

$(BOOK).ps: $(BOOK).docbook $(SRCS)
	 docbook2ps -d docbook-utils-a4.dsl#print $(BOOK).docbook
#	 docbook2ps -d $(STYLESHEET) $(BOOK).docbook

$(BOOK).html: $(BOOK).docbook $(SRCS)
	$(RM) *.htm *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(BOOK).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d docbook-utils-a4.dsl#html $(BOOK).docbook

print: $(BOOK).ps
	psnup -2 $(BOOK).ps | lpr

clean:
	$(RM) *.htm *.html $(BOOK).pdf $(BOOK).ps
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
