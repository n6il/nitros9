BOOK		= basic09
STYLESHEET	= ../stylesheets/docbook-utils.dsl

all: $(BOOK).pdf

$(BOOK).pdf: $(BOOK).docbook $(STYLESHEET)
	 docbook2pdf -d $(STYLESHEET)#print $(BOOK).docbook

$(BOOK).ps: $(BOOK).docbook $(STYLESHEET)
	 docbook2ps -d $(STYLESHEET)#print $(BOOK).docbook

$(BOOK).html: $(BOOK).docbook $(STYLESHEET)
	$(RM) *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(BOOK).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d $(STYLESHEET)#html $(BOOK).docbook

print:
	psnup -2 $(BOOK).ps | lpr

clean:
	$(RM) *.html $(BOOK).pdf $(BOOK).ps
