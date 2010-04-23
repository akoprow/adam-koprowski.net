<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="file-download">
		<xsl:param name="url" />
		<xsl:param name="name" />
		<A href="{$url}">
			<xsl:value-of select="$name" />
		</A>
		<xsl:text>
		</xsl:text>
		<xsl:call-template name="file-exists">
			<xsl:with-param name="filename"><xsl:value-of select="$url" /></xsl:with-param>		
		</xsl:call-template>				
	</xsl:template>		
	
	<xsl:template name="file-exists" xmlns:file="java:java.io.File">
		<xsl:param name="filename" />
		<xsl:if test="not(starts-with($filename, 'http://'))"> <!-- we don't check if it's a http://... URI -->
			<xsl:variable name="file" select="file:new(concat('output/', string($filename)))" />
			<xsl:if test="not(file:exists($file))">
				<xsl:message terminate="yes">
					Missing file: output/<xsl:value-of select="$filename" />		
				</xsl:message>
			</xsl:if>	
		</xsl:if>
	</xsl:template>
	
</xsl:stylesheet>