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
      
      <xsl:for-each select="pkg">
        <xsl:sort select="category"/>
        <xsl:sort select="name"/>

        <table>

        <tr>
          <td>Paketname:</td>
          <td><xsl:value-of select="name"/></td>
        </tr>

        <tr>
          <td>Version:</td>
          <td><xsl:value-of select="version"/></td>
        </tr>

        <tr>
          <td>Revision:</td>
          <td><xsl:value-of select="revision"/></td>
        </tr>

        <tr>
          <td>Lizenz:</td>
          <td><xsl:value-of select="license"/></td>
        </tr>

        <tr>
          <td>Slot:</td>
          <td><xsl:value-of select="slot"/></td>
        </tr>

        <tr>
          <td>Änderung:</td>
          <td>
            <xsl:value-of select="date/@day"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="date/@month"/>
            <xsl:text>.</xsl:text>
            <xsl:value-of select="date/@year"/>
          </td>   
        </tr>

        <tr>
          <td>Homepage: </td>
          <td>
            <a href="{homepage}">
              <xsl:value-of select="homepage"/>
            </a>
          </td>
        </tr>

        </table>
      </xsl:for-each> 
      </table>
    </xsl:element>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
