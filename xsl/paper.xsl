<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="papers-common.xsl" /> 
	<xsl:import href="papers-bibtex.xsl" /> 
	<xsl:output method="html" indent="no" />
	<xsl:strip-space elements="*" />

	<xsl:param name="paper-id" />
	<xsl:variable name="papers" select="document('../data/papers.xml')" />
	<xsl:variable name="paper" select="id($paper-id, $papers)" />

	<xsl:template match="paper-title">
		<xsl:call-template name="paper-title">
			<xsl:with-param name="title" select="$paper/title" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="paper-page">
		<xsl:if test="$paper/img">
			<div class="paper-img">
				<IMG src="papers/{$paper/img}" STYLE="float:right; " />
				<xsl:call-template name="file-exists">
					<xsl:with-param name="filename"><xsl:text>papers/</xsl:text><xsl:value-of select="$paper/img" /></xsl:with-param>		
				</xsl:call-template>				
			</div>
		</xsl:if>	
		<div class="block">
			<EM>Abstract:</EM>
			<xsl:apply-templates select="$paper/abstract" />
		</div>
		<xsl:call-template name="paper-block" />
		<xsl:if test="not($paper/unpublished)">
			<h2>BibTeX:</h2>
			<div class="block">
				<pre class="bibtex">
					<xsl:call-template name="paper-bibtex">
						<xsl:with-param name="paper" select="$paper" />
					</xsl:call-template>
				</pre>
			</div>
		</xsl:if>
	</xsl:template>

	<xsl:template name="paper-block">
		<xsl:apply-templates mode="present-paper" select="$paper">
			<xsl:with-param name="link-to-paper">no</xsl:with-param>
			<xsl:with-param name="download">yes</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>	 

</xsl:stylesheet>
