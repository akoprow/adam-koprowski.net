<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="papers-bibtex.xsl" /> 
	<xsl:output method="text" />

	<xsl:template match="paper">
		<xsl:call-template name="paper-bibtex">
			<xsl:with-param name="paper" select="." />
		</xsl:call-template>
<xsl:text>

</xsl:text>
	</xsl:template>

	<xsl:template match="*">
		<xsl:apply-templates />
	</xsl:template>
	
</xsl:stylesheet>