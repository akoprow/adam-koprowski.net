<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="papers-common.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/" mode="list-papers">
		<xsl:for-each select="//paper">
			<xsl:value-of select="@id" />
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="papers">
		<xsl:apply-templates select="document('../data/papers.xml')" mode="papers">
			<xsl:with-param name="paper_filter" select="@type" /> 
		</xsl:apply-templates>	
	</xsl:template>

	<xsl:template match="group" mode="papers">
		<H2>
			<xsl:value-of select="@id" />
		</H2>
		<xsl:apply-templates mode="present-paper">
			<xsl:with-param name="link-to-paper">yes</xsl:with-param>
			<xsl:with-param name="download">no</xsl:with-param>		
		</xsl:apply-templates>
	</xsl:template>
	
</xsl:stylesheet>
