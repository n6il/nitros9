BOOK            = articles
STYLESHEET      = ../stylesheets/docbook-utils.dsl

all: $(BOOK).pdf

$(BOOK).pdf: articles.docbook bootprocess.article ded.article diskcrash.article \
            os9software.article tutorial.article extensionmodule.article
	docbook2pdf -d $(STYLESHEET)#print $(BOOK).docbook
print:
	psnup -2 $(BOOK).ps | lpr

clean:
	$(RM) *.html $(BOOK).pdf $(BOOK).ps

