SRC=os9guide
STYLESHEET=docbook-utils.dsl

all: $(SRC).html

$(SRC).pdf: $(SRC).docbook
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
