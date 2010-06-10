<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="ratings.xsl" />
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="movies">
		<OL class="movies">
			<xsl:for-each select="document('../data/movies.xml')//movie">
				<xsl:call-template name="show-movie" />
			</xsl:for-each>
		</OL>
		<div style="clear: both;" />
	</xsl:template>
	
	<xsl:template name="show-movie">
	    <LI>
	    	<table class="moviesTable">
	    		<tr>
	    			<td class="no">
	                         <xsl:number value="position()" format="1. "/>
	    			</td>
	    			<td class="img">
						<img src="{poster-url}" height="100" />
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
