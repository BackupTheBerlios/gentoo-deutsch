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

      
      <table class="ebuildlist" cellspacing="0" cellpadding="2" border="0" style="width:100%">
      
      
      <xsl:for-each select="pkg">
        <xsl:sort select="category"/>
        
        <xsl:variable name="cname" select="category"/>
        
        <xsl:if test="preceding-sibling::pkg/child::category != $cname">
          <tr class="header">
            <td colspan="2">           
              <xsl:value-of select="$cname"/>
            </td>
          </tr>    
        
          <xsl:for-each select="../pkg[category = $cname]">
            <xsl:sort select="name"/>
          
            <xsl:variable name="pname" select="name"/>
            
            <xsl:if test="preceding-sibling::pkg/child::name != $pname">

              <tr class="low">
                <td style="vertical-align:top; border-bottom: 1px dotted #45347B">
                  <b>
                    <a class="uri" href="{$baselink}/{category}/{name}">
                      <xsl:value-of select="name"/>
                    </a>
                  </b>
                  <br/>
                  <xsl:value-of select="description"/>
                </td>
                <td style="max-width:150px; width:30%; border-bottom: 1px dotted #45347B">
                  <b>Letzte Änderung:</b>
                  <br/>
                  <xsl:for-each select="../pkg[name = $pname]">
                    <xsl:sort select="date/@year"/>
                    <xsl:sort select="date/@month"/>
                    <xsl:sort select="date/@day"/>
                    
                    <xsl:if test="position() = 1">
                      <xsl:value-of select="concat(date/@day, '.', date/@month, '.', date/@year)"/>
                    </xsl:if>
                  </xsl:for-each>
                  
                  <br/><br/>
                  <b>Archiv:</b>
                  <br/>
                  <a class="uri" href="{$baselink}/{category}/{name}/{name}.tar.gz?tarball=1">
                    <xsl:text>&#160;&#187; Download</xsl:text>
                  </a>
                  
                  <br/><br/>
                  <b>Versionen:</b>
                  <br/>
                  <xsl:for-each select="../pkg[name = $pname]">
                    <a class="uri">
                      <xsl:attribute name="href">
                        <xsl:text>http://cvs.berlios.de/cgi-bin/viewcvs.cgi/gentoo-deutsch/ebuilds/</xsl:text>
                        <xsl:value-of select="$cname"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$pname"/>
                        <xsl:text>/</xsl:text>
                        <xsl:value-of select="$pname"/>
                        <xsl:text>-</xsl:text>
                        <xsl:value-of select="version"/>
                        <xsl:if test="revision != ''"> 
                          <xsl:text>-r</xsl:text>
                          <xsl:value-of select="revision"/>
                        </xsl:if>  
                        <xsl:text>.ebuild</xsl:text>
                      </xsl:attribute>
                    
                      <xsl:text>&#160;&#187; </xsl:text>
                      <xsl:value-of select="version"/>
                      <xsl:if test="revision != ''"> 
                        <xsl:text>-r</xsl:text>
                        <xsl:value-of select="revision"/>
                      </xsl:if>  
                    </a>
                    <br/>                
                  </xsl:for-each>
                </td>
              </tr>
            
            </xsl:if>
          </xsl:for-each>
        </xsl:if>  
      </xsl:for-each>
      
      </table>

      
      <br/><br/>      
      
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
