<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<xsl:template match="papers">
		<xsl:apply-templates select="document('../data/papers.xml')" mode="papers">
			<xsl:with-param name="paper_filter" select="@type" /> 
		</xsl:apply-templates>	
	</xsl:template>

	<xsl:template match="group" mode="papers">
		<H2>
			<xsl:value-of select="@id" />
		</H2>
		<xsl:apply-templates mode="papers" />
	</xsl:template>
	
	<xsl:template match="paper" mode="papers">
		<xsl:variable name="type_class">
			<xsl:if test="not(type = paper_filter)">
				<xsl:value-of select="type" />
			</xsl:if>
		</xsl:variable>
		
		<DIV class="paper">
			<div>
				<xsl:value-of select="authors" />
			</div>
  			<div class="title {$type_class}">
				<A href="paper-{@id}.html">
					<xsl:value-of select="title" />					
				</A>
			</div>
			<div>
				<xsl:value-of select="prefix" />			
				<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
				<EM>
					<xsl:value-of select="long" />				
				</EM>					
				(<A href="{url}">
					<xsl:value-of select="short" />
				</A>)
				<xsl:value-of select="location" />.
				<B>
					<xsl:value-of select="note" />
				</B>
			</div>
		</DIV>
	</xsl:template>

</xsl:stylesheet>
