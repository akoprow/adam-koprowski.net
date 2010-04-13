# - Adam Koprowski 12/04/2010

.PHONY: clean all

HTML := $(shell grep -e '<url>.*</url>' menu.xml | sed -e 's/.*<url>\(.*\)<\/url>.*/\1/')
HTML_FILES := $(HTML:%=output/%)

all: $(HTML_FILES)

clean:
	rm -f output/*.html

output/%.html: webpage.xsl
	xsltproc -o $@ webpage.xsl menu.xml
