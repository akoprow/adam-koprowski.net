# - Adam Koprowski 12/04/2010

.PHONY: clean all preview publish

######################################################################################################

SHOW := @echo
HIDE := @

SAXON_JAR ?= ./saxon/saxon9.jar
SAXON := java -jar $(SAXON_JAR)
RUN_XSLT := $(SAXON)

DATA_FILES := $(shell find ./data -name '*.xml')

PAPERS := $(shell $(RUN_XSLT) -im:list-papers data/papers.xml xsl/papers.xsl)
PAPERS_HTML := $(PAPERS:%=output/paper-%.html)

PAGES := $(shell $(RUN_XSLT) -im:list-file-ids data/menu.xml xsl/preview_menu.xsl)
PAGES_HTML := $(PAGES:%=output/%.html)

HTML := $(PAGES_HTML) $(PAPERS_HTML)

XSLT := $(shell find -name '*.xsl') 
XSLT_FILES := $(XSLT:%=xslt/%) 

######################################################################################################

all: $(HTML) output/bibliography.bib preview

preview: preview/menu.html preview/talks.html preview/bibliography.pdf

publish:
	weex ak

clean:
	rm -fr output/*.html output/papers/*.html preview bibliography.aux bibliography.bbl bibliography.blg bibliography.log

# creates simple HTML output for all XML data, that allows to check data integrity
preview/%.html: xsl/preview_%.xsl data/%.xml
	mkdir -p preview
	$(SHOW) XSLT data/$*.xml [$@]
	$(HIDE) $(RUN_XSLT) -o $@ data/$*.xml xsl/preview_$*.xsl

preview/bibliography.pdf: output/bibliography.bib bibliography.tex
	$(SHOW) LATEX/Bibtex biblography.tex output/bibliography.bib [$@]
	$(HIDE) pdflatex bibliography.tex > /dev/null
	$(HIDE) bibtex bibliography
	$(HIDE) for i in {1..3}; do pdflatex bibliography.tex > /dev/null; done
	$(HIDE) mv bibliography.pdf preview/

# all per-paper pages
output/paper-%.html: pages/paper.xml $(DATA_FILES) $(XSLT)
	$(SHOW) XSLT pages/paper.xml "(paper-id=$*)" [$@]
	$(HIDE) $(RUN_XSLT) -o $@ pages/paper.xml xsl/paper.xsl paper-id=$*

# regular pages 
output/%.html: pages/%.xml $(DATA_FILES) $(XSLT)
	$(SHOW) XSLT pages/$*.xml [$@]
	$(HIDE) $(RUN_XSLT) -o $@ pages/$*.xml pages/`grep xml-stylesheet pages/$*.xml | sed -e 's/.*href="\(.*\)".*/\1/'`

# bibliography
output/bibliography.bib: $(DATA_FILES) $(XSLT) 
	$(SHOW) XSLT data/papers.xml [$@]
	$(HIDE) $(RUN_XSLT) -o $@ data/papers.xml xsl/biblio.xsl
