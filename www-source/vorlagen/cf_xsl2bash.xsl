<?xml version="1.0" encoding="iso-8859-1"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" encoding="iso-8859-1" indent="no"/>

<xsl:template match="xsl:stylesheet">
  <xsl:apply-templates select="xsl:variable"/>
</xsl:template>

<xsl:template match="xsl:variable">
  <xsl:value-of select="@name"/>="<xsl:value-of select="."/>"
</xsl:template>

</xsl:stylesheet>
