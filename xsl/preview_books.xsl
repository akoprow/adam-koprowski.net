<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<html>
			<body>
				<h1>Books:</h1>
				<table border="1" cellpadding="5">
					<tr>
						<th>Cover</th>
						<th>Title</th>
						<th>Author</th>
						<th>Rating</th>
						<th>Finished</th>
						<th>Tags</th>
					</tr>
					<xsl:apply-templates select="books" />
				</table>
			</body>
		</html>
	</xsl:template>

	<xsl:template match="book">
		<tr>
			<td>
				<img src="{cover-url}" />				
			</td>
			<td>
				<xsl:value-of select="title" />				
			</td>
			<td>
				<xsl:value-of select="author" />
			</td>
			<td>
				<xsl:value-of select="rating" />			
			</td>
			<td>
				<xsl:value-of select="finished" />			
			</td>
			<td>
				<xsl:value-of select="tags" />			
			</td>
		</tr>	
	</xsl:template>

</xsl:stylesheet>
