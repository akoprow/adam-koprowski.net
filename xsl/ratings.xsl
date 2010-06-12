<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="show-rating">
		<xsl:param name="rating" />
		<xsl:variable name="tip">
			<xsl:choose>
				<xsl:when test="not(number($rating))" />
				<xsl:when test="$rating >= 4.5">
					<xsl:text>Loved it!</xsl:text>
				</xsl:when>
				<xsl:when test="$rating >= 4.0">
					<xsl:text>Liked it</xsl:text>
				</xsl:when>
				<xsl:when test="$rating >= 3.0">
					<xsl:text>It was OK</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text>Didn't like it</xsl:text>					
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
 		<span class="rating" title="{$tip}">
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
 		</span>	
	</xsl:template>

</xsl:stylesheet>