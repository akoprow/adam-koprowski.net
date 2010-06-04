<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="books">
		<xsl:variable name="selected-tag" select="@tag" />
		<OL class="books">
			<xsl:for-each select="document('../data/books.xml')//book[contains(tags, $selected-tag)]">
				<xsl:sort order="descending" data-type="number" select="finished" />
				<xsl:call-template name="show-book" />
			</xsl:for-each>
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
							<xsl:value-of select="lower-case(author)" />
						</span>
						<span class="title">
		    				<a href="http://www.librarything.com/work/book/{id}">
								<xsl:value-of select="title" />
							</a>
						</span>
						<span class="rating">
							<xsl:if test="number(rating)">
								<xsl:if test="rating >= 1.0">
									<span class="full-star" />
								</xsl:if>
								<xsl:if test="rating >= 2.0">
									<span class="full-star" />
								</xsl:if>
								<xsl:if test="rating >= 3.0">
									<span class="full-star" />
								</xsl:if>
								<xsl:if test="rating >= 4.0">
									<span class="full-star" />
								</xsl:if>
								<xsl:if test="rating >= 5.0">
									<span class="full-star" />
								</xsl:if>
								<xsl:if test="rating - floor(rating) >= 0.5">
									<span class="half-star" />
								</xsl:if>
								<xsl:if test="rating &lt; 4.5">
									<span class="empty-star" />
								</xsl:if>
								<xsl:if test="rating &lt; 3.5">
									<span class="empty-star" />
								</xsl:if>
								<xsl:if test="rating &lt; 2.5">
									<span class="empty-star" />
								</xsl:if>
								<xsl:if test="rating &lt; 1.5">
									<span class="empty-star" />
								</xsl:if>
								<xsl:if test="rating &lt; 0.5">
									<span class="empty-star" />
								</xsl:if>
							</xsl:if>
						</span>
					</td>
	    		</tr>
			</table>
	    </LI>
	</xsl:template>
</xsl:stylesheet>
