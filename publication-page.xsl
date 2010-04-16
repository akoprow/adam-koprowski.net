<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<xsl:template match="page">
		<xsl:call-template name="html-page" />
	</xsl:template>	

</xsl:stylesheet>
