SRC=os9sysprog
STYLESHEET=docbook-utils.dsl

all: book1.htm

$(SRC).pdf: $(SRC).docbook $(STYLESHEET)
	 docbook2pdf -d $(STYLESHEET) $(SRC).docbook

$(SRC).ps: $(SRC).docbook $(STYLESHEET)
	 docbook2ps -d $(STYLESHEET) $(SRC).docbook

book1.htm: $(SRC).docbook $(STYLESHEET)
	rm -f *.htm *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(SRC).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d $(STYLESHEET) $(SRC).docbook

print:
	psnup -2 $(SRC).ps | lpr
