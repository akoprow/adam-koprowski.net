<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="text" />
	
	<xsl:variable name="books" select="document('../data/books.xml')" />
	<xsl:variable name="authors" select="$books//book[not(author = preceding-sibling::book/author)]" />
	
	<xsl:template match="/">
		<xsl:for-each select="$authors">
                        <xsl:variable name="apos">'</xsl:variable>
 			<xsl:value-of select="replace(translate(author, ' ', '_'), $apos, '')" />
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
