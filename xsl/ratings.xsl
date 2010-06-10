<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="show-rating">
		<xsl:param name="rating" />
		<xsl:if test="number($rating)">
			<xsl:if test="$rating >= 1.0">
				<span class="full-star" />
			</xsl:if>
			<xsl:if test="$rating >= 2.0">
				<span class="full-star" />
			</xsl:if>
			<xsl:if test="$rating >= 3.0">
				<span class="full-star" />
			</xsl:if>
			<xsl:if test="$rating >= 4.0">
				<span class="full-star" />
			</xsl:if>
			<xsl:if test="$rating >= 5.0">
				<span class="full-star" />
			</xsl:if>
			<xsl:if test="$rating - floor($rating) >= 0.5">
				<span class="half-star" />
			</xsl:if>
			<xsl:if test="$rating &lt; 4.5">
				<span class="empty-star" />
			</xsl:if>
			<xsl:if test="$rating &lt; 3.5">
				<span class="empty-star" />
			</xsl:if>
			<xsl:if test="$rating &lt; 2.5">
				<span class="empty-star" />
			</xsl:if>
			<xsl:if test="$rating &lt; 1.5">
				<span class="empty-star" />
			</xsl:if>
			<xsl:if test="$rating &lt; 0.5">
				<span class="empty-star" />
			</xsl:if>
		</xsl:if>	
	</xsl:template>

</xsl:stylesheet>