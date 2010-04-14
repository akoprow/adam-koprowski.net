# - Adam Koprowski 12/04/2010

.PHONY: clean all

HTML := $(shell grep -e '<id>.*</id>' menu.xml | sed -e 's/.*<id>\(.*\)<\/id>.*/\1/')
HTML_FILES := $(HTML:%=output/%.html)

all: $(HTML_FILES)

clean:
	rm -f output/*.html

output/%.html: webpage.xsl
	xsltproc -o $@ webpage.xsl $*.xml
