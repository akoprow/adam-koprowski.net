# - Adam Koprowski 12/04/2010

.PHONY: clean all

DATA := menu papers talks
DATA_FILES := $(DATA:%=data/%.xml)

PAPERS := $(shell grep -e '<id>.*</id>' data/papers.xml | sed -e 's/.*<id>\(.*\)<\/id>.*/\1/')
PAPER_FILES := $(PAPERS:%=paper-%)

HTML := $(shell grep -e 'urlid=".*"' data/menu.xml | sed -e 's/.*urlid="\(.*\)".*/\1/') $(PAPER_FILES)
HTML_FILES := $(HTML:%=output/%.html)

XSLT := $(shell find -name '*.xsl') 
XSLT_FILES := $(XSLT:%=xslt/%) 

all: $(HTML_FILES) preview

preview: preview/menu.html preview/talks.html

clean:
	rm -fr output/*.html preview

preview/%.html: xsl/preview_%.xsl data/%.xml
	xsltproc -o $@ xsl/preview_$*.xsl data/$*.xml

# All per-paper pages
output/paper-%.html: pages/paper.xml $(DATA_FILES) $(XSLT)
	xsltproc -o $@ --stringparam paper-id $* xsl/publication-page.xsl pages/paper.xml 

# All pages with corresponding XSLT stylesheet 
output/%.html: pages/%.xml xsl/%.xsl $(DATA_FILES)
	xsltproc -o $@ xsl/$*.xsl pages/$*.xml 

# ... otherwise use the default stylesheet 
output/%.html: pages/%.xml $(DATA_FILES)
	xsltproc -o $@ xsl/page.xsl pages/$*.xml
