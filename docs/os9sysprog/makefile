BOOK		= os9sysprog
STYLESHEET	= docbook-utils.dsl

all:	$(BOOK).pdf

$(BOOK).pdf: $(BOOK).docbook $(STYLESHEET)
	 docbook2pdf $(BOOK).docbook

$(BOOK).ps: $(BOOK).docbook $(STYLESHEET)
	 docbook2ps $(BOOK).docbook
#	 docbook2ps -d $(STYLESHEET) $(BOOK).docbook

$(BOOK).html: $(BOOK).docbook $(STYLESHEET)
	rm -f *.htm *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(BOOK).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html $(BOOK).docbook

print:
	psnup -2 $(BOOK).ps | lpr

clean:
	$(RM) *.htm *.html $(BOOK).pdf $(BOOK).ps
