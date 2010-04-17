<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<xsl:template match="talks">
		<xsl:apply-templates select="document('../data/talks.xml')" mode="talks" />	
	</xsl:template>

	<xsl:template match="group" mode="talks">
		<H2>
			<xsl:value-of select="@id" />
		</H2>
		<xsl:apply-templates mode="talks" />
	</xsl:template>
	
	<xsl:template match="talk" mode="talks">
		<DIV class="paper">
  			<STRONG>
	  			<xsl:value-of select="title" />
  			</STRONG>
  			<xsl:apply-templates mode="talks" select="pres" />
  			Get:
  			<xsl:apply-templates mode="talks" select="download" />
		</DIV>
	</xsl:template>

	<xsl:template match="pres" mode="talks">
		<DIV class="talk">
			<xsl:value-of select="date" />,
			<xsl:choose>
				<xsl:when test="url">
					<A href="{url}">
						<xsl:value-of select="event" />
					</A>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="event" />				
				</xsl:otherwise>
			</xsl:choose>
			,
			<xsl:value-of select="location" />
		</DIV>
	</xsl:template>

	<xsl:template match="download" mode="talks">
		<A class="download" href="pres/{url}">
			<xsl:value-of select="text" />
		</A>
		<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
	</xsl:template>

</xsl:stylesheet>