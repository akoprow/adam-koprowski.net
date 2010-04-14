<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="menu-selection" select="/page/id" />
	<xsl:variable name="menu-subselection" select="/page/subid" />

	<xsl:template match="page">
		<html>
			<body>
				<xsl:apply-templates select="document('menu.xml')" />
				<xsl:value-of select="content" disable-output-escaping="yes" />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="menu">
		<h2>Menu</h2>
		<ul>
			<xsl:apply-templates select="entry" />
		</ul>
	</xsl:template>

	<xsl:template match="entry">
		<li>
			<xsl:choose>
				<xsl:when test="./id = $menu-selection">
					<xsl:value-of select="text" />
					<ul>
						<xsl:apply-templates select="subentry" />
					</ul>
				</xsl:when>
				<xsl:otherwise>
					<A href="{id}.html">
						<xsl:value-of select="text" />
					</A>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>

	<xsl:template match="subentry">
		<li>
			<xsl:choose>
				<xsl:when test="./id = $menu-subselection">
					<xsl:value-of select="text" />
				</xsl:when>
				<xsl:otherwise>
					<A href="{id}.html">
						<xsl:value-of select="text" />
					</A>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>

</xsl:stylesheet>
