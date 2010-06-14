<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="ratings.xsl" />
	 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="books" select="document('../data/books.xml')" />
	<xsl:variable name="authors" select="$books//book[not(author = preceding-sibling::book/author) and not(contains(tags, 'reading'))]" />

	<xsl:template match="lt-link">
		<div>
			This page is generated from
			<A href="http://www.librarything.com/catalog.php?shelf_rows=10&amp;previousOffset=0&amp;shelf_rows=25&amp;previousOffset=0&amp;view=adam.koprowski&amp;shelf=shelf&amp;sort=stamp">
				my LibraryThing collection
			</A>
		</div>
	</xsl:template>

	<xsl:template match="books-by-tag">
		<UL class="books">
			<xsl:variable name="selected-tag" select="@tag" />
			<xsl:for-each select="$books//book[contains(tags, $selected-tag)]">
				<xsl:sort order="descending" data-type="number" select="finished" />
				<xsl:call-template name="show-book" />
			</xsl:for-each>
		</UL>
		<div style="clear: both;" />
	</xsl:template>

	<xsl:template match="books-by-rating">
		<UL class="books">
			<xsl:variable name="min" select="number(@min)" />
			<xsl:variable name="max" select="number(@max)" />
			<xsl:for-each select="$books//book[(number(rating) ge $min) and (number(rating) le $max)]">
				<xsl:sort order="descending" data-type="number" select="rating" />
				<xsl:sort order="descending" data-type="number" select="finished" />
				<xsl:call-template name="show-book" />
			</xsl:for-each>
		</UL>
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
						<span>
							<xsl:call-template name="show-rating">
								<xsl:with-param name="rating" select="rating" />
							</xsl:call-template>
						</span>
					</td>
	    		</tr>
			</table>
	    </LI>
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
	
	<xsl:template match="read-books-count">
		<xsl:value-of select="count($books//book)" />	
	</xsl:template>

	<xsl:template match="authors-count">
		<xsl:value-of select="count($authors)" />	
	</xsl:template>	
	
	<xsl:template match="book-authors-cloud">
		<div class="authors-cloud">
			<xsl:for-each select="$authors">
				<xsl:sort data-type="text" select="author" />
				<xsl:variable name="this-author" select="author" /> 
				<xsl:variable name="author-id" select="concat('author-tip-', 
					translate($this-author, ' .', '__'))" /> 
				<span class="author" style="font-size: {9 + 3*count(root()//book[author=$this-author])}px;" 
					href="#{$author-id}" rel="#{$author-id}">
					<xsl:value-of select="replace($this-author, ' ', '&#160;')" />
				</span>
				<xsl:text> </xsl:text>
				<span class="author-tip" id="{$author-id}">
					<ul>
						<xsl:for-each select="$books//book[author = $this-author]">
							<xsl:sort order="descending" data-type="number" select="finished" />
							<xsl:call-template name="show-authors-book" />
						</xsl:for-each>
					</ul>
					<div style="clear: both;" />
				</span>
			</xsl:for-each>
		</div>						
 	</xsl:template>
</xsl:stylesheet>
