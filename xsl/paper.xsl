<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<xsl:template match="/">
		<xsl:apply-templates select="id($paper-id)" />
	</xsl:template>

	<xsl:template match="paper">
		<xsl:call-template name="page">
			<xsl:with-param name="content">
				<xsl:value-of select="title" />
			</xsl:with-param>		
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
