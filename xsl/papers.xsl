<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="papers-common.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />
	<xsl:variable name="papers" select="document('../data/papers.xml')" />

	<xsl:template match="/" mode="list-papers">
		<xsl:for-each select="//paper">
			<xsl:value-of select="@id" />
			<xsl:text> </xsl:text>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="papers">
		<xsl:apply-templates select="$papers" mode="papers">
			<xsl:with-param name="paper_filter" select="@type" /> 
		</xsl:apply-templates>	
	</xsl:template>

	<xsl:template match="group" mode="papers">
		<xsl:param name="paper_filter" />
		<xsl:choose>
			<xsl:when test="$paper_filter = 'conferences'">
				<xsl:call-template name="show-group">
					<xsl:with-param name="papers" select="child::node()[conference]" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$paper_filter = 'journals'">
				<xsl:call-template name="show-group">
					<xsl:with-param name="papers" select="child::node()[journal]" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$paper_filter = 'other'">
				<xsl:call-template name="show-group">
					<!-- TODO Ugly, is there a way to include nodes that *do not* have (conference|journal) descendants? -->
					<xsl:with-param name="papers" select="child::node()[workshop-proceedings | techreport | phdthesis | masterthesis | unpublished]" />
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="$paper_filter = 'all'">
				<xsl:call-template name="show-group">
					<xsl:with-param name="papers" select="child::node()" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:message terminate="yes">
					<xsl:text>Unknown paper filter:</xsl:text>
					<xsl:value-of select="$paper_filter" />
				</xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="show-group">
		<xsl:param name="papers" />
		<xsl:if test="$papers">
			<H2>
				<xsl:value-of select="@id" />
			</H2>
			<xsl:apply-templates mode="present-paper" select="$papers">
				<xsl:with-param name="link-to-paper">yes</xsl:with-param>
				<xsl:with-param name="download">no</xsl:with-param>		
			</xsl:apply-templates>
		</xsl:if>
	</xsl:template>
		
</xsl:stylesheet>
