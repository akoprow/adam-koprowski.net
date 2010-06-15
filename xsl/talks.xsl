<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="common.xsl" /> 
	<xsl:output method="html" indent="no" encoding="ISO-8859-1" />
	<xsl:variable name="talks" select="document('../data/talks.xml')" />

	<xsl:template match="talks">
		<xsl:apply-templates select="$talks" mode="talks" />	
	</xsl:template>

	<xsl:template match="group" mode="talks">
		<H2>
			<xsl:value-of select="@id" />
		</H2>
		<xsl:apply-templates mode="talks" />
	</xsl:template>
	
	<xsl:template match="talk" mode="talks">
		<DIV class="block">
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
		<xsl:call-template name="file-download">
			<xsl:with-param name="url">
				<xsl:text>pres/</xsl:text><xsl:value-of select="url" />
			</xsl:with-param>
			<xsl:with-param name="name">
				<xsl:value-of select="text" />
			</xsl:with-param>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>