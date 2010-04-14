# - Adam Koprowski 12/04/2010

.PHONY: clean all

HTML := $(shell grep -e 'urlid=".*"' menu.xml | sed -e 's/.*urlid="\(.*\)".*/\1/')
HTML_FILES := $(HTML:%=output/%.html)

all: $(HTML_FILES)

clean:
	rm -f output/*.html

output/%.html: webpage.xsl %.xml
	xsltproc -o $@ webpage.xsl $*.xml
