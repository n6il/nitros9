BOOK		= os9guide
STYLESHEET	= docbook-utils.dsl

all:	$(BOOK).pdf

$(BOOK).pdf: $(BOOK).docbook
	 docbook2pdf -d docbook-utils-a4.dsl#print $(BOOK).docbook

$(BOOK).ps: $(BOOK).docbook
	 docbook2ps -d docbook-utils-a4.dsl#print $(BOOK).docbook
#	 docbook2ps -d $(STYLESHEET) $(BOOK).docbook

$(BOOK).html: $(BOOK).docbook
	$(RM) *.htm *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(BOOK).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d docbook-utils-a4.dsl#html $(BOOK).docbook

print: $(BOOK).ps
	psnup -2 $(BOOK).ps | lpr

clean:
	$(RM) *.htm *.html $(BOOK).pdf $(BOOK).ps
