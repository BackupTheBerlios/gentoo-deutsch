<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" encoding="utf-8" indent="no"/>

<xsl:param name="listname" select="'gentoo_de'"/>

<xsl:template match="list">
  <xsl:element name="xsl:stylesheet">
    <xsl:attribute name="version">1.1</xsl:attribute>
    
    <xsl:element name="xsl:template">
      <xsl:attribute name="match">pkglist_<xsl:value-of select="$listname"/></xsl:attribute>
      
      <xsl:variable name="baselink">
        <xsl:choose>
	<xsl:when test="$listname = 'gentoo_org'">
	  <xsl:text>http://cvs.gentoo.org/cgi-bin/viewcvs.cgi/gentoo-x86</xsl:text>
	</xsl:when>
	<xsl:when test="$listname = 'gentoo_de'">
	  <xsl:text>http://cvs.berlios.de/cgi-bin/viewcvs.cgi/gentoo-deutsch/ebuilds</xsl:text>
	</xsl:when>
        </xsl:choose>
      </xsl:variable>
      
      <table cellpadding="0" cellspacing="0" class="ebuildlist">
      <xsl:for-each select="pkg">
        <tr id="info_{name}">
          <td><xsl:value-of select="name"/></td>



        </tr>
        <tr id="details_{name}" style="display:none">


        </tr>
      </xsl:for-each> 
      </table>
    </xsl:element>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
