# - Adam Koprowski 12/04/2010

.PHONY: clean all preview

######################################################################################################

SAXON_JAR ?= ./saxon/saxon9.jar
SAXON := java -jar $(SAXON_JAR)
RUN_XSLT := $(SAXON)

DATA := menu papers talks
DATA_FILES := $(DATA:%=data/%.xml)

PAPERS := $(shell $(RUN_XSLT) -im:list-papers data/papers.xml xsl/papers.xsl)
PAPERS_HTML := $(PAPERS:%=output/paper-%.html)

PAGES := $(shell $(RUN_XSLT) -im:list-file-ids data/menu.xml xsl/preview_menu.xsl)
PAGES_HTML := $(PAGES:%=output/%.html)

HTML := $(PAGES_HTML) $(PAPERS_HTML)

XSLT := $(shell find -name '*.xsl') 
XSLT_FILES := $(XSLT:%=xslt/%) 

######################################################################################################

all: $(HTML) preview

preview: preview/ preview/menu.html preview/talks.html

clean:
	rm -fr output/*.html output/papers/*.html preview

preview/:
	mkdir preview
	
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
