<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:import href="html.xsl" /> 
	<xsl:import href="ratings.xsl" />
	<xsl:output method="html" indent="no" />
	<xsl:strip-space elements="*" />

	<xsl:variable name="movies" select="document('../data/movies.xml')" />

	<xsl:template match="imdb-link">
		<div>
			This page is generated from
			<A href="http://www.imdb.com/mymovies/list?l=2700180">
				my vote history at IMDB
			</A>.
		</div> 		
	</xsl:template>

	<xsl:template match="movies-by-year">
		<div>
  			<xsl:variable name="first" select="@first" />
			<xsl:variable name="last" select="@last" />

			<xsl:if test="$last and not($movies//movie[title = $last])">
				<xsl:message terminate="yes">
					<xsl:text>Cannot find a boundary movie: </xsl:text>
					<xsl:value-of select="$last" />
				</xsl:message>
			</xsl:if>
			 <!-- TODO abstract this pattern, avoid repetition -->
			<xsl:if test="$first and not($movies//movie[title = $first])">
				<xsl:message terminate="yes">
					<xsl:text>Cannot find a boundary movie: </xsl:text>
					<xsl:value-of select="$first" />
				</xsl:message>
			</xsl:if>
			<UL class="movies">
				<xsl:for-each select="$movies//movie[
					not(preceding-sibling::movie/title = $first) and
					not(following-sibling::movie/title = $last) and
					not(title = $last)]">		<tvsries>
		
		</tvsries>
					
					<xsl:call-template name="show-movie" />
				</xsl:for-each>
			</UL>
			<div style="clear: both;" />
		</div>
	</xsl:template>

	<xsl:template match="movies-by-rating">
		<div>
  			<xsl:variable name="min" select="number(@min)" />
			<xsl:variable name="max" select="number(@max)" />

			<UL class="movies">
				<xsl:for-each select="$movies//movie[(number(my-rating) ge $min) and (number(my-rating) le $max)]">
					<xsl:sort order="descending" data-type="number" select="my-rating" />
					<xsl:call-template name="show-movie" />
				</xsl:for-each>
			</UL>
			<div style="clear: both;" />
		</div>
	</xsl:template>
	
	<xsl:template name="show-movie">
		<xsl:variable name="imdb-url">
			<xsl:text>http://www.imdb.com/title/tt</xsl:text>
			<xsl:value-of select="id" />
		</xsl:variable>
	    <LI>
	    	<table class="moviesTable">
	    		<tr>
	    			<td class="no">
                         <xsl:number value="position()" format="1. "/>
	    			</td>
	    			<td class="img">
<!--				    <script type="text/javascript" src="http://www.movieposterdb.com/embed.inc.php?movie_id={id}" />-->
						<a href="{$imdb-url}">
					    	<img src="images/imdb-posters/{id}.jpg" height="100" />
					    </a>
	    			</td>
	    			<td class="data">
						<span class="title">
							<a href="{$imdb-url}">
								<xsl:value-of select="title" />
							</a>
						</span>
						<span>
							<xsl:variable name="rating">
								<xsl:choose>
									<xsl:when test="my-rating = 10">5.0</xsl:when>
									<xsl:when test="my-rating = 9">4.5</xsl:when>
									<xsl:when test="my-rating = 8">4.0</xsl:when>
									<xsl:when test="my-rating = 7">3.0</xsl:when>
									<xsl:when test="my-rating = 6">2.0</xsl:when>
									<xsl:otherwise>1.0</xsl:otherwise>
								</xsl:choose>
							</xsl:variable>
							<xsl:call-template name="show-rating">
								<xsl:with-param name="rating" select="$rating" />
							</xsl:call-template>							
						</span>
						<span class="imdb">
							<a class="imdb-info" href="{$imdb-url}" rel="#imdb-{id}">
								IMDB
							</a>
						</span>
					</td>
	    		</tr>
			</table>
			<div id="imdb-{id}" class="imdb-box">
				<span class="imdb-stars">
					<span class="outer"> 
						<span class="inner" style="width: {20*imdb-rating}px" /> 
					</span>
				</span>
				<span class="imdb-meta">
					<span class="imdb-rating">
						<xsl:value-of select="imdb-rating"/>
						<xsl:text>/10</xsl:text>
					</span> 
					<span class="imdb-votes">
						<xsl:value-of select="imdb-votes" />
					</span>
				</span>
			</div>
	    </LI>
	</xsl:template>
	
</xsl:stylesheet>
