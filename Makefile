# - Adam Koprowski 12/04/2010

######################################################################################################

include Makefile-XSLT

DATA_FILES := $(shell find ./data -name '*.xml') data/books.xml data/book-authors.xml data/movies.xml

PAPERS := $(shell $(RUN_XSLT) -im:list-papers data/papers.xml xsl/papers.xsl)
PAPERS_HTML := $(PAPERS:%=output/paper-%.html)

PAGES := $(shell $(RUN_XSLT) -im:list-file-ids data/menu.xml xsl/preview_menu.xsl)
PAGES_HTML := $(PAGES:%=output/%.html)

AUTHORS := $(shell $(RUN_XSLT) data/books.xml xsl/books-list-authors.xsl)
AUTHORS_HTML := $(AUTHORS:%=output/book-author/%.html)

HTML := $(PAGES_HTML) $(PAPERS_HTML) $(AUTHORS_HTML)

XSLT := $(shell find -name '*.xsl') 
XSLT_FILES := $(XSLT:%=xslt/%) 

######################################################################################################

.PHONY: clean all preview publish update update-books

all: $(HTML) output/bibliography.bib output/bibliography.pdf preview

update: update-books all

preview: preview/menu.html preview/talks.html preview/books.html

publish: all
	$(SHOW) Publishing...
	$(HIDE) weex ak

snapshot: all
	$(SHOW) Creating snapshot...
	$(HIDE) tar -chzf snapshots/webpage-`date +%Y%m%d`.tar.gz output

clean:
	$(SHOW) Cleaning...
	$(HIDE) rm -fr output/*.html output/papers/*.html preview output/bibliography.bib output/bibliography.pdf output/book-author/*.html

update-books:
	$(HIDE) make -C LibraryThing

# creates simple HTML output for all XML data, that allows to check data integrity
preview/%.html: xsl/preview_%.xsl data/%.xml
	$(SHOW) Generating: [$@]
	$(HIDE) mkdir -p preview
	$(HIDE) $(RUN_XSLT) -o $@ data/$*.xml xsl/preview_$*.xsl

output/bibliography.pdf: output/bibliography.bib output/bibliography.tex
	$(SHOW) Generating: [$@]
	$(HIDE) cd output && pdflatex bibliography.tex > /dev/null 
	$(HIDE) cd output && bibtex bibliography > /dev/null
	$(HIDE) cd output && for i in {1..3}; do pdflatex bibliography.tex > /dev/null; done
	$(HIDE) cd output && rm -fr bibliography.aux bibliography.bbl bibliography.blg bibliography.log  > /dev/null

# all per-paper pages
output/paper-%.html: pages/paper.xml $(DATA_FILES) $(XSLT)
	$(SHOW) Generating: [$@]
	$(HIDE) $(RUN_XSLT) -o $@ pages/paper.xml xsl/paper.xsl paper-id=$*

# all per-paper pages
output/book-author/%.html: pages/books-authors.xml $(DATA_FILES) $(XSLT)
	$(SHOW) Generating: [$@]
	$(HIDE) $(RUN_XSLT) -o $@ $< xsl/book-author.xsl author=$*

# regular pages 
output/%.html: pages/%.xml $(DATA_FILES) $(XSLT)
	$(SHOW) Generating: [$@]
	$(HIDE) $(RUN_XSLT) -o $@ pages/$*.xml pages/`grep xml-stylesheet pages/$*.xml | sed -e 's/.*href="\(.*\)".*/\1/'`

# bibliography
output/bibliography.bib: $(DATA_FILES) $(XSLT) 
	$(SHOW) Generating: [$@]
	$(HIDE) $(RUN_XSLT) -o $@ data/papers.xml xsl/biblio.xsl
