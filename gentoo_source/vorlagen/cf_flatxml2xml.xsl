<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="utf-8" indent="yes"/>

<xsl:template match="/">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="ebuilds">
  <pkglist name="{@name}">
  <xsl:for-each select="entry">
    <xsl:variable name="cat_lastpos">
      <xsl:value-of select="position() - 1"/>
    </xsl:variable>
    
    <xsl:variable name="precat">    
      <xsl:value-of select="parent::ebuilds/entry[position() = $cat_lastpos]/@cat"/>
    </xsl:variable>

    <xsl:if test="./@cat != $precat">
      <xsl:variable name="catname">
        <xsl:value-of select="./@cat"/>
      </xsl:variable>
      
      <cat name="{$catname}">
      
        <xsl:for-each select="../entry">

          <xsl:if test="@cat = $catname">
	  
	    <xsl:variable name="pkg_lastpos">
              <xsl:value-of select="position() - 1"/>
            </xsl:variable>
    
            <xsl:variable name="prepkg">    
              <xsl:value-of select="parent::ebuilds/entry[position() = $pkg_lastpos]/@pkg"/>
            </xsl:variable>
	
	    <xsl:if test="./@pkg != $prepkg">
	      <xsl:variable name="pkgname">
	        <xsl:value-of select="./@pkg"/>
              </xsl:variable>
	    
	    
              <pkg>
	        <pkgname><xsl:value-of select="./@pkg"/></pkgname>
		<pkgdescription><xsl:value-of select="./@description"/></pkgdescription>
	      
	        <xsl:for-each select="../entry[@pkg = $pkgname]">
		  <pkgversion><xsl:value-of select="@version"/></pkgversion>
	        </xsl:for-each>
              </pkg> 
	    </xsl:if>  
	  
	  </xsl:if>
        </xsl:for-each>
    
      </cat>
    </xsl:if>  
  </xsl:for-each>
  </pkglist>
</xsl:template>

</xsl:stylesheet>