<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:param name="paper-id" />

	<xsl:variable name="menu" select="document('../data/menu.xml')" />

	<xsl:template name="show-menu-top">
		<xsl:apply-templates select="$menu" mode="menu-top" />
	</xsl:template>

	<xsl:template name="show-submenu-side">
		<xsl:apply-templates select="id($menu-selection, $menu)//(subentry | subentry-separator)" mode="submenu-side" />
	</xsl:template>

	<xsl:template match="entry" mode="menu-top">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@fileid = $menu-selection">
					amenu
				</xsl:when>
				<xsl:otherwise>
					menu
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<td align="center">
			<a href="{@fileid}.html" class="{$class}">	
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
		<xsl:apply-templates select="$menu" mode="menu-bottom" />
	</xsl:template>

	<xsl:template match="entry" mode="menu-bottom">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@fileid = $menu-selection">
					abmenu
				</xsl:when>
				<xsl:otherwise>
					bmenu
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<td>
			<a href="{@fileid}.html" class="abmenu" id="abmenu">
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

	<xsl:template match="subentry" mode="submenu-side">
		<xsl:variable name="class">
			<xsl:choose>
				<xsl:when test="@fileid = $menu-subselection">
					asubmenu
				</xsl:when>
				<xsl:otherwise>
					submenu
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<tr>
			<td style="padding-right: 10px;">
				<a href="publications.html">
					<img src="images/submenu_bullet.gif" border="0" alt="" />
				</a>
			</td>
			<td style="width: 100%;">
				<a href="{@fileid}.html" class="{$class}">
					<xsl:value-of select="text" />
				</a>
			</td>
		</tr>
		<tr height="10" />
	</xsl:template>
	
	<xsl:template match="subentry-separator" mode="submenu-side">
		<tr>
			<td/>
			<td height="20">
				<div style="height: 2px; background-color: #5E626D; background-image: url('images/submenu_separator.gif'); background-repeat: repeat-x;">
					<span/>
				</div>
			</td>
		</tr>		
	</xsl:template>

</xsl:stylesheet>