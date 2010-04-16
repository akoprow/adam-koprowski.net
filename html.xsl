<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="menu.xsl" /> 

	<xsl:variable name="page-who">Adam Koprowski</xsl:variable>
	<xsl:variable name="page-name">personal homepage</xsl:variable>
	<xsl:variable name="page-footer">(C) 2010 Adam Koprowski</xsl:variable>

	<xsl:template name="html-page">
		<HTML>
			<xsl:call-template name="html-header" />
			<xsl:call-template name="html-main-box" />
		</HTML>
	</xsl:template>

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

	<xsl:template match="verbatim">
		<xsl:copy-of select="." />
	</xsl:template>

</xsl:stylesheet>