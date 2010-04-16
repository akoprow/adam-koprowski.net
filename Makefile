# - Adam Koprowski 12/04/2010

.PHONY: clean all

DATA := menu papers talks
DATA_FILES := $(DATA:%=data/%.xml)

PAPERS := $(shell grep -e '<id>.*</id>' data/papers.xml | sed -e 's/.*<id>\(.*\)<\/id>.*/\1/')
PAPER_FILES := $(PAPERS:%=paper-%)

HTML := $(shell grep -e 'urlid=".*"' data/menu.xml | sed -e 's/.*urlid="\(.*\)".*/\1/') $(PAPER_FILES)
HTML_FILES := $(HTML:%=output/%.html)

all: $(HTML_FILES) preview

preview: preview/menu.html preview/talks.html

clean:
	rm -fr output/*.html preview

preview/%.html: preview_%.xsl data/%.xml
	xsltproc -o $@ preview_$*.xsl data/$*.xml

output/paper-%.html: webpage.xsl pages/paper.xml $(DATA_FILES)
	xsltproc -o $@ --stringparam paper-id $* webpage.xsl pages/paper.xml 

output/%.html: webpage.xsl pages/%.xml $(DATA_FILES)
	xsltproc -o $@ webpage.xsl pages/$*.xml
