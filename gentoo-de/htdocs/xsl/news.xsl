<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- gentoo.de Erweiterung -->
<xsl:template match="news">
<p style="background-color:#45347B; color:#FFFFFF; padding:3px; margin-bottom:0px">
  <span style="font-size:10px;"><xsl:value-of select="@date"/>;&#160;Autor:&#160;<xsl:value-of select="@autor"/></span>
  <br/>
  <span style="font-weight:bold; font-size:16px;"><xsl:value-of select="@title"/></span><br/>
</p>
<p style="font-size:medium; padding:3px; margin-top:0px">
  <table width="100%" class="content">
    <tr>
      <td valign="top">
      <img><xsl:attribute name="src">/img/icons/news/<xsl:value-of select="@type"/>.jpg</xsl:attribute>
        <xsl:attribute name="alt">
          <xsl:value-of select="@type"/>
        </xsl:attribute>
      </img>
      </td>
      <td>
       <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</p>
</xsl:template>

</xsl:stylesheet>
