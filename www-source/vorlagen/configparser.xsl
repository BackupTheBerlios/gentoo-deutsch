<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:template match="config">
  <xsl:element name="xsl:stylesheet">
    <xsl:attribute name="version">1.1</xsl:attribute>
    
    <xsl:element name="xsl:output">
      <xsl:attribute name="method">xml</xsl:attribute>
      <xsl:attribute name="encoding">utf-8</xsl:attribute>
      <xsl:attribute name="indent">no</xsl:attribute>        
    </xsl:element>  
    
    <xsl:apply-templates/>
  </xsl:element>
</xsl:template>

<xsl:template match="language">
  <xsl:element name="xsl:variable">
    <xsl:attribute name="name">
      <xsl:text>def_</xsl:text>
      <xsl:value-of select="name()"/>
    </xsl:attribute>
    <xsl:value-of select="@value"/>
  </xsl:element>
  
  <xsl:for-each select="*">
    <xsl:element name="xsl:variable">
      <xsl:attribute name="name">
        <xsl:value-of select="../@short"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="name()"/>
      </xsl:attribute>
      <xsl:value-of select="."/>      
    </xsl:element>
  </xsl:for-each>    
</xsl:template>    

<xsl:template name="menurecurser">
  <xsl:param name="level"/>
  <xsl:param name="href"/>
  <xsl:param name="filename"/>    

  <xsl:if test="count(item) &gt; 0">
    
    <!-- Baue Menue -->
    <div id="gmenu{$level}">
      <xsl:attribute name="class">
        <xsl:choose>
          <xsl:when test="string-length($level) = 0">mainmenu</xsl:when>
          <xsl:otherwise>submenu</xsl:otherwise>      
        </xsl:choose>
      </xsl:attribute>      

      <xsl:for-each select="item">
        <xsl:variable name="current_linkid">
          <xsl:value-of select="$level"/>
          <xsl:text>_</xsl:text>
          <xsl:value-of select="position()"/>
        </xsl:variable>
	
        <xsl:variable name="current_href">
          <xsl:value-of select="$href"/>
          <xsl:text>/</xsl:text>
          <xsl:value-of select="@href"/>
        </xsl:variable>	
    
        <a href="{$current_href}" id="glink{$current_linkid}">
	  <xsl:if test="count(item) &gt; 0">
	    <xsl:attribute name="onmouseover">menu.handle(this.id)</xsl:attribute>
	  </xsl:if>
          <xsl:value-of select="@title"/>
        </a> 
      </xsl:for-each>
    </div>
    
    <!-- Schaue nach Unterpunkten -->
    <xsl:for-each select="item">
      <xsl:variable name="current_linkid">
        <xsl:value-of select="$level"/>
        <xsl:text>_</xsl:text>
        <xsl:value-of select="position()"/>
      </xsl:variable>
	
      <xsl:variable name="current_href">
        <xsl:value-of select="$href"/>
        <xsl:text>/</xsl:text>
        <xsl:value-of select="@href"/>
      </xsl:variable>	
            
      <xsl:call-template name="menurecurser">
        <xsl:with-param name="level"><xsl:value-of select="$current_linkid"/></xsl:with-param>  
        <xsl:with-param name="href"><xsl:value-of select="$current_href"/></xsl:with-param>
        <xsl:with-param name="filename"><xsl:value-of select="$filename"/></xsl:with-param>
      </xsl:call-template>
    </xsl:for-each>
    
  </xsl:if>
 
</xsl:template>


<xsl:template match="menu">
  <xsl:element name="xsl:template">
    <xsl:attribute name="name">menu</xsl:attribute>  
  
  <xsl:variable name="filename">
    <xsl:value-of select="../online/basename"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="../online/extension"/>
  </xsl:variable>
  
  <xsl:call-template name="menurecurser">
    <xsl:with-param name="level"></xsl:with-param>  
    <xsl:with-param name="href">/inhalte</xsl:with-param>
    <xsl:with-param name="filename"><xsl:value-of select="$filename"/></xsl:with-param>
  </xsl:call-template>
  
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
