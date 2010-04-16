<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<xsl:key name="paper-key" match="paper" use="@id"/>

<!-- 
	<xsl:variable name="paper" select="document('../data/papers.xml')/key('paper-key', $paper-id)" />
-->

	<xsl:template match="paper-title">
<!-- 
		<xsl:value-of select="$paper/title" />
-->
 	</xsl:template>

</xsl:stylesheet>
