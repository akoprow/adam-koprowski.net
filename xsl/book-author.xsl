<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="ratings.xsl" />

	<xsl:output method="html" indent="no" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:param name="author" />

	<xsl:variable name="books" select="document('../data/books.xml')" />

	<xsl:template match="/">
		<xsl:variable name="author-dec" select="$books//book[translate(author, ' ', '_') = $author][1]/author" />
		<span class="author-tip">
			<ul>
				<xsl:for-each select="$books//book[author = $author-dec]">
					<xsl:sort order="descending" data-type="number" select="finished" />
					<xsl:call-template name="show-authors-book" />
				</xsl:for-each>
			</ul>
			<div style="clear: both;" />
		</span>
 	</xsl:template>

	<xsl:template name="show-authors-book">
		<LI>
	    	<table>
	    		<tr>
	    			<td class="cover">
						<img src="{cover-url}" height="100" />
					</td>
				</tr>
				<tr>
					<td class="rating">
						<xsl:call-template name="show-rating">
							<xsl:with-param name="rating" select="rating" />
						</xsl:call-template>					
					</td>
				</tr>
				<tr>
					<td class="title">
						<span>
							<xsl:value-of select="title" />
						</span>
					</td>
				</tr>
			</table>
		</LI>
		<xsl:if test="position() mod 5 = 0">
			<div style="clear: both;" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>
