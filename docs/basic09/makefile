OBJ=basic09
STYLESHEET=docbook-utils.dsl

all: book1.htm

$(OBJ).pdf: $(OBJ).docbook $(STYLESHEET)
	 docbook2pdf -d $(STYLESHEET) $(OBJ).docbook

$(OBJ).ps: $(OBJ).docbook $(STYLESHEET)
	 docbook2ps -d $(STYLESHEET) $(OBJ).docbook

book1.htm: $(OBJ).docbook $(STYLESHEET)
	rm -f *.htm *.html
#	jade -t sgml -V html-index -d /usr/share/sgml/docbook/dsssl-stylesheets-1.64/html/docbook.dsl $(OBJ).docbook
#	collateindex.pl -p -o index.docbook HTML.index
	docbook2html -d $(STYLESHEET)#html $(OBJ).docbook

print:
	psnup -2 $(OBJ).ps | lpr
