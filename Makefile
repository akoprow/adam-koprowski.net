# - Adam Koprowski 12/04/2010

.PHONY: clean all preview

######################################################################################################

SAXON_JAR ?= ./saxon/saxon9he.jar
SAXON := java -jar $(SAXON_JAR)

XSLTPROC := xsltproc

RUN_XSLT := $(SAXON)

DATA := menu papers talks
DATA_FILES := $(DATA:%=data/%.xml)

PAPERS := $(shell grep -e 'id=".*"' data/papers.xml | sed -e 's/.*id="\(.*\)".*/\1/')
PAPER_FILES := $(PAPERS:%=paper-%)

HTML := $(shell grep -e 'urlid=".*"' data/menu.xml | sed -e 's/.*urlid="\(.*\)".*/\1/') $(PAPER_FILES)
HTML_FILES := $(HTML:%=output/%.html)

XSLT := $(shell find -name '*.xsl') 
XSLT_FILES := $(XSLT:%=xslt/%) 

######################################################################################################

all: $(HTML_FILES) preview

preview: preview/menu.html preview/talks.html

clean:
	rm -fr output/*.html preview

# creates simple HTML output for all XML data, that allows to check data integrity
preview/%.html: xsl/preview_%.xsl data/%.xml
	$(RUN_XSLT) -o $@ data/$*.xml xsl/preview_$*.xsl

# all per-paper pages
output/paper-%.html: pages/paper.xml $(DATA_FILES) $(XSLT)
	$(RUN_XSLT) -o $@ pages/paper.xml xsl/paper.xsl paper-id=$*

# all pages with corresponding XSLT stylesheet 
output/%.html: pages/%.xml xsl/%.xsl $(DATA_FILES)
	$(RUN_XSLT) -o $@ pages/$*.xml xsl/$*.xsl

# ... otherwise use the default stylesheet 
output/%.html: pages/%.xml $(DATA_FILES)
	$(RUN_XSLT) -o $@ pages/$*.xml xsl/page.xsl
