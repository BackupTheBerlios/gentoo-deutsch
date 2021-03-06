<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!--
  Part of the Gentoo WebSite:
  Document Version: 1.01
-->

<xsl:include href="../temp/config.xsl"/>
<xsl:include href="../temp/ebuild.xsl"/>

<xsl:include href="suche.xsl"/>

<!--
<xsl:output
  method="xml"
  encoding="utf-8"
  indent="no"
  doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
  doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
  omit-xml-declaration="no"
  cdata-section-elements=""
/>
-->


<xsl:output
  method="html"
  encoding="UTF-8"
  indent="no"
  doctype-public="-//W3C//DTD HTML 4.01//EN"
  doctype-system="http://www.w3.org/TR/html4/strict.dtd"
  omit-xml-declaration="yes"
  cdata-section-elements=""
/>


<xsl:variable name="baseurl">http://www.gentoo.de/</xsl:variable>
<xsl:variable name="styleurl"><xsl:value-of select="$baseurl"/>media/stile/</xsl:variable>
<xsl:variable name="scripturl"><xsl:value-of select="$baseurl"/>media/skripte/</xsl:variable>
<xsl:variable name="imageurl"><xsl:value-of select="$baseurl"/>media/bilder/</xsl:variable>

<xsl:template match="guide|info">
  <html>
  <head>
    <title>
      <xsl:value-of select="title"/>
      <xsl:text> @ Gentoo Linux - Das deutschsprachige Portal</xsl:text>
    </title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="stylesheet" type="text/css" href="{$styleurl}index.css" media="screen"/>
    <link rel="stylesheet" type="text/css" href="{$styleurl}print.css" media="print"/>
    <link rel="shortcut icon" href="{$baseurl}favicon.ico" type="image/x-icon"/>
    <!--<script type="text/javascript" src="{$scripturl}corelib.js"></script>!-->
    <style type="text/css"><![CDATA[img { behavior: url("]]><xsl:value-of select="$scripturl"/>pngbehavior.htc<![CDATA["); }]]></style>
  </head>

  <!--<body onclick="menu.closeAll()">!-->
  <body>

  <![CDATA[<!-- keine-suche-start -->]]>

  <xsl:call-template name="menu"/>

  <div id="logo_bg">&#160;</div>

  <div id="logo">
    <table cellpadding="0" cellspacing="0" border="0" width="100%"><tr>

    <td style="width: 50%" valign="top">
      <img src="{$imageurl}logo/title.jpg" height="88" width="218" alt="Gentoo Linux - Das deutschsprachige Portal"/>
    </td>

    <td style="width: 272px">
      <a href="{$baseurl}index.html" title="Zur Gentoo.de-Startseite">
        <img src="{$imageurl}logo/logo.jpg" height="105" width="272" alt="Gentoo Linux Logo"/>
      </a>
    </td>

    <td valign="bottom" align="right" style="width: 50%">
      <form method="get" action="/cgi-bin/perlfect/search/search.pl" style="margin-bottom: 30px">
        <p>
        <input type="hidden" name="p" value="1"/>
	<input type="hidden" name="lang" value="de"/>


	<input type="hidden" name="penalty" value="0"/>
	<input type="hidden" name="mode" value="any"/>
	<input type="text" name="q" value="Suchbegriff" size="20"/>
	</p>
      </form>
    </td>

    </tr>
    </table>
  </div>

  <div id="about">
    <a href="{$baseurl}" class="icon">
      <img src="{$imageurl}icons/home.png" width="16" height="16" alt="Zurck zur Startseite"/>
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

      <xsl:if test="count(//uri) &gt; 0">
      <![CDATA[<!-- keine-suche-start -->]]>
      <h4><xsl:value-of select="$lng_links"/></h4>
      <p>
        <xsl:for-each select="//uri">
          <xsl:variable name="uri">
            <xsl:choose>
              <xsl:when test="@link"><xsl:value-of select="@link"/></xsl:when>
              <xsl:otherwise><xsl:value-of select="."/></xsl:otherwise>
            </xsl:choose>
          </xsl:variable>

          <a href="{$uri}" onclick="window.open(this.href,'_blank');return false;">
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
      <![CDATA[<!-- keine-suche-stop -->]]>
      </xsl:if>
    </xsl:if>

    <xsl:apply-templates select="/*/box/*"/>

  </div>

  <![CDATA[<!-- keine-suche-stop -->]]>

  <div id="body">
    <a id="top"/>

    <h1 style="margin-top: 0px" class="top">
      <span style="font-size: 0.8em">&gt;&gt; </span>
      <xsl:value-of select="title"/>
    </h1>

    <xsl:if test="count(chapter/title) &gt; 1">
      <![CDATA[<!-- keine-suche-start -->]]>
        <form style="font-size: 0.7em" action="http://www.gentoo.de/">
          <p><select name="url" size="1" class="jumpbox"
            onchange="location.hash=form.url.options[form.url.selectedIndex].value; form.url.value='---'">
            <option value="---">[Bitte Kapitel auswählen]</option>

            <xsl:for-each select="chapter/title">
              <option value="header_{position()}"><xsl:value-of select="."/></option>
            </xsl:for-each>
          </select></p>
        </form>
      <![CDATA[<!-- keine-suche-stop -->]]>
    </xsl:if>


    <xsl:apply-templates select="chapter"/>

    <br/><br/>
    <p>
      <a href="http://validator.w3.org/check/referer">
        <img src="{$imageurl}w3c/valid-html401.png" alt="Valid HTML 4.01!" height="31" width="88"/>
      </a>

      <!--
      <a href="http://validator.w3.org/check/referer">
        <img src="http://www.w3.org/Icons/valid-xhtml10.png" alt="Valid XHTML 1.0!" height="31" width="88"/>
      </a>
      -->
      <!--
      &#160;
      <a href="http://validator.w3.org/check/referer">
        <img src="http://www.w3.org/Icons/valid-css.png" alt="Valid CSS 2.0!" height="31" width="88"/>
      </a>
      -->
    </p>

  </div>

  <!--<script type="text/javascript" src="{$scripturl}corelib_start.js"></script>!-->

  </body>
  </html>
</xsl:template>

<xsl:template match="author">
  <xsl:choose>
    <xsl:when test="mail">
      <a href="mailto:KEINSPAM-{mail/@link}" title="{@title}">
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
  <xsl:variable name="cid"><xsl:number/></xsl:variable>

  <xsl:if test="title">
    <h1>
      <xsl:attribute name="id">
        <xsl:text>header_</xsl:text>
        <xsl:number/>
      </xsl:attribute>

      <xsl:if test="/guide">
        <span class="nr"><xsl:value-of select="$cid"/>.</span>
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
  <td class="head"><xsl:apply-templates/></td>
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
      <xsl:attribute name="target"><xsl:value-of select="@target"/></xsl:attribute>


    </xsl:if>
    <!-- XHTML erlaubt kein echtes Target mehr
    <xsl:if test="@target">
      <xsl:attribute name="onclick">
        <xsl:text>window.open(this.href,'_blank');return false;</xsl:text>
      </xsl:attribute>
    </xsl:if>
    -->
    <xsl:apply-templates/>
  </a>
</xsl:template>

<xsl:template match="mail">
  <a class="uri">
    <xsl:attribute name="href">
      <xsl:text>mailto:</xsl:text>
      <xsl:choose>
        <xsl:when test="@link">KEINSPAM-<xsl:value-of select="@link"/></xsl:when>
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

<xsl:template match="c">
  <span class="code"><xsl:apply-templates/></span>
</xsl:template>

<xsl:template match="b">
  <b><xsl:apply-templates/></b>
</xsl:template>

<xsl:template match="i|e">
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

<xsl:template match="news">
	<p style="background-color:#45347B; color:#FFFFFF; padding:3px; margin-bottom:0px">
		<span style="font-size:small;"><xsl:value-of select="@date"/></span><br/>
		<span style="font-weight:bold; font-size:large;"><xsl:value-of select="@title"/></span><br/>
	</p>
	<p style="font-size:medium; padding:3px; margin-top:0px">
		<table width="100%">
			<tr>
				<td valign="top">
					<img>
						<xsl:attribute name="src">
							http://www.gentoo.de/media/bilder/icons/news/<xsl:value-of select="@type"/>.jpg
						</xsl:attribute>
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

<xsl:template match="uriimg">
	<p style="text-align:center;">
		<xsl:attribute name="style">
			text-align:<xsl:value-of select="@align"/>
		</xsl:attribute>
	<a>
		<xsl:attribute name="href">
			<xsl:value-of select="@uri"/>
		</xsl:attribute>

		<xsl:attribute name="target">
			_blank
		</xsl:attribute>

		<img>
			<xsl:attribute name="src">
				<xsl:value-of select="@picuri"/>
			</xsl:attribute>
			<xsl:attribute name="alt">
				<xsl:value-of select="@uri"/>
			</xsl:attribute>
		</img>
	</a>
	</p>
</xsl:template>

<xsl:template match="figure">
  <xsl:variable name="fignum"><xsl:number level="any"/></xsl:variable>
  <xsl:variable name="figid">doc_fig<xsl:value-of select="$fignum"/></xsl:variable>
  <br/>
  <a name="{$figid}"/>
  <table cellspacing="0" cellpadding="0" border="0">
    <tr>
      <td class="head">
        <xsl:choose>
          <xsl:when test="@caption">
            Grafik <xsl:value-of select="$fignum"/>: <xsl:value-of select="@caption"/>
          </xsl:when>
          <xsl:otherwise>
            Grafik <xsl:value-of select="$fignum"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
    <tr>
      <td>
        <xsl:choose>
          <xsl:when test="@short">
            <img src="{@link}" alt="Grafik {$fignum}: {@short}"/>
          </xsl:when>
          <xsl:otherwise>
            <img src="{@link}" alt="Grafik {$fignum}"/>
          </xsl:otherwise>
        </xsl:choose>
      </td>
    </tr>
  </table>
  <br/>
</xsl:template>

</xsl:stylesheet>
