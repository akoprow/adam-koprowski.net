<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:variable name="menu-selection" select="/page/@menu" />
	<xsl:variable name="menu-subselection" select="/page/@submenu" />

	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:template match="/">
		<HTML>
			<xsl:call-template name="header" />
			<xsl:call-template name="mainBox">

			</xsl:call-template>
		</HTML>
	</xsl:template>

<!--
	<xsl:template match="page">
		<html>
			<body>
				<xsl:apply-templates select="document('menu.xml')" />
				<xsl:value-of select="content" disable-output-escaping="yes" />
			</body>
		</html>
	</xsl:template>

	<xsl:template match="menu">
		<h2>Menu</h2>
		<ul>
			<xsl:apply-templates select="entry" />
		</ul>
	</xsl:template>

	<xsl:template match="entry">
		<li>
			<xsl:choose>
				<xsl:when test="@urlid = $menu-selection">
					<xsl:value-of select="text" />
					<ul>
						<xsl:apply-templates select="subentry" />
					</ul>
				</xsl:when>
				<xsl:otherwise>
					<A href="{@urlid}.html">
						<xsl:value-of select="text" />
					</A>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>

	<xsl:template match="subentry">
		<li>
			<xsl:choose>
				<xsl:when test="@urlid = $menu-subselection">
					<xsl:value-of select="text" />
				</xsl:when>
				<xsl:otherwise>
					<A href="{@urlid}.html">
						<xsl:value-of select="text" />
					</A>
				</xsl:otherwise>
			</xsl:choose>
		</li>
	</xsl:template>
-->

	<xsl:template name="header">
		<head>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
			<title>Adam Koprowski - Home</title> <!-- TODO -->
			<meta name="DESCRIPTION" content="" />
			<meta name="KEYWORDS" content="" />
			<link href="css/styles.css"	rel="stylesheet" type="text/css" />
		</head>	
	</xsl:template>

	<xsl:template name="page-head">
		<table cellpadding="0" cellspacing="0">
			<tr>
				<td rowspan="2">	
					<a href="/">
						<img src="images/logo.gif" alt="" border="0" style="margin-right: 5px;" />
					</a>
				</td>
				<td class="company" valign="bottom">
					Adam Koprowski
				</td>
			</tr>
			<tr>
				<td class="slogan" valign="top">
					personal homepage
				</td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template name="mainBox">
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
															<TABLE CELLPADDING="0" CELLSPACING="0" BORDER="0" style="width: 100%; height: 100%;">
																<TR>
																	<TD height="169" valign="bottom" style="padding: 0 370px 20px 60px;">
																		<xsl:call-template name="page-head" />
																	</TD>
																</TR>
																<TR>
																	<TD height="45" style="padding: 7px 290px 0 70px;">
																		<table cellpadding="0" cellspacing="0" align="center">
																			<tr>
																				<td width="30">
																					<div style="width: 5px; height: 0px;"><span></span></div>
																				</td>
																				
																				<td align="center">
																					<a href="index.html" class="amenu">
																						<img src="images/bullet.gif" border="0" alt="" style="margin-bottom: 3px;" />
																						<br/>
																						Home
																					</a>
																				</td>
																				<td width="10">
																					<div style="width: 5px; height: 0px;"><span></span></div>
																				</td>
																				<td>
																					<img src="images/separator.gif" border="0" alt=""/>
																				</td>
																				<td width="10">
																					<div style="width: 5px; height: 0px;"><span></span></div>
																				</td>
																			</tr>
																		</table>
																	</TD>
																</TR>
																<TR>
																	<TD height="100%" name="SB_stretch" valign="top">
																		<table cellpadding="0" cellspacing="0" border="0" style="width: 100%; height: 440px;">
																			<tr valign="top">
																				<td width="100%" class="pageContent" style="padding: 20px 20px 10px 90px;">
																					CONTENT
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
																					<div style="width: 5px; height: 0px;"><span></span></div>
																				</td>
																				<td>	
																					<a href="index.html" class="abmenu" id="abmenu">Home</a>
																				</td>
																				<td width="5" />
																				<td>
																					<img src="images/bmenu_separator.gif" alt="" style="margin: 0px 5px 0px 5px;"/>
																				</td>
																				<td width="5"></td>
																			</tr>
																		</table>
																		<div style="width: 0px; height: 10px;"><span></span></div>
																		<div align="center" class="footer">
																			(C) 2010 Adam Koprowski
																		</div>
																	</TD>
																</TR>
															</TABLE>
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
	
</xsl:stylesheet>
