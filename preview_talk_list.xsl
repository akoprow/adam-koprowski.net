<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<html>
			<body>
				<h1>Talks:</h1>
				<xsl:apply-templates select="talks" />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="year">
		<h2>
			<xsl:value-of select="@id" />
		</h2>
		<table border="1" cellpadding="6">
			<tr>
				<th>Title</th>
				<th>Events</th>
				<th>Downloads</th>
			</tr>
			<xsl:apply-templates />			
		</table>
	</xsl:template>
	
	<xsl:template match="talk">
		<tr>
			<td>
				<xsl:value-of select="title" />				
			</td>
			<td>
				<ul>
					<xsl:apply-templates select="./pres" />
				</ul>
			</td>
			<td>
				<ul>
					<xsl:apply-templates select="./download" />			
				</ul>
			</td>
		</tr>	
	</xsl:template>
	
	<xsl:template match="pres">
		<li>
			<xsl:value-of select="date" /> 
			/ 
			<A href="{url}">
				<xsl:value-of select="event" /> 
			</A>
			/							
			<xsl:value-of select="location" />
		</li>
	</xsl:template>

	<xsl:template match="download">
		<li>
			<A href="{url}">
				<xsl:value-of select="text" /> 
			</A>
		</li>
	</xsl:template>
	
</xsl:stylesheet>
