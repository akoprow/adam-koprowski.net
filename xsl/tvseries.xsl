<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="ratings.xsl" />
	<xsl:output method="html" indent="no" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="tvseries" select="document('../data/tvseries.xml')/tvseries" />
	
	<xsl:template match="tvseries-watched">
		<xsl:call-template name="tvseries">
			<xsl:with-param name="series" select="$tvseries/finished/child::node()" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="tvseries-watching">
		<xsl:call-template name="tvseries">
			<xsl:with-param name="series" select="$tvseries/inprogress/child::node()" />
		</xsl:call-template>
	</xsl:template>
	
	<xsl:template name="tvseries">
		<xsl:param name="series" />
		<UL class="tvseries">
			<xsl:apply-templates select="$series" />
		</UL>	
	</xsl:template>

	<xsl:template match="tvserie">
		<LI>
			<table>
				<tr>
					<td>
						<img src="{poster}" class="poster" />					
					</td>
					<td class="info">
						<div>
							<a class="title" href="http://www.imdb.com/title/tt{imdb-id}/">
								<xsl:value-of select="name" />
							</a>
							<span class="year">
								(<xsl:value-of select="year" />)
							</span>
						</div>
						<div>
							<!-- FIXME This code is duplicated in movies.xsl - factorize -->
							<xsl:variable name="rating">
								<xsl:choose>
									<xsl:when test="rating = 10">5.0</xsl:when>
									<xsl:when test="rating = 9">4.5</xsl:when>
									<xsl:when test="rating = 8">4.0</xsl:when>
									<xsl:when test="rating = 7">3.0</xsl:when>
									<xsl:when test="rating = 6">2.0</xsl:when>
									<xsl:otherwise>1.0</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:call-template name="show-rating">
								<xsl:with-param name="rating" select="$rating" />
							</xsl:call-template>							
						</div>
					</td>
					<td>
						<xsl:apply-templates select="seasons/child::node()" />
					</td>
				</tr>
			</table>
		</LI>
	</xsl:template>
	
	<xsl:template name="spans">
		<xsl:param name="class" required="yes" />
		<xsl:param name="count" select="1" />

		<xsl:if test="$count > 0">
			<span class="{$class}"> </span>
			<xsl:call-template name="spans">
				<xsl:with-param name="class" select="$class" />
				<xsl:with-param name="count" select="$count - 1" />
			</xsl:call-template>
		</xsl:if>
	</xsl:template>	
	
	<xsl:template name="season">
		<xsl:param name="watched" />
		<xsl:param name="unwatched" />
		
		<span class="season">
			<span class="no">S<xsl:number level="multiple" /></span>
			<xsl:call-template name="spans">
				<xsl:with-param name="count" select="$watched" />				
				<xsl:with-param name="class">watched</xsl:with-param>				
			</xsl:call-template>
			<xsl:call-template name="spans">
				<xsl:with-param name="count" select="$unwatched" />				
				<xsl:with-param name="class">unwatched</xsl:with-param>				
			</xsl:call-template>
		</span>
	</xsl:template>
	
	<xsl:template match="season">
		<xsl:choose>
			<xsl:when test="finished">
				<xsl:call-template name="season">
					<xsl:with-param name="watched" select="@len" />
					<xsl:with-param name="unwatched">0</xsl:with-param>
				</xsl:call-template>			
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="season">
					<xsl:with-param name="watched" select="string-length(.)" />
					<xsl:with-param name="unwatched" select="@len - string-length(.)" />
				</xsl:call-template>			
			</xsl:otherwise>		
		</xsl:choose>
	</xsl:template>	
	
	<xsl:template match="season" mode="season-length">
		<xsl:variable name="episode-length" select="number(../../length)" />
		<season-length>
			<xsl:choose>
				<xsl:when test="finished">
					<xsl:value-of select="$episode-length * @len" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$episode-length * string-length(.)" />
				</xsl:otherwise>
			</xsl:choose>
		</season-length>
	</xsl:template>
	
	<xsl:template match="tvseries-total-days">
		<xsl:variable name="season-lengths">
			<xsl:apply-templates select="$tvseries//season" mode="season-length" />
		</xsl:variable>
		<xsl:value-of select="format-number(sum($season-lengths//season-length) div 60 div 24, '##.#')" />
	</xsl:template>

        <!-- FIXME, pattern similar to the one above, should be possible to refactor -->
	<xsl:template match="season" mode="season-missing-length">
		<xsl:variable name="episode-length" select="number(../../length)" />
		<season-length>
			<xsl:choose>
				<xsl:when test="finished">
					<xsl:value-of select="0" />
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="$episode-length * (@len - string-length(.))" />
				</xsl:otherwise>
			</xsl:choose>
		</season-length>
	</xsl:template>

	<xsl:template match="tvseries-missing-days">
		<xsl:variable name="season-lengths">
			<xsl:apply-templates select="$tvseries//season" mode="season-missing-length" />
		</xsl:variable>
		<xsl:value-of select="format-number(sum($season-lengths//season-length) div 60 div 24, '##.#')" />
	</xsl:template>

</xsl:stylesheet>
