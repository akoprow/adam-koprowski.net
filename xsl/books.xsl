<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="ratings.xsl" />
	 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="books">
		<OL class="books">
		<xsl:choose>
			<xsl:when test="@tag">
				<xsl:variable name="selected-tag" select="@tag" />
				<xsl:for-each select="document('../data/books.xml')//book[contains(tags, $selected-tag)]">
					<xsl:sort order="descending" data-type="number" select="finished" />
					<xsl:call-template name="show-book" />
				</xsl:for-each>
			</xsl:when>
			<xsl:when test="@rating-min and @rating-max">
				<xsl:variable name="min" select="@rating-min" />
				<xsl:variable name="max" select="@rating-max" />
				<xsl:for-each select="document('../data/books.xml')//book[(rating ge $min) and (rating le $max)]">
					<xsl:sort order="descending" data-type="number" select="rating" />
					<xsl:sort order="descending" data-type="number" select="finished" />
					<xsl:call-template name="show-book" />
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">
					Unknown books tag
				</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
		</OL>
		<div style="clear: both;" />
	</xsl:template>
	
	<xsl:template name="show-book">
	    <LI>
	    	<table class="booksTable">
	    		<tr>
	    			<td class="no">
                         <xsl:number value="position()" format="1. "/>
	    			</td>
	    			<td class="img">
	    				<a href="http://www.librarything.com/work/book/{id}">
							<img src="{cover-url}" height="100" />
						</a>
	    			</td>
	    			<td class="data">
						<span class="author">
							<xsl:value-of select="author" />
						</span>
						<span class="title">
		    				<a href="http://www.librarything.com/work/book/{id}">
								<xsl:value-of select="title" />
							</a>
						</span>
						<span class="rating">
							<xsl:call-template name="show-rating">
								<xsl:with-param name="rating" select="rating" />
							</xsl:call-template>
						</span>
					</td>
	    		</tr>
			</table>
	    </LI>
	</xsl:template>
	
	<xsl:template match="book-authors-cloud">
		<div class="authors-cloud">
			<xsl:for-each select="document('../data/books.xml')//book[not(author = preceding-sibling::book/author)]">
				<xsl:sort data-type="text" select="author" />
				<xsl:variable name="this-author" select="author" /> 
				<SPAN style="font-size: {9 + 3*count(root()//book[author=$this-author])}px;">
					<xsl:text> </xsl:text>
					<xsl:value-of select="replace($this-author, ' ', '&#160;')" />
				</SPAN>
			</xsl:for-each>
		</div>						
	</xsl:template>
</xsl:stylesheet>
