<?xml version="1.0" encoding="iso-8859-15"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" encoding="iso-8859-15" indent="no"/>

<xsl:template match="search">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="result_intro">
  <xsl:apply-templates/> 
  <![CDATA['<!--cgi: query_str-->']]>
</xsl:template>

<xsl:template match="result_overview">  
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
    <![CDATA[
    <td valign="top"><!--cgi: baseurl--> wurde nach <strong><!--cgi: query_str--></strong> durchsucht</td>
    <td align="right">Treffer
    <strong><!--cgi: first_number--> - <!--cgi: last_number--></strong> von <strong><!--cgi: results_num--></strong>,
    insgesamt <!--cgi: docs_total--> Dokumente durchsucht <!--cgi: search_time--></td>
    ]]>
  </tr>
  </table>
</xsl:template>

<xsl:template match="result_ignored_terms">
  <![CDATA[
  <!--cgi: ignored_terms-->
  ]]>
</xsl:template>  

<xsl:template match="result_list">
  <dl>
    <![CDATA[<!--loop: results-->]]>
    <dt>
      <![CDATA[<!--item: rank-->]]>. 
      <![CDATA[<a href="<!--item: url-->"><!--item: title--></a>]]>
      <br/>
      <![CDATA[<!--item: description-->]]>
      <br />
      <strong>URL:</strong> 
      <![CDATA[<!--item: visibleurl--> ]]>
      &#160;
      
      <strong>Relevanz:</strong> 
      <![CDATA[<!--item: score-->]]> &#160;
      <strong>Datum:</strong> 
      <![CDATA[<!--item: date-->]]> &#160;
      <strong>Größe:</strong> 
      <![CDATA[<!--item: size-->]]> kB
      
      <br/>
      <br/>
    </dt>
    <![CDATA[<!--end: results-->]]>
  </dl>
</xsl:template>

<xsl:template match="result_noentry">
<p>Tipps, um das Ergebnis der Suche zu verbessern:</p>
<ul>
	<li>"Mindestens ein Wort finden" auswählen</li>
	<li>Auf die korrekte Schreibweise der Wörter achten</li>
	<li>Mit 
	<![CDATA[
	<a href="http://www.google.com/search?num=10&amp;query=<!--cgi: query_str_escaped-->">Google</a>
	nach '<!--cgi: query_str-->' suchen
	]]>
	</li>
</ul>
</xsl:template>
  
<xsl:template match="result_navigation">  
  <center>
    <![CDATA[<!--cgi: previous--> [ <!--cgi: navbar--> ] <!--cgi: next-->]]>
    <br/><br/>
    <![CDATA[
    <form action="<!--cgi: search_url-->" method="get">
      <xsl:if test="retry">
        <input type="hidden" name="p" value="1" />
        <input type="hidden" name="lang" value="<!--cgi: lang-->" />
        <input type="hidden" name="include" value="<!--cgi: include-->" />
        <input type="hidden" name="exclude" value="<!--cgi: exclude-->" />
        <input type="hidden" name="penalty" value="<!--cgi: penalty-->" />
        Neue Suche: 
        <select name="mode">
          <option value="all"<!--cgi: match_all-->>Alle W&ouml;rtern finden</option>
          <option value="any"<!--cgi: match_any-->>Mindestens ein Wort finden</option>
        </select>
      
        <input type="text" name="q" value="<!--cgi: query_str-->" />
      
        <input type="submit" value="Suchen" />
      <br/>      
      <br/>
      </xsl:if>

      Mit <a href="http://www.google.com/search?num=10&amp;query=<!--cgi: query_str_escaped-->">Google</a>
      nach '<!--cgi: query_str-->' suchen
    </form>
    ]]>
  </center>
  
  Seite <![CDATA[<!--cgi: current_page-->]]> von <![CDATA[<!--cgi: total_pages-->]]>
</xsl:template>

<xsl:template match="search_form">
  <form method="get" action="/cgi-bin/perlfect/search/search.pl">
    <input type="hidden" name="p" value="1"/>
    <input type="hidden" name="lang" value="de"/>
    <input type="hidden" name="include" value=""/>
    <input type="hidden" name="exclude" value=""/>
    <input type="hidden" name="penalty" value="0"/>
    <select name="mode">
      <option value="all">Alle Wörter finden</option>
      <option value="any">Eines der Wörter finden</option>
    </select>
    <input type="text" name="q" value=""/>
    <input type="submit" value="Suchen"/>
  </form>
</xsl:template>

</xsl:stylesheet>
