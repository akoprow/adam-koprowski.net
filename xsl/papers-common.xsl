<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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
				<xsl:value-of select="authors" />
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
		<A href="papers/{../../@id}.pdf">PDF</A>
		<xsl:text>
		</xsl:text>
	</xsl:template>

	<xsl:template match="ps" mode="present-paper">
		<A href="papers/{../../@id}.ps">PS</A>
		<xsl:text>
		</xsl:text>
	</xsl:template>

	<xsl:template match="resource" mode="present-paper">
		<A href="{url}">
			<xsl:value-of select="name" />
		</A>		
		<xsl:text>
		</xsl:text>
	</xsl:template>
	
	<xsl:template match="*" mode="present-paper" />

</xsl:stylesheet>