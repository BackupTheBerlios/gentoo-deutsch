<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" encoding="iso-8859-1" indent="no"/>

<xsl:template name="bash">
  <xsl:param name="mainurl"/>
  
  <xsl:variable name="fullpath">
    <xsl:if test="$mainurl != ''">
      <xsl:value-of select="$mainurl"/>
      <xsl:text>/</xsl:text>
    </xsl:if>
    <xsl:value-of select="@href"/>
  </xsl:variable>  

  x_doc "<xsl:value-of select="$fullpath"/>" "<xsl:value-of select="@title"/>"; 
</xsl:template>

<xsl:template name="loop">
  <xsl:param name="baseurl"/>

  <xsl:if test="item|special">
    <xsl:for-each select="item|special">
      <xsl:variable name="thisurl">
        <xsl:if test="$baseurl != ''">
          <xsl:value-of select="$baseurl"/>
	  <xsl:text>/</xsl:text>
        </xsl:if>	  
        <xsl:value-of select="../@href"/>
      </xsl:variable>
    
      <xsl:call-template name="bash">
        <xsl:with-param name="mainurl"><xsl:value-of select="$thisurl"/></xsl:with-param>
      </xsl:call-template>
      
      <xsl:call-template name="loop">
        <xsl:with-param name="baseurl"><xsl:value-of select="$thisurl"/></xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:if>
</xsl:template>

<xsl:template match="/config">
  <xsl:apply-templates select="menu"/>
</xsl:template>

<xsl:template match="menu">
  <xsl:call-template name="loop"/>
</xsl:template>  

</xsl:stylesheet>
