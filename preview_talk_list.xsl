<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<html>
			<body>
				<h1>Talks:</h1>
				<table border="1" cellpadding="5">
					<tr>
						<th>Title</th>
						<th>Events</th>
						<th>Downloads</th>
					</tr>
					<xsl:apply-templates select="talks" />
				</table>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="group">
		<tr>
			<th colspan="3">
				<xsl:value-of select="@id" />
			</th>
		</tr>
		<xsl:apply-templates />			
	</xsl:template>
	
	<xsl:template match="talk">
		<tr>
			<td>
				<xsl:value-of select="title" />				
			</td>
			<td>
				<xsl:apply-templates select="./pres" />
			</td>
			<td>
				<xsl:apply-templates select="./download" />			
			</td>
		</tr>	
	</xsl:template>
	
	<xsl:template match="pres">
		<div>
			<xsl:value-of select="date" /> 
			/ 
			<xsl:choose>
				<xsl:when test="./url">
					<A href="{url}">
						<xsl:value-of select="event" /> 
					</A>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="event" /> 				
				</xsl:otherwise>
			</xsl:choose>
			/							
			<xsl:value-of select="location" />
		</div>
	</xsl:template>

	<xsl:template match="download">
		<div>
			<A href="../output/pres/{url}">
				<xsl:value-of select="text" /> 
			</A>
		</div>
	</xsl:template>
	
</xsl:stylesheet>
