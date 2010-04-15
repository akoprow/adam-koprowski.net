# - Adam Koprowski 12/04/2010

.PHONY: clean all

HTML := $(shell grep -e 'urlid=".*"' data/menu.xml | sed -e 's/.*urlid="\(.*\)".*/\1/')
HTML_FILES := $(HTML:%=output/%.html)

all: $(HTML_FILES) preview

preview: preview/menu.html preview/talks.html

clean:
	rm -f output/*.html preview

preview/%.html: preview_%.xsl data/%.xml
	xsltproc -o $@ preview_$*.xsl data/$*.xml

output/%.html: webpage.xsl pages/%.xml
	xsltproc -o $@ webpage.xsl pages/$*.xml
