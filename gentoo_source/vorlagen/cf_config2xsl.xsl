<?xml version="1.0" encoding="iso-8859-1"?>

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

<xsl:template match="public|source|online|portage|language">
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

<xsl:template match="menu">
  <xsl:element name="xsl:template">
  <xsl:attribute name="name">menu</xsl:attribute>
 
  <xsl:variable name="defhtml">
    <xsl:value-of select="../online/basename"/>
    <xsl:text>.</xsl:text>
    <xsl:value-of select="../online/extension"/>
  </xsl:variable>
  
  <xsl:variable name="siteurl">
    <xsl:value-of select="../online/@value"/>
    <xsl:text>/</xsl:text>
    <xsl:value-of select="../public/content"/>
  </xsl:variable>    
  
  
  <![CDATA[<!--ignore_search-->]]>
  
  <!-- ERSTELLE BUTTONBAR -->
  <div id="bar">
    <xsl:for-each select="item">
      <a href="{$siteurl}/{@href}/{$defhtml}" id="btn_m{position()}" onmouseover="__main(this)" onfocus="__focus(this)"><xsl:value-of select="@title"/></a>
      <xsl:text>  </xsl:text>
    </xsl:for-each>
  </div>

  <div id="special">
    <xsl:for-each select="special">
      <a href="{$siteurl}/{@href}/{$defhtml}" onfocus="__focus(this)"><xsl:value-of select="@title"/></a>
      <xsl:text>  </xsl:text>
    </xsl:for-each>
  </div>
  
  <!-- ERSTELLE HAUPTMENUES -->
  <xsl:for-each select="item">
    <xsl:variable name="mainurl"><xsl:value-of select="$siteurl"/>/<xsl:value-of select="@href"/>/</xsl:variable>
    <xsl:variable name="mpos"><xsl:value-of select="position()"/></xsl:variable>
    <div id="menu_m{$mpos}" class="menu">
      <xsl:for-each select="item">
        <a href="{$mainurl}{@href}/{$defhtml}" onmouseover="__sub(this)" onfocus="__focus(this)">
          <xsl:if test="item">
            <xsl:attribute name="id">btn_s<xsl:value-of select="$mpos"/>-<xsl:value-of select="position()"/></xsl:attribute>
          </xsl:if>
          <span class="text"><xsl:value-of select="@title"/></span>
          <xsl:if test="item">
            <span class="arrow">&#9654;</span>
          </xsl:if>
        </a>
      </xsl:for-each>
    </div>
    
    <xsl:for-each select="item">
      <xsl:variable name="suburl"><xsl:value-of select="$mainurl"/><xsl:value-of select="@href"/>/</xsl:variable>
      <xsl:if test="item">
      <div id="menu_s{$mpos}-{position()}" class="menu">
         <xsl:for-each select="item">
           <a href="{$suburl}{@href}/{$defhtml}"><xsl:value-of select="@title"/></a>
         </xsl:for-each>
      </div>
      </xsl:if>
    </xsl:for-each>
  </xsl:for-each>
  
  <![CDATA[<!--/ignore_search-->]]>
  
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
