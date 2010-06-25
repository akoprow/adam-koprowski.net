<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" />

	<xsl:template match="/" mode="list-file-ids">
		<xsl:for-each select="//entry | //subentry | //subsubentry">
			<xsl:value-of select="@fileid" />
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:template>

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
			<A href="{@fileid}.html">
				<xsl:value-of select="text" />
			</A>
			<ul>
				<xsl:apply-templates select="subentry" />
			</ul>
		</li>
	</xsl:template>

	<xsl:template match="subentry">
		<li>
			<A href="{@fileid}.html">
				<xsl:value-of select="text" />
			</A>
		</li>
	</xsl:template>

</xsl:stylesheet>
