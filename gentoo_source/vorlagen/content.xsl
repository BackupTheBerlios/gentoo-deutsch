<?xml version="1.0" encoding="iso-8859-15"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:include href="../temp/config.xsl"/>
<xsl:include href="../temp/ebuild_new_org.xsl"/>
<xsl:include href="../temp/ebuild_all_de.xsl"/>

<xsl:include href="suche.xsl"/>

<!--
<xsl:output method="html" encoding="iso-8859-15" indent="no" doctype-system="http://www.w3.org/TR/html4/loose.dtd" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" omit-xml-declaration="no"/>
-->

<!--
<xsl:output method="xml" encoding="iso-8859-15" indent="no" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" 
omit-xml-declaration="yes"/>
-->

<xsl:output method="html" encoding="iso-8859-15" indent="no" 
omit-xml-declaration="no"/>



<xsl:variable name="baseurl"><xsl:value-of select="$def_online"/>/</xsl:variable>
<xsl:variable name="styleurl"><xsl:value-of select="$baseurl"/><xsl:value-of select="$pub_style"/>/</xsl:variable>
<xsl:variable name="scripturl"><xsl:value-of select="$baseurl"/><xsl:value-of select="$pub_script"/>/</xsl:variable>
<xsl:variable name="imageurl"><xsl:value-of select="$baseurl"/><xsl:value-of select="$pub_images"/>/</xsl:variable>

<xsl:template match="guide|info">
  <html>
  <head>



    <title><xsl:value-of select="$var_title"/> @ Gentoo Linux - Das deutschprachige Portal</title>
    <link rel="stylesheet" type="text/css" href="{$styleurl}index.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="{$styleurl}print.css" media="print"/>    
    <link rel="shortcut icon" href="{$baseurl}favicon.ico" type="image/x-icon"/>
    <script type="text/javascript" src="{$scripturl}index.js"></script>
    <style type="text/css"><![CDATA[img { behavior: url("]]><xsl:value-of select="$scripturl"/>pngbehavior.htc<![CDATA["); }]]></style>
  </head>

  <body onclick="__body()">

  <xsl:call-template name="menu"/>
  
  <div id="logo">
    <a href="{$baseurl}/index.html" title="Zur Gentoo.de-Startseite">    
      <img src="{$imageurl}logo/logo.jpg" height="105" width="272" alt="Gentoo Linux Logo"/>
    </a>  
  </div>
  <div id="logobk">
    <img src="{$imageurl}logo/title.jpg" height="88" width="218" alt="Gentoo Linux - Das deutschsprachige Portal"/>
  </div>  

  <div id="about">
    <a href="{$baseurl}" class="icon">
      <img src="{$imageurl}icons/home.png" width="16" height="16" alt="Zur�ck zur Startseite"/>
      <xsl:value-of select="$lng_homepage"/>
    </a>
    <xsl:text>&#160; &#160;</xsl:text>
    <a href="javascript:window.print()" class="icon">
      <img src="{$imageurl}icons/print.png" width="16" height="16" alt="Diese Seite drucken"/>
      <xsl:value-of select="$lng_print"/>
    </a>
    
    <xsl:if test="/guide">
      <h4><xsl:value-of select="$lng_version"/></h4>
      <p>
        <xsl:value-of select="version"/>
        <xsl:value-of select="$lng_date"/>
        <xsl:value-of select="date"/>
      </p>

      <h4><xsl:value-of select="$lng_author"/></h4>
      <p>
        <xsl:apply-templates select="author"/>
      </p>
    
      <h4><xsl:value-of select="$lng_overview"/></h4>
      <p>
        <xsl:apply-templates select="abstract"/>
      </p>
    
      <h4><xsl:value-of select="$lng_links"/></h4>
      <p>
        <xsl:for-each select="//uri">
          <xsl:variable name="uri">
            <xsl:choose>
              <xsl:when test="@link"><xsl:value-of select="@link"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <a href="{$uri}" target="_blank">
            <xsl:if test="position() &lt; 10 and count(//uri) &gt; 9">
	      <xsl:text>0</xsl:text>
            </xsl:if>  
          
            <xsl:value-of select="position()"/>
            <xsl:text>: </xsl:text>
	
            <xsl:variable name="myurl">
              <xsl:choose>
                <xsl:when test="contains($uri, '://')">
	          <xsl:value-of select="substring-after($uri, '://')"/>
	        </xsl:when>
	        <xsl:otherwise>
	          <xsl:value-of select="$uri"/>
                </xsl:otherwise>
              </xsl:choose>  
            </xsl:variable>
	
            <xsl:value-of select="substring($myurl, 0, 20)"/>
            <xsl:text>...</xsl:text>
          </a>
          <br/>
        </xsl:for-each>
      </p>
    </xsl:if>

    <xsl:apply-templates select="/*/box/*"/>
    
  </div>

  <div id="body">
    <h1 style="margin-top: 0px" class="top">
      <span style="font-size: 0.8em">&gt;&gt; </span>
      <xsl:value-of select="title"/>
    </h1>
    
    <xsl:apply-templates select="chapter"/>
      
    <br/><br/>
    <p>
      <a href="http://validator.w3.org/check/referer"><img
          src="http://www.w3.org/Icons/valid-html401"
          alt="Valid HTML 4.01!" height="31" width="88"/></a>
    </p>
  </div>
  
  <script type="text/javascript"><![CDATA[var browser = new __browser(); var ctl = new __ctl(); __init()]]></script>
  
  </body>
  </html>
</xsl:template>

<xsl:template match="author">
  <xsl:choose>
    <xsl:when test="mail">
      <a href="mailto:{mail/@link}" title="{@title}">
        <xsl:value-of select="mail"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <span title="{@title}">
        <xsl:value-of select="."/>
      </span>
    </xsl:otherwise>
  </xsl:choose>
  <br/>
</xsl:template>

<xsl:template match="html">
  <xsl:copy-of select="./*"/>
</xsl:template>

<!-- Block inside Box -->
<xsl:template match="block">
  <h4><xsl:value-of select="title"/></h4>
  <xsl:apply-templates select="p"/>	
</xsl:template>

<xsl:template match="chapter">
  <xsl:variable name="cid"><xsl:number/>.</xsl:variable>
  
  <xsl:if test="title">
    <h1>
      <xsl:if test="/guide">
        <span class="nr"><xsl:value-of select="$cid"/></span>
        <xsl:text> </xsl:text>
      </xsl:if>

      <xsl:if test="/info">
        <xsl:attribute name="class">info</xsl:attribute>
      </xsl:if>

      <xsl:value-of select="title"/>
    </h1>
  </xsl:if>
  
  <xsl:for-each select="section">
    <xsl:variable name="sid">
      <xsl:value-of select="position()"/>
    </xsl:variable>
    
    <xsl:if test="title">
      <h2>
        <xsl:if test="/guide">
          <span class="nr"><xsl:value-of select="$cid"/><xsl:value-of select="$sid"/></span>
          <xsl:text> </xsl:text>
        </xsl:if>

        <xsl:value-of select="title"/>
      </h2>
    </xsl:if>
    
    <xsl:apply-templates select="body"/>
  </xsl:for-each>  
</xsl:template>

<xsl:template match="body">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="p">
  <p><xsl:apply-templates/></p>
</xsl:template>

<xsl:template match="table">
  <table cellpadding="0" cellspacing="0" border="0">
  <xsl:for-each select="tr">
    <tr>
      <xsl:if test="position() mod 2 != 0">
        <xsl:attribute name="class">high</xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </tr>
  </xsl:for-each>
  </table>
</xsl:template>

<xsl:template match="tr">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="th">
  <td class="head" nowrap="nowrap"><xsl:apply-templates/></td>
</xsl:template>

<xsl:template match="ti">
  <td><xsl:apply-templates/></td>
</xsl:template>

<xsl:template match="path">
  <span class="path"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="quot">
  <span class="quot">&#187;<xsl:apply-templates/>&#171;</span>
</xsl:template>

<xsl:template match="uri">
  <a class="uri">
    <xsl:attribute name="href">
      <xsl:choose>
        <xsl:when test="@link"><xsl:value-of select="@link"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:if test="@target">
      <xsl:attribute name="target">
        <xsl:value-of select="@target"/>
   

      
      </xsl:attribute>
    </xsl:if>

    <xsl:apply-templates/>
  </a>
</xsl:template>

<xsl:template match="mail">
  <a class="uri">
    <xsl:attribute name="href">
      <xsl:text>mailto:</xsl:text>
      <xsl:choose>
	<xsl:when test="@nospam and @link">NOSPAM-<xsl:value-of select="@link"/></xsl:when>
        <xsl:when test="@link"><xsl:value-of select="@link"/></xsl:when>                                                            
        <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>   
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates/>
  </a>
</xsl:template>

<xsl:template match="comment">
  <span class="comment"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="codenote">
  <span class="comment">// <xsl:value-of select="."/></span>
</xsl:template>

<xsl:template match="note">
  <table class="note" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="header"><xsl:value-of select="$lng_note"/></td>
    </tr>
    <tr>
      <td class="content">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<xsl:template match="impo">
  <table class="impo" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="header"><xsl:value-of select="$lng_impo"/></td>
    </tr>
    <tr>
      <td class="content">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<xsl:template match="warn">
  <table class="warn" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="header"><xsl:value-of select="$lng_warn"/></td>
    </tr>
    <tr>
      <td class="content">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<xsl:template match="box">
  <table>
    <tr>
      <td>
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<xsl:template match="pre">
  <xsl:variable name="prenum"><xsl:number level="any"/></xsl:variable>
  <xsl:variable name="preid">doc_pre<xsl:number level="any"/></xsl:variable>
  <a name="{$preid}"/>
  
  <div class="codetitle">
    <xsl:text>Befehlsauflistung </xsl:text>
    <xsl:value-of select="$prenum"/>

    <xsl:if test="@caption">
      <xsl:text>: </xsl:text>
      <span style="font-weight: normal"><xsl:value-of select="@caption"/></span>
    </xsl:if>
  </div>
  <pre><xsl:apply-templates/></pre>
</xsl:template>

<xsl:template match="c">
  <span class="code"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="b">
  <b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="i">
  <span class="input"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="brite">
  <span class="brite"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="br">
  <br/>
</xsl:template>

<xsl:template match="ul">
  <ul><xsl:apply-templates/></ul>
</xsl:template>

<xsl:template match="li">
  <li><xsl:apply-templates/></li>
</xsl:template>


</xsl:stylesheet>