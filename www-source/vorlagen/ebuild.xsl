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

      <table class="ebuildlist" cellspacing="0" cellpadding="0" border="0"> 
        <tr class="header">
          <td>Name</td>
          <td>Version</td>
          <td>Revision</td>
          <td>Kategorie</td>
          <td>Download</td>           
          <td>Veränderungen</td>
          <td>Datum</td>
        </tr>

        <xsl:for-each select="pkg">
          <xsl:sort select="category"/>
          <xsl:sort select="name"/>

          <tr title="{description}">
            <xsl:attribute name="class">
              <xsl:choose>
                <xsl:when test="position() mod 2 = 0">low</xsl:when>
                <xsl:otherwise>high</xsl:otherwise>
              </xsl:choose>
            </xsl:attribute>

            <td>
              <a class="uri" href="{$baselink}/{category}/{name}">
                <xsl:value-of select="name"/>
              </a>
            </td>
            <td><xsl:value-of select="version"/></td>
            <td><xsl:value-of select="revision"/></td>
            <td>
              <a class="uri" href="{$baselink}/{category}">
                <xsl:value-of select="category"/>
              </a>
            </td>
            <td>
              <a href="{$baselink}/{category}/{name}/{name}.tar.gz?tarball=1">Download</a>
            </td>  
            <td>
              <a href="{$baselink}/{category}/{name}/ChangeLog?rev=HEAD&#38;content-type=text/plain">Veränderungen</a>
            </td>
            <td>
              <xsl:value-of select="date/@day"/>
              <xsl:text>.</xsl:text>
              <xsl:value-of select="date/@month"/>
              <xsl:text>.</xsl:text>
              <xsl:value-of select="date/@year"/>
            </td>   
          </tr>
 
        </xsl:for-each> 

      </table>
    </xsl:element>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
