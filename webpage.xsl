<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />

	<!--*************************************************************************************************-->
	<!--******************************************* Variables *******************************************-->
	<!--*************************************************************************************************-->

	<xsl:variable name="page-who">Adam Koprowski</xsl:variable>
	<xsl:variable name="page-name">personal homepage</xsl:variable>
	<xsl:variable name="page-footer">(C) 2010 Adam Koprowski</xsl:variable>

	<xsl:variable name="menu-selection" select="/page/@menu" />
	<xsl:variable name="menu-subselection" select="/page/@submenu" />
	<xsl:variable name="page-title" select="/page/title" />

	<!--*************************************************************************************************-->
	<!--**************************************** Main page logic ****************************************-->
	<!--*************************************************************************************************-->

	<xsl:template match="page">
		<HTML>
			<xsl:call-template name="html-header" />
			<xsl:call-template name="html-main-box" />
		</HTML>
	</xsl:template>

	<!--*************************************************************************************************-->
	<!--**************************************** Top/bottom menu ****************************************-->
	<!--*************************************************************************************************-->

	<xsl:template name="show-menu-top">
		<xsl:apply-templates select="document('data/menu.xml')" mode="menu-top" />
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

	<!--*************************************************************************************************-->
	<!--***************************************** Presentations *****************************************-->
	<!--*************************************************************************************************-->

	<xsl:template match="talks">
		<xsl:apply-templates select="document('data/talks.xml')" mode="talks" />	
	</xsl:template>

	<xsl:template match="group" mode="talks">
		<H2>
			<xsl:value-of select="@id" />
		</H2>
		<xsl:apply-templates mode="talks" />
	</xsl:template>
	
	<xsl:template match="talk" mode="talks">
		<DIV class="paper">
  			<STRONG>
	  			<xsl:value-of select="title" />
  			</STRONG>
  			<xsl:apply-templates mode="talks" select="pres" />
  			Get:
  			<xsl:apply-templates mode="talks" select="download" />
		</DIV>
	</xsl:template>

	<xsl:template match="pres" mode="talks">
		<DIV class="talk">
			<xsl:value-of select="date" />,
			<xsl:choose>
				<xsl:when test="url">
					<A href="{url}">
						<xsl:value-of select="event" />
					</A>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="event" />				
				</xsl:otherwise>
			</xsl:choose>
			,
			<xsl:value-of select="location" />
		</DIV>
	</xsl:template>

	<xsl:template match="download" mode="talks">
		<A class="download" href="pres/{url}">
			<xsl:value-of select="text" />
		</A>
		<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
	</xsl:template>

	<!--*************************************************************************************************-->
	<!--***************************************** Publications ******************************************-->
	<!--*************************************************************************************************-->

	<xsl:template match="papers">
		<xsl:apply-templates select="document('data/papers.xml')" mode="papers" />	
	</xsl:template>

	<xsl:template match="group" mode="papers">
		<H2>
			<xsl:value-of select="@id" />
		</H2>
		<xsl:apply-templates mode="papers" />
	</xsl:template>
	
	<xsl:template match="paper" mode="papers">
		<P class="paper">
			<xsl:value-of select="authors" />
			<BR/>
			<SPAN CLASS="ppub">
				<A href="papers/{id}.html">
					<xsl:value-of select="title" />					
				</A>
			</SPAN>
			<BR/>
			<xsl:value-of select="prefix" />			
			<xsl:text disable-output-escaping="yes"><![CDATA[&nbsp;]]></xsl:text>
			<EM>
				<xsl:value-of select="long" />				
			</EM>					
			(<A href="{url}">
				<xsl:value-of select="short" />
			</A>)
			<xsl:value-of select="location" />.
			<B>
				<xsl:value-of select="note" />
			</B>
		</P>
	</xsl:template>

	<!--*************************************************************************************************-->
	<!--*************************************** General page layout *************************************-->
	<!--*************************************************************************************************-->

	<xsl:template name="html-header">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<title>
				<xsl:value-of select="$page-title" />
			</title>
			<meta name="DESCRIPTION" content="" />
			<meta name="KEYWORDS" content="" />
			<link href="css/styles.css"	rel="stylesheet" type="text/css" />
		</head>	
	</xsl:template>

	<xsl:template name="html-page-head">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td rowspan="2">	
					<a href="/">
						<img src="images/logo.gif" alt="" border="0" style="margin-right: 5px;" />
					</a>
				</td>
				<td class="company" valign="bottom">
					<xsl:value-of select="$page-who" />
				</td>
			</tr>
			<tr>
				<td class="slogan" valign="top">
					<xsl:value-of select="$page-name" />
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="html-content">
		<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" style="width: 100%; height: 100%;">
			<TR>
				<TD height="169" valign="bottom" style="padding: 0 370px 20px 60px;">
					<xsl:call-template name="html-page-head" />
				</TD>
			</TR>
			<TR>
				<TD height="45" style="padding: 7px 290px 0 70px;">
					<table cellpadding="0" cellspacing="0" align="center">
						<tr>
							<td width="30">
								<div style="width: 5px; height: 0px;"><span /></div>
							</td>
							<xsl:call-template name="show-menu-top" />
						</tr>
					</table>
				</TD>
			</TR>
			<TR>
				<TD height="100%" name="SB_stretch" valign="top">
					<table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 440px;">
						<tr valign="top">
							<td width="100%" class="pageContent" style="padding: 20px 20px 10px 90px;">
								<xsl:apply-templates select="content" />																				
							</td>
							<td style="padding: 120px 100px 10px 5px;">
								<table cellpadding="0" cellspacing="0" width="145" align="center" />
								<div style="width: 185px; height: 0px;"><span /></div>
							</td>
						</tr>
					</table>
				</TD>
			</TR>
			<TR>
				<TD height="130" valign="top" style="padding-top: 30px;">
					<table cellpadding="0" cellspacing="0" align="center">
						<tr>
							<td width="30">
								<div style="width: 5px; height: 0px;"><span/></div>
							</td>
							<xsl:call-template name="show-menu-bottom" />
						</tr>
					</table>
					<div style="width: 0px; height: 10px;"><span /></div>
					<div align="center" class="footer">
						<xsl:value-of select="$page-footer" />
					</div>
				</TD>
			</TR>
		</TABLE>
	</xsl:template>

	<xsl:template name="html-main-box">
		<BODY MARGINHEIGHT="0" MARGINWIDTH="0" TOPMARGIN="0" RIGHTMARGIN="0" BOTTOMMARGIN="0" LEFTMARGIN="0">
			<table cellpadding="0" cellspacing="0" border="0" class="main-bg" style="width: 100%; height: 100%; background-image: url('images/tbg.jpg'); background-repeat: repeat-x;">
				<tr>
					<td style="background-image: url('images/bbg.jpg'); background-position: bottom; background-repeat: repeat-x;">
						<table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 100%; background-image: url('images/lbg.jpg'); background-repeat: repeat-y;">
							<tr>
								<td style="background-image: url('images/rbg.jpg'); background-position: right; background-repeat: repeat-y;">
									<table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 100%; background-image: url('images/tbg_l.jpg'); background-repeat: no-repeat;">
										<tr>
											<td style="background-image: url('images/header.jpg'); background-position: top right; background-repeat: no-repeat;">
												<table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 100%; background-image: url('images/bbg_l.jpg'); background-position: bottom left; background-repeat: no-repeat;">
													<tr>
														<td style="background-image: url('images/bbg_r.jpg'); background-position: bottom right; background-repeat: no-repeat;">
															<xsl:call-template name="html-content" />
														</td>
													</tr>
												</table>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</BODY>
	</xsl:template>

	<xsl:template match="heading">
		<table cellpadding="0" cellspacing="0" border="0"> 
			<tr> 
				<td class="text-header">
					<xsl:value-of select="." />
				</td> 
				<td style="padding-left: 5px;">
					<img src="images/txtheader_bullet.gif" border="0" alt="" />
				</td> 
			</tr> 
		</table>
		<div style="width: 0px; height: 15px;"><span /></div> 
	</xsl:template> 

	<xsl:template match="html">
		<xsl:value-of select="." disable-output-escaping="yes" />
	</xsl:template>
	
</xsl:stylesheet>
