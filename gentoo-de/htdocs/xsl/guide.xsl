<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output encoding="UTF-8" method="html" indent="yes" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"/>
<!-- Include external stylesheets -->
<xsl:include href="content.xsl" />
<xsl:include href="handbook.xsl" />
<xsl:include href="news.xsl" />

<!-- When using <pre>, whitespaces should be preserved -->
<xsl:preserve-space elements="pre"/>

<!-- Global definition of style parameter -->
<xsl:param name="style">0</xsl:param>

<!-- img tag -->
<xsl:template match="img">
  <img src="{@src}"/>
</xsl:template>

<xsl:template name="guidecontent">
  <xsl:apply-templates select="chapter"/>
  <br/>
  <xsl:if test="/guide/license">
    <xsl:apply-templates select="license"/>
  </xsl:if>
  <br/>
</xsl:template>

<xsl:template name="printdoclayout">
<html>
  <head>
    <title>gentoo.de</title>
    <link rel="stylesheet" href="/css/index.css" type="text/css"/>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
  </head>
<body>

<!-- Content goes here -->
<xsl:call-template name="content" />

</body>
</html>
</xsl:template>


<!-- Layout for documentation -->
<xsl:template name="doclayout">
<html>
  <head>
    <title>gentoo.de</title>
    <link rel="stylesheet" href="/css/index.css" type="text/css"/>
    <xsl:if test="/info">
      <link rel="stylesheet" href="/css/info.css" type="text/css"/>
    </xsl:if>
    <xsl:if test="/guide|/book">
      <link rel="stylesheet" href="/css/doku.css" type="text/css"/>
    </xsl:if>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type"/>
  </head>
  <xsl:if test="/guide">
  <div id="dropdown">
    <form style="font-size: 0.7em" action="http://www.gentoo.de/">
      <p><select name="url" size="1" class="jumpbox" onchange="location.hash=form.url.options[form.url.selectedIndex].value; form.url.value='---'">
        <option value="---">[Bitte Kapitel auswählen]</option>
        <xsl:for-each select="chapter/title">
          <option value="header_{position()}"><xsl:value-of select="."/></option>
        </xsl:for-each>
      </select></p>
    </form>
  </div>
  </xsl:if>
  <body bgcolor="white">
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td class="logo" width="200" rowspan="2" align="center">
          <a href="/"><img src="/img/logo-2004.png" height="110" width="160" alt="Gentoo"/></a>
        </td>
        <td bgcolor="white" colspan="3">
          <img src="/img/blank.gif" height="78"/>
        </td>
      </tr>
      <tr>
        <td class="navi" colspan="4" height="23" align="right">
         <a class="navi" href="/main/de/news.xml">Neuigkeiten</a>&#160;&#160;
         <a class="navi" href="/proj/de/index.xml">Projekt</a>&#160;&#160;
         <a class="navi" href="/doc/de/index.xml">Dokumentation</a>&#160;&#160;
         <a class="navi" href="/main/de/foren.xml">Foren</a>&#160;&#160;
         <a class="navi" href="/main/de/listen.xml">Listen</a>&#160;&#160;
         <a class="navi" href="/main/de/irc.xml">IRC</a>&#160;&#160;
         <!--<a class="navi" href="/gwn/de/index.xml">GWN</a>&#160;&#160;
         <a class="navi" href="#">Ebuilds</a>&#160;-->
        </td>
      </tr>
      <tr>
        <td bgcolor="white" height="5" colspan="4" class="unpadding">
        </td>
      </tr>
      <tr>
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
          <tr>
            <td width="20" class="unpadding">
            </td>
            <td class="blank" height="25" colspan="4">
            </td>
          </tr>
        </table>
      </tr>
      <tr>
        <td class="unpadding">
          <img src="/img/blank.gif" height="5"/>
        </td>
      </tr>
      <tr>
        <table cellpadding="0" cellspacing="0" border="0" width="100%">
          <tr>
            <td width="20" class="unpadding"></td>
            <xsl:if test="/info">
            <td class="left" width="200" valign="top">
              <!-- icons und Link auf Startseite und Druckversion -->
              <img src="/img/icons/home.png" width="16" height="16" alt="Startseite"/>&#160;
              <a href="#" class="uri">Startseite</a>&#160;
              <img src="/img/icons/print.png" width="16" height="16" alt="Diese Seite drucken"/>&#160;
              <a href="javascript:window.print()" class="uri">Drucken</a>
              <!-- Navigation -->
              <h4>Übersicht:</h4>
              <li><a class="uri" href="/main/de/news.xml">Neuigkeiten</a></li>
              <li><a class="uri" href="/doc/de/index.xml">Dokus auf einen Blick</a></li>
              <h4>Projekt:</h4>
              <li><a class="uri" href="/proj/de/index.xml">Über Gentoo</a></li>
              <h4>Dokumentation:</h4>
              <li><a class="uri" href="/doc/de/handbook/handbook.xml">Gentoo Handbuch</a></li>
              <li><a class="uri" href="/proj/de/gtt/information.xml">Informationen für Übersetzer</a></li>
            </td>
            </xsl:if>
            <xsl:if test="/book|/guide">
            <td class="left" width="150" valign="top">
              <xsl:if test="/book">
              <h4>Gentoo Handbuch</h4>
              Rev. <xsl:value-of select="/book/version"/><br/><xsl:value-of select="/book/date"/>
              </xsl:if>
              <h4>Autoren:</h4>
              <xsl:apply-templates select="/guide/author|/book/author"/>
            </td>
            <td>
              <img src="/img/blank.gif" width="3"/>
            </td>
            </xsl:if>
            <td valign="top">
              <table cellpadding="10" cellspacing="0" border="0" width="100%">
                <tr>
                  <td width="100%">
                    <xsl:if test="/guide">
                    <b><xsl:value-of select="/guide/date|/book/date"/></b>, Rev. <xsl:value-of select="/guide/version|/book/version"/>
                    <h3><xsl:value-of select="title"/></h3>
                    <p><xsl:apply-templates select="abstract"/></p>
                    </xsl:if>
                    <xsl:call-template name="content"/>
                  </td>
                </tr>
              </table>
            </td>
            <xsl:if test="/info">
            <td class="right" width="200" valign="top">
              <xsl:apply-templates select="document('tipp.xml')"/>
              <div align="center"><img src="img/dot_lila.png" width="150" height="2"/></div>
              <h4>Partnerseiten:</h4>
              <p align="center"><a href="http://www.gentoo.org"><img
              src="/img/gentooorg.gif"
              alt="http://www.gentoo.org"/></a></p>
              <p align="center"><a href="http://www.gentooform.de"><img
              src="/img/gentooforum.gif"
              alt="http://www.gentooforum.de"/></a></p>
            </td>
            </xsl:if>
          </tr>
        </table>
      </tr>
    </table>
  </body>
</html>
</xsl:template>

<!-- Guide template -->
<xsl:template match="/guide|/info">
<xsl:choose>
  <xsl:when test="substring(@style,1,1) = '?'">
    <xsl:call-template name="printdoclayout"/>
  </xsl:when>
  <xsl:otherwise>
  <xsl:call-template name="doclayout"/>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- Mail template -->
<xsl:template match="mail">
<a href="mailto:{@link}"><xsl:value-of select="."/></a>
</xsl:template>

<!-- Author template -->
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
    <i><xsl:value-of select="@title"/></i>
    <br/><br/>
</xsl:template>

<!-- Chapter -->
<xsl:template match="chapter">
  <xsl:variable name="cid"><xsl:number/></xsl:variable>

  <xsl:if test="title">
    <h1>
      <xsl:attribute name="id">
        <xsl:text>header_</xsl:text>
        <xsl:number/>
      </xsl:attribute>

      <span class="nr"><xsl:value-of select="$cid"/>.</span>
      <xsl:text> </xsl:text>

      <xsl:value-of select="title"/>
    </h1>
  </xsl:if>

  <xsl:for-each select="section">
    <xsl:variable name="sid">
      <xsl:value-of select="position()"/>
    </xsl:variable>

    <xsl:variable name="sectid">doc_chap<xsl:value-of select="$cid"/>_sect<xsl:value-of select="$sid"/></xsl:variable>

    <xsl:if test="title">
      <h2 id="{$sectid}">
        <xsl:if test="/guide">
          <span class="nr"><xsl:value-of select="$cid"/>.<xsl:value-of select="$sid"/></span>
          <xsl:text> </xsl:text>
        </xsl:if>

        <xsl:value-of select="title"/>
      </h2>
    </xsl:if>

    <xsl:apply-templates select="body"/>
  </xsl:for-each>
</xsl:template>


<!-- Section template -->
<xsl:template match="section">
<xsl:param name="chid"/>
<xsl:if test="title">
  <xsl:variable name="sectid">doc_chap<xsl:value-of select="$chid"/>_sect<xsl:number/></xsl:variable>
  <p class="secthead">
    <a name="{$sectid}"><xsl:value-of select="title"/>&#160;</a>
  </p>
</xsl:if>
<xsl:if test="@id">
  <a name="{@id}"/>
</xsl:if>
<xsl:apply-templates select="body">
  <xsl:with-param name="chid" select="$chid"/>
</xsl:apply-templates>
</xsl:template>

<!-- Figure template -->
<xsl:template match="figure">
<xsl:param name="chid"/>
<xsl:variable name="fignum"><xsl:number level="any" from="chapter" count="figure"/></xsl:variable>
<xsl:variable name="figid">doc_chap<xsl:value-of select="$chid"/>_fig<xsl:value-of select="$fignum"/></xsl:variable>
<br/>
<a name="{$figid}"/>
<table cellspacing="0" cellpadding="0" border="0">
  <tr>
    <td class="infohead" bgcolor="#7a5ada">
      <p class="caption">
        <xsl:choose>
          <xsl:when test="@caption">
            Grafik <xsl:value-of select="$chid"/>.<xsl:value-of select="$fignum"/>: <xsl:value-of select="@caption"/>
          </xsl:when>
          <xsl:otherwise>
            Grafik <xsl:value-of select="$chid"/>.<xsl:value-of select="$fignum"/>
          </xsl:otherwise>
        </xsl:choose>
      </p>
    </td>
  </tr>
  <tr>
    <td class="head">
      <xsl:choose>
        <xsl:when test="@short">
          <img src="{@link}" alt="Fig. {$fignum}: {@short}"/>
        </xsl:when>
        <xsl:otherwise>
          <img src="{@link}" alt="Fig. {$fignum}"/>
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </tr>
</table>
<br/>
</xsl:template>

<!--figure without a caption; just a graphical element-->
<xsl:template match="fig">
<center>
  <xsl:choose>
    <xsl:when test="@linkto">
      <a href="{@linkto}"><img border="0" src="{@link}" alt="{@short}"/></a>
    </xsl:when>
    <xsl:otherwise>
      <img src="{@link}" alt="{@short}"/>
    </xsl:otherwise>
  </xsl:choose>
</center>
</xsl:template>

<!-- Line break -->
<xsl:template match="br">
<br/>
</xsl:template>

<!-- Note -->
<xsl:template match="note">
  <table class="note" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="header">Notiz</td>
    </tr>
    <tr>
      <td class="content">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<!-- Important item -->
<xsl:template match="impo">
  <table class="impo" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="header">Wichtig</td>
    </tr>
    <tr>
      <td class="content">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<!-- Warning -->
<xsl:template match="warn">
  <table class="warn" cellpadding="0" cellspacing="0" border="0">
    <tr>
      <td class="header">Warnung</td>
    </tr>
    <tr>
      <td class="content">
        <xsl:apply-templates/>
      </td>
    </tr>
  </table>
</xsl:template>

<!-- Code note -->
<xsl:template match="codenote">
<span class="comment">// <xsl:value-of select="."/></span>
</xsl:template>

<!-- Regular comment -->
<xsl:template match="comment">
<span class="comment">
  <xsl:apply-templates/>
</span>
</xsl:template>

<!-- User input -->
<xsl:template match="i">
<span class="input"><xsl:apply-templates/></span>
</xsl:template>

<!-- Bold -->
<xsl:template match="b">
<b><xsl:apply-templates/></b>
</xsl:template>

<!-- Brite -->
<xsl:template match="brite">
<font color="#ff0000">
  <b><xsl:apply-templates/></b>
</font>
</xsl:template>

<!-- Body -->
<xsl:template match="body">
<xsl:param name="chid"/>
<xsl:apply-templates>
  <xsl:with-param name="chid" select="$chid"/>
</xsl:apply-templates>
</xsl:template>

<!-- Command or input, not to use inside <pre> -->
<xsl:template match="c">
<span class="code"><xsl:apply-templates/></span>
</xsl:template>

<!-- Box with small text -->
<xsl:template match="box">
<p class="infotext"><xsl:apply-templates/></p>
</xsl:template>

<!-- Preserve whitespace, aka Code Listing -->
<xsl:template match="pre">
  <xsl:variable name="prenum"><xsl:number level="any"/></xsl:variable>
  <xsl:variable name="preid">doc_pre<xsl:value-of select="$prenum"/></xsl:variable>
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

<!-- Path -->
<xsl:template match="path">
<span class="path"><xsl:value-of select="."/></span>
</xsl:template>

<!-- Url -->
<xsl:template match="uri">
<!-- expand templates to handle things like <uri link="http://bar"><c>foo</c></uri> -->
<xsl:choose>
  <xsl:when test="@link">
    <xsl:choose>
      <xsl:when test="substring(@link,1,1) = '?'">
        <!-- We are dealing with a handbook link -->
        <!-- TODO: don't hardcode handbook.xml because of draft -->
        <a class="uri" href="handbook.xml{@link}"><xsl:apply-templates/></a>
      </xsl:when>
      <xsl:otherwise>
        <a class="uri" href="{@link}"><xsl:apply-templates/></a>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:when>
  <xsl:otherwise>
    <xsl:variable name="loc" select="."/>
    <a class="uri" href="{$loc}"><xsl:apply-templates/></a>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- Paragraph -->
<xsl:template match="p">
<xsl:param name="chid"/>
<xsl:choose>
  <xsl:when test="@class">
    <p class="{@class}">
      <xsl:apply-templates>
        <xsl:with-param name="chid" select="$chid"/>
      </xsl:apply-templates>
    </p>
  </xsl:when>
  <xsl:otherwise>
    <p>
      <xsl:apply-templates>
        <xsl:with-param name="chid" select="$chid"/>
      </xsl:apply-templates>
    </p>
  </xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- Emphasize -->
<xsl:template match="e">
  <span class="emphasis"><xsl:apply-templates/></span>
</xsl:template>

<!-- E-mail address -->
<xsl:template match="mail">
<a href="mailto:{@link}"><xsl:value-of select="."/></a>
</xsl:template>

<!-- Table -->
<xsl:template match="table">
  <table class="content" cellpadding="0" cellspacing="0" border="0">
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

<!-- Table Row -->
<xsl:template match="tr">
  <xsl:apply-templates/>
</xsl:template>

<!-- Table Row -->
<xsl:template match="tr">
<td bgcolor="#ddddff" class="tableinfo">
  <xsl:apply-templates/>
</td>
</xsl:template>

<!-- Table Item -->
<xsl:template match="ti">
  <td><xsl:apply-templates/></td>
</xsl:template>
  
<!-- Table Heading -->
<xsl:template match="th">
  <td class="head"><xsl:apply-templates/></td>
</xsl:template>

<!-- Unnumbered List -->
<xsl:template match="ul">
<ul>
  <xsl:apply-templates/>
</ul>
</xsl:template>

<!-- Ordered List -->
<xsl:template match="ol">
<ol>
  <xsl:apply-templates/>
</ol>
</xsl:template>

<!-- List Item -->
<xsl:template match="li">
<li>
  <xsl:apply-templates/>
</li>
</xsl:template>

<!-- NOP -->
<xsl:template match="ignoreinemail">
<xsl:apply-templates/>
</xsl:template>

<!-- NOP -->
<xsl:template match="ignoreinguide">
</xsl:template>

<!-- License Tag -->
<xsl:template match="license">
  Die Inhalte dieses Dokuments sind unter der <a class="uri"
  href="http://creativecommons.org/licenses/by-sa/1.0">Creative Commons -
  Attribution / Share Alike</a> Lizenz lizenziert.
  <br/><br/>
</xsl:template>

</xsl:stylesheet>
