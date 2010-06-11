<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="ratings.xsl" />
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="movies" select="document('../data/movies.xml')" />

	<xsl:template match="imdb-link">
		<div>
			This page is generated from
			<A href="http://www.imdb.com/mymovies/list?l=2700180">
				my vote history at IMDB
			</A>.
		</div> 		
	</xsl:template>

	<xsl:template match="movies-by-year">
		<div id="{@id}">
  			<xsl:variable name="first" select="preceding-sibling::*[1]/@boundary" />
			<xsl:variable name="last" select="@boundary" />

			<xsl:if test="$last and not($movies//movie[title = $last])">
				<xsl:message terminate="yes">
					<xsl:text>Cannot find a boundary movie: </xsl:text>
					<xsl:value-of select="$last" />
				</xsl:message>
			</xsl:if>
			<OL class="movies">
				<xsl:for-each select="$movies//movie[
					not(preceding-sibling::movie/title = $last) and
					not(following-sibling::movie/title = $first) and
					not(title = $first)]">
					<xsl:call-template name="show-movie" />
				</xsl:for-each>
			</OL>
			<div style="clear: both;" />
		</div>
	</xsl:template>

	<xsl:template match="movies-by-rating">
		<div id="{@id}">
  			<xsl:variable name="min" select="number(@min)" />
			<xsl:variable name="max" select="number(@max)" />

			<OL class="movies">
				<xsl:for-each select="$movies//movie[(number(my-rating) ge $min) and (number(my-rating) le $max)]">
					<xsl:sort order="descending" data-type="number" select="my-rating" />
					<xsl:call-template name="show-movie" />
				</xsl:for-each>
			</OL>
			<div style="clear: both;" />
		</div>
	</xsl:template>
	
	<xsl:template name="show-movie">
	    <LI>
	    	<table class="moviesTable">
	    		<tr>
	    			<td class="no">
	                         <xsl:number value="position()" format="1. "/>
	    			</td>
	    			<td class="img">
						<img src="images/imdb-posters/{id}.jpg" height="100" />
	    			</td>
	    			<td class="data">
						<span class="title">
							<xsl:value-of select="title" />
						</span>
						<span class="rating">
							<xsl:variable name="rating">
								<xsl:choose>
									<xsl:when test="my-rating = 10">5.0</xsl:when>
									<xsl:when test="my-rating = 9">4.5</xsl:when>
									<xsl:when test="my-rating = 8">4.0</xsl:when>
									<xsl:when test="my-rating = 7">3.0</xsl:when>
									<xsl:when test="my-rating = 6">2.0</xsl:when>
									<xsl:otherwise>1.0</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:call-template name="show-rating">
								<xsl:with-param name="rating" select="$rating" />
							</xsl:call-template>							
						</span>
					</td>
	    		</tr>
			</table>
	    </LI>
	</xsl:template>
	
</xsl:stylesheet>
