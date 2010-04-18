<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="papers-common.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:param name="paper-id" />
	<xsl:variable name="paper" select="id($paper-id, document('../data/papers.xml'))" />

	<xsl:template match="paper-title">
		<xsl:value-of select="$paper/title" />
	</xsl:template>

	<xsl:template match="paper-abstract">
		<xsl:apply-templates select="$paper/abstract" />
	</xsl:template>

	<xsl:template match="paper-block">
		<xsl:apply-templates mode="present-paper" select="$paper">
			<xsl:with-param name="link-to-paper">no</xsl:with-param>
			<xsl:with-param name="download">yes</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="bibtex">
		<xsl:variable name="bibtex-type">
			<xsl:choose>
				<xsl:when test="$paper/conference">@inproceedings</xsl:when>		
				<xsl:when test="$paper/journal">@article</xsl:when>		
				<xsl:when test="$paper/techreport">@techreport</xsl:when>		
				<xsl:when test="$paper/phdthesis">@phdthesis</xsl:when>		
				<xsl:otherwise>
					<xsl:message>
						Unknown paper type for paper with id: <xsl:value-of select="$paper-id" />			
					</xsl:message>			
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$bibtex-type" />
		<xsl:text>{</xsl:text>
		<xsl:value-of select="$paper-id" />
		<xsl:text>,&#10;</xsl:text>
		
		<xsl:call-template name="bibtex-line" >
			<xsl:with-param name="field">author</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="replace(replace($paper/authors, ',', ' and '), '  ', ' ')" /></xsl:with-param>					
		</xsl:call-template>
		<xsl:call-template name="bibtex-line" >
			<xsl:with-param name="field">title</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$paper/title" /></xsl:with-param>					
		</xsl:call-template>

		<xsl:text>}</xsl:text>
	</xsl:template>

	<xsl:template name="bibtex-line">
		<xsl:param name="field" />
		<xsl:param name="value" />
		<xsl:variable name="spaces">          </xsl:variable>
		
		<xsl:text>  </xsl:text>
		<xsl:value-of select="$field" />
		<!-- TODO: white-spaces below are discarded... -->
		<xsl:value-of select="substring($spaces, string-length($spaces)-string-length($field))" />
		<xsl:text> = {</xsl:text>
		<xsl:value-of select="$value" />
		<xsl:text>},&#10;</xsl:text>
	</xsl:template>
		
</xsl:stylesheet>
