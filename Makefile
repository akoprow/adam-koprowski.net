# - Adam Koprowski 12/04/2010

.PHONY: clean all

HTML := $(shell grep -e 'urlid=".*"' menu.xml | sed -e 's/.*urlid="\(.*\)".*/\1/')
HTML_FILES := $(HTML:%=output/%.html)

all: $(HTML_FILES) preview

preview: preview/menu.html preview/talk_list.html

clean:
	rm -f output/*.html

preview/%.html: preview_%.xsl %.xml
	xsltproc -o $@ preview_$*.xsl $*.xml

output/%.html: webpage.xsl %.xml
	xsltproc -o $@ webpage.xsl $*.xml
