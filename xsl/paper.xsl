<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="papers-common.xsl" /> 
	<xsl:output method="html" indent="yes" encoding="ISO-8859-1" />
	<xsl:strip-space elements="*" />

	<xsl:param name="paper-id" />
	<xsl:variable name="paper" select="id($paper-id, document('../data/papers.xml'))" />

	<xsl:template match="paper-title">
		<xsl:value-of select="$paper/title" />
	</xsl:template>

	<xsl:template match="paper-page">
		<xsl:if test="$paper/img">
			<div class="paper-img">
				<IMG src="papers/{$paper/img}" STYLE="float:right; " />
			</div>
		</xsl:if>	
		<div class="block">
			<EM>Abstract:</EM>
			<xsl:apply-templates select="$paper/abstract" />
		</div>
		<xsl:call-template name="paper-block" />
		<h2>BibTeX:</h2>
		<div class="block">
			<pre class="bibtex">
				<xsl:call-template name="paper-bibtex" />
			</pre>
		</div>
	</xsl:template>

	<xsl:template name="paper-block">
		<xsl:apply-templates mode="present-paper" select="$paper">
			<xsl:with-param name="link-to-paper">no</xsl:with-param>
			<xsl:with-param name="download">yes</xsl:with-param>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template name="paper-bibtex">
		<xsl:variable name="bibtex-type">
			<xsl:choose>
				<xsl:when test="$paper/conference or $paper/workshop-proceedings">@inproceedings</xsl:when>		
				<xsl:when test="$paper/journal">@article</xsl:when>		
				<xsl:when test="$paper/techreport">@techreport</xsl:when>		
				<xsl:when test="$paper/phdthesis">@phdthesis</xsl:when>		
				<xsl:otherwise>
					<xsl:message>
						Unknown paper type for paper with id: <xsl:value-of select="$paper-id" />			
					</xsl:message>			
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>

		<xsl:value-of select="$bibtex-type" />
		<xsl:text>{</xsl:text>
		<xsl:value-of select="$paper-id" />
		<xsl:text>,&#10;</xsl:text>
		
		<xsl:call-template name="bibtex-line" >
			<xsl:with-param name="field">author</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="replace(replace($paper/authors, ',', ' and '), '  ', ' ')" /></xsl:with-param>					
		</xsl:call-template>
		<xsl:call-template name="bibtex-line" >
			<xsl:with-param name="field">title</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="$paper/title" /></xsl:with-param>					
		</xsl:call-template>
		<xsl:apply-templates select="$paper/*" mode="bibtex" />
		<xsl:text>}</xsl:text>
	</xsl:template>

	<xsl:template name="bibtex-line">
		<xsl:param name="field" />
		<xsl:param name="value" />
		<xsl:variable name="spaces">          </xsl:variable>
		
		<xsl:text>  </xsl:text>
		<xsl:value-of select="$field" />
		<!-- TODO: white-spaces below are discarded... -->
		<xsl:value-of select="substring($spaces, string-length($spaces)-string-length($field))" />
		<xsl:text> = {</xsl:text>
		<xsl:value-of select="$value" />
		<xsl:text>},&#10;</xsl:text>
	</xsl:template>

	<!-- TODO It would be nice to improve this mark-up... so that a call to bibtex-line is less verbose -->
	<xsl:template match="conference | workshop-proceedings" mode="bibtex"> 
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">booktitle</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="name" /> (<xsl:value-of select="abbreviation" />)</xsl:with-param>					
		</xsl:call-template>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">year</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="../../@id" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:if test="series">
			<xsl:call-template name="bibtex-line">
				<xsl:with-param name="field">series</xsl:with-param>
				<xsl:with-param name="value"><xsl:apply-templates select="series/*" mode="bibtex" /></xsl:with-param>					
			</xsl:call-template>
		</xsl:if>	
		<xsl:if test="volume">
			<xsl:call-template name="bibtex-line">
				<xsl:with-param name="field">volume</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="volume" /></xsl:with-param>					
			</xsl:call-template>
		</xsl:if>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">pages</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="replace(pages, '-', '--')" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:if test="note">
			<xsl:call-template name="bibtex-line">
				<xsl:with-param name="field">note</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="note" /></xsl:with-param>					
			</xsl:call-template>
		</xsl:if>	
	</xsl:template>

	<xsl:template match="journal" mode="bibtex">
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">journal</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="name" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">year</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="../../@id" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">volume</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="volume" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">number</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="number" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">pages</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="replace(pages, '-', '--')" /></xsl:with-param>					
		</xsl:call-template>	
	</xsl:template>

	<xsl:template match="techreport" mode="bibtex">
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">year</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="../../@id" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:if test="month">
			<xsl:call-template name="bibtex-line">
				<xsl:with-param name="field">month</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="month" /></xsl:with-param>					
			</xsl:call-template>
		</xsl:if>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">institution</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="institution" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:if test="address">
			<xsl:call-template name="bibtex-line">
				<xsl:with-param name="field">address</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="address" /></xsl:with-param>					
			</xsl:call-template>
		</xsl:if>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">number</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="number" /></xsl:with-param>					
		</xsl:call-template>	
	</xsl:template>

	<xsl:template match="phdthesis" mode="bibtex">
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">school</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="school" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:call-template name="bibtex-line">
			<xsl:with-param name="field">year</xsl:with-param>
			<xsl:with-param name="value"><xsl:value-of select="../../@id" /></xsl:with-param>					
		</xsl:call-template>	
		<xsl:if test="month">
			<xsl:call-template name="bibtex-line">
				<xsl:with-param name="field">month</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="month" /></xsl:with-param>					
			</xsl:call-template>
		</xsl:if>
		<xsl:if test="isbn">
			<xsl:call-template name="bibtex-line">
				<xsl:with-param name="field">isbn</xsl:with-param>
				<xsl:with-param name="value"><xsl:value-of select="isbn" /></xsl:with-param>					
			</xsl:call-template>
		</xsl:if>
	</xsl:template>

	<xsl:template match="lnai" mode="bibtex">
		<xsl:text>Lecture Notes in Artificial Inteligence</xsl:text>
	</xsl:template> 

	<xsl:template match="lncs" mode="bibtex">
		<xsl:text>Lecture Notes in Computer Science</xsl:text>
	</xsl:template> 

	<xsl:template match="*" mode="bibtex" />
	 

</xsl:stylesheet>
