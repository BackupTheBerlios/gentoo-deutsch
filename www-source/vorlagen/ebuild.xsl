<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="../temp/config.xsl"/>
<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:template match="pkglist">
  <xsl:element name="xsl:stylesheet">
    <xsl:attribute name="version">1.1</xsl:attribute>
    
    <xsl:element name="xsl:template">
      <xsl:attribute name="match">pkglist_<xsl:value-of select="@name"/></xsl:attribute>
      
      <xsl:variable name="baselink">
        <xsl:choose>
	<xsl:when test="contains(@name, $pub_portage_dest)">
	  <xsl:text>http://cvs.gentoo.org/cgi-bin/viewcvs.cgi/gentoo-x86</xsl:text>
	</xsl:when>
	<xsl:when test="contains(@name, $pub_ebuilds_dest)">
	  <xsl:text>http://cvs.berlios.de/cgi-bin/viewcvs.cgi/gentoo-deutsch/ebuilds</xsl:text>
	</xsl:when>
        </xsl:choose>
      </xsl:variable>
      
      <table cellpadding="0" cellspacing="0" border="0" width="400">
      <xsl:for-each select="cat">
        <xsl:sort select="@name"/>
        <xsl:if test="count(pkg) &gt; 0">
	<tr>
	  <td class="head" colspan="3">
	    <xsl:value-of select="@name"/>
	  </td>
	</tr>  
	
	<xsl:for-each select="pkg">
	<tr valign="top">
	  <xsl:if test="(position() mod 2) = 0">
	    <xsl:attribute name="class">high</xsl:attribute>
	  </xsl:if>
  
	  <td width="150">
            <a href="{$baselink}/{../@name}/{pkgname}">
	      <xsl:value-of select="pkgname"/>
	    </a>
	  </td>
	  <td width="250">
	    <xsl:value-of select="pkgdescription"/>
	  </td>
	  <td width="100">
	    <xsl:for-each select="pkgversion">
	      <xsl:value-of select="."/>
	      <xsl:if test="position() != last()"><br/></xsl:if>
	    </xsl:for-each>
	  </td>
	</tr>
        </xsl:for-each>
       
        </xsl:if>
      </xsl:for-each> 
      </table>
    </xsl:element>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
