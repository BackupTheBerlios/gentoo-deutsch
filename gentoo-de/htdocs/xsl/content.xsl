<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template name="content">
  <xsl:if test="local-name() = 'info'">
    <!-- Inside /info -->
    <xsl:call-template name="guidecontent" />
  </xsl:if>
  <xsl:if test="local-name() = 'guide'">
    <!-- Inside /guide -->
    <xsl:call-template name="guidecontent" />
  </xsl:if>
  <xsl:if test="local-name() = 'book'">
    <!-- Inside /book -->
    <xsl:call-template name="bookcontent" />
  </xsl:if>
  <xsl:if test="local-name() = 'part'">
    <!-- Inside /book/part -->
    <xsl:call-template name="bookpartcontent" />
  </xsl:if>
  <xsl:if test="local-name() = 'chapter'">
    <!-- Inside /book/part/chapter -->
    <xsl:call-template name="bookpartchaptercontent" />
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
