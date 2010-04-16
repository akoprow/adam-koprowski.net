<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<!--*************************************************************************************************-->
	<!--******************************************* Variables *******************************************-->
	<!--*************************************************************************************************-->

	<xsl:variable name="menu-selection" select="/page/@menu" />
	<xsl:variable name="menu-subselection" select="/page/@submenu" />
	<xsl:variable name="page-title" select="/page/title" />

	<!--*************************************************************************************************-->
	<!--**************************************** Main page logic ****************************************-->
	<!--*************************************************************************************************-->

	<xsl:template match="page">
		<xsl:call-template name="html-page" />
	</xsl:template>

	<!--*************************************************************************************************-->
	<!--***************************************** Presentations *****************************************-->
	<!--*************************************************************************************************-->

	<xsl:template match="talks">
		<xsl:apply-templates select="document('data/talks.xml')" mode="talks" />	
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

	<!--*************************************************************************************************-->
	<!--*************************************** Publications list ***************************************-->
	<!--*************************************************************************************************-->

	<xsl:template match="papers">
		<xsl:apply-templates select="document('data/papers.xml')" mode="papers">
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
				<A href="paper-{id}.html">
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
