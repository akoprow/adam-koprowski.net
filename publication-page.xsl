<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<xsl:variable name="menu-selection" select="/page/@menu" />
	<xsl:variable name="menu-subselection" select="/page/@submenu" />
	<xsl:variable name="page-title" select="/page/title" />

	<xsl:template match="page">
 		<xsl:call-template name="html-page" />
	</xsl:template>
	
</xsl:stylesheet>
