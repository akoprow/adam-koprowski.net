<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<html>
			<body>
				<h2>Menu</h2>
				<ul>
					<xsl:apply-templates select="menu" />
				</ul>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="entry">
		<li>
			<xsl:variable name="url">
				<xsl:value-of select="url" />
			</xsl:variable>
			<A href="{$url}">
				<xsl:value-of select="text" />
			</A>
			<ul>
				<xsl:apply-templates select="subentry" />
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="subentry">
		<li>
			<xsl:variable name="url">
				<xsl:value-of select="url" />
			</xsl:variable>
			<A href="{$url}">
				<xsl:value-of select="text" />
			</A>
		</li>
	</xsl:template>

</xsl:stylesheet>
