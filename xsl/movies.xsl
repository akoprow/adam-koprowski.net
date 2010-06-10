<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
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
					</td>
	    		</tr>
			</table>
	    </LI>
	</xsl:template>
	
</xsl:stylesheet>
