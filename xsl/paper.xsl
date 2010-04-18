<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="papers-common.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

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
		
</xsl:stylesheet>
