<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:ext="ext.xsl">

	<xsl:import href="common.xsl" /> 

	<xsl:template match="paper" mode="present-paper">
		<xsl:param name="link-to-paper" />
		<xsl:param name="download" />
		
		<xsl:variable name="type_class">
			<xsl:if test="not(type = paper_filter)">
				<xsl:choose>
					<xsl:when test="conference">conference</xsl:when>
					<xsl:when test="journal">journal</xsl:when>
					<xsl:otherwise>other</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:variable>	
				
		<DIV class="block paper">
			<div>
				<xsl:call-template name="present-authors" />
			</div>
  			<div class="title {$type_class}">
  				<xsl:choose>
  					<xsl:when test="$link-to-paper = 'yes'">
						<A href="paper-{@id}.html">
							<xsl:value-of select="title" />					
						</A>  					
  					</xsl:when>
  					<xsl:otherwise>
						<xsl:value-of select="title" />					
  					</xsl:otherwise>
  				</xsl:choose>
			</div>
			<div>
				<xsl:apply-templates mode="present-paper" />
			</div>
			<xsl:if test="$download = 'yes'">
				<div class="download">
					Download:
					<xsl:apply-templates select="download/*" mode="present-paper" />				
				</div>
			</xsl:if>
		</DIV>
	</xsl:template>

	<xsl:template name="present-authors">
		<xsl:for-each select="node()/author">
			<xsl:value-of select="node()" />
			<xsl:choose>
				<xsl:when test="position() = last()">
				</xsl:when>
				<xsl:when test="position() + 1 = last()">
					<xsl:text> and </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>, </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:template>
	
	<xsl:template match="conference | workshop-proceedings" mode="present-paper">
		In
		<EM>
			<xsl:choose>
				<xsl:when test="abbreviation">
					<xsl:value-of select="name" />
				</xsl:when>
				<xsl:when test="url">
					<A href="{url}">
						<xsl:value-of select="name" />
					</A>,				
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="name" />,
				</xsl:otherwise>
			</xsl:choose>				
		</EM>
		<xsl:if test="abbreviation">
			(<A href="{url}">
				<xsl:value-of select="abbreviation" />
			</A>),
		</xsl:if>
		<xsl:value-of select="location" />.
		<B>
			<xsl:value-of select="note" />
		</B>
	</xsl:template>

	<xsl:template match="journal" mode="present-paper">
		In
		<EM>
			<xsl:value-of select="name" />				
		</EM>,
		<xsl:value-of select="volume" />(<xsl:value-of select="number" />),
		pp. <xsl:value-of select="pages" />,
		<xsl:value-of select="../../@id" />
	</xsl:template>

	<xsl:template match="unpublished" mode="present-paper">
		<xsl:value-of select="note" />
	</xsl:template>
	
	<xsl:template match="techreport" mode="present-paper">
		<EM>
			<xsl:value-of select="type" />
			<xsl:text> </xsl:text>				
			<xsl:value-of select="number" />				
		</EM>
		<xsl:if test="institution">, <xsl:value-of select="institution" /></xsl:if>
		<xsl:if test="address">, <xsl:value-of select="address" /></xsl:if>
		<xsl:if test="month">, <xsl:value-of select="month" /></xsl:if>
		<xsl:text> </xsl:text><xsl:value-of select="../../@id" />
	</xsl:template>

	<xsl:template match="phdthesis" mode="present-paper">
		<EM>PhD Thesis,</EM>
		<xsl:value-of select="school" />,
		<xsl:value-of select="address" />,
		<xsl:value-of select="month" /><xsl:text> </xsl:text><xsl:value-of select="../../@id" />
	</xsl:template>

	<xsl:template match="masterthesis" mode="present-paper">
		<EM>Master Thesis,</EM>
		<xsl:value-of select="school" />,
		<xsl:value-of select="address" />,
		<xsl:value-of select="month" /><xsl:text> </xsl:text><xsl:value-of select="../../@id" />
	</xsl:template>
	
	<xsl:template match="pdf" mode="present-paper">
		<xsl:call-template name="file-download">
			<xsl:with-param name="url">
			    <xsl:text>papers/</xsl:text>
			    <xsl:value-of select="../../@id" />
			    <xsl:text>.pdf</xsl:text>
			</xsl:with-param>
			<xsl:with-param name="name">PDF</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>

	<xsl:template match="ps" mode="present-paper">
		<xsl:call-template name="file-download">
			<xsl:with-param name="url">
			    <xsl:text>papers/</xsl:text>
			    <xsl:value-of select="../../@id" />
			    <xsl:text>.ps</xsl:text>
			</xsl:with-param>
			<xsl:with-param name="name">PS</xsl:with-param>
		</xsl:call-template>		
	</xsl:template>

	<xsl:template match="resource" mode="present-paper">
		<xsl:call-template name="file-download">
			<xsl:with-param name="url" select="url" />
			<xsl:with-param name="name" select="name" />
		</xsl:call-template>
	</xsl:template>
		
	<xsl:template match="*" mode="present-paper" />

</xsl:stylesheet>