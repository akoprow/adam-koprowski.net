<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" indent="yes" encoding="ISO-8859-1"/> 
  <xsl:strip-space elements="*"/>

  <xsl:template match="page">
    <html>
      <body>
	<h2>Menu</h2>
	<ul>
	  <xsl:apply-templates select="document('menu.xml')" />
	</ul>
	<xsl:value-of select="content" disable-output-escaping="yes" />	
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="entry">
    <li>
      <xsl:variable name="id">
	<xsl:value-of select="id"/>
      </xsl:variable>
      <A href="{$id}.html">
	<xsl:value-of select="text" />
      </A>
      <ul>
	<xsl:apply-templates select="subentry" />
      </ul>
    </li>
  </xsl:template>

  <xsl:template match="subentry">
    <li>
      <xsl:variable name="id">
	<xsl:value-of select="id"/>
      </xsl:variable>
      <A href="{$id}.html">
	<xsl:value-of select="text" />
      </A>
    </li>
  </xsl:template>

</xsl:stylesheet>
