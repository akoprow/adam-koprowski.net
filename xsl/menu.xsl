<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="show-menu-top">
		<xsl:apply-templates select="document('../data/menu.xml')" mode="menu-top" />
	</xsl:template>

	<xsl:template match="entry" mode="menu-top">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@urlid = $menu-selection">
					amenu
				</xsl:when>
				<xsl:otherwise>
					menu
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<td align="center">
			<a href="{@urlid}.html" class="{$class}">	
				<img src="images/bullet.gif" border="0" alt="" style="margin-bottom: 3px;" />
				<br/>
				<xsl:value-of select="text" />
			</a>
		</td>
		<xsl:if test="not (position()=last())"> 
			<td width="10">
				<div style="width: 5px; height: 0px;"><span /></div>
			</td>
			<td>
				<img src="images/separator.gif" border="0" alt="" />
			</td>
			<td width="10">
				<div style="width: 5px; height: 0px;"><span /></div>
			</td>
		</xsl:if>
	</xsl:template>

	<xsl:template name="show-menu-bottom">
		<xsl:apply-templates select="document('data/menu.xml')" mode="menu-bottom" />
	</xsl:template>

	<xsl:template match="entry" mode="menu-bottom">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@urlid = $menu-selection">
					abmenu
				</xsl:when>
				<xsl:otherwise>
					bmenu
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<td>
			<a href="{@urlid}.html" class="abmenu" id="abmenu">
				<xsl:value-of select="text" />
			</a>
		</td>
		<xsl:if test="not (position()=last())"> 
			<td width="5" />
			<td>
				<img src="images/bmenu_separator.gif" alt="" style="margin: 0px 5px 0px 5px;" />
			</td>
			<td width="5" />
		</xsl:if>
	</xsl:template>
				
</xsl:stylesheet>