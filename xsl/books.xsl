<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
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
	
	<xsl:template match="book-authors-cloud"> 
		<xsl:for-each select="document('../data/books.xml')//book[not(author = preceding-sibling::book/author)]">
			<xsl:sort data-type="text" select="author" />
			<LI>
				<xsl:value-of select="author" />
			</LI>
<!-- 
			<xsl:sort order="ascending" data-type="text" select="author" />
				<LI>
					<xsl:value-of select="author" />
					<xsl:for-each select="preceding-sibling::book">
						<xsl:value-of select="author" />
					</xsl:for-each>
				</LI>
			<xsl:if test="not(author = preceding-sibling::author)">
			</xsl:if>
-->
		</xsl:for-each>						
	</xsl:template>
</xsl:stylesheet>
