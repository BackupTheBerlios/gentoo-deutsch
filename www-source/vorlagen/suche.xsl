<?xml version="1.0" encoding="iso-8859-15"?>
<xsl:stylesheet version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:cgi="http://www.sebastian-werner.net">

<xsl:output method="html" encoding="iso-8859-15" indent="no"/>

<xsl:template match="cgi:result_list">
  <table cellpadding="0" cellspacing="0" class="resultlist" width="100%">
    <![CDATA[<!--loop: results-->]]>

      <tr>
        <td class="title" colspan="2">
          <![CDATA[<!--item: rank-->]]>
          <xsl:text>. </xsl:text> 
          <![CDATA[<a href="<!--item: url-->"><!--item: title--></a>]]>
        </td> 
      </tr>
      
      <tr>
        <td class="description" style="width: 65%">
          <![CDATA[<!--item: description-->]]>
        </td>
        <td class="details">
          <p>
            Relevanz:
            <![CDATA[<!--item: score-->]]> &#160;
          </p>
          <p> 
            Datum:
            <![CDATA[<!--item: date-->]]> &#160;
          </p>
          <p>
            Größe:
            <![CDATA[<!--item: size-->]]> kB
          </p>         
        </td>        
      </tr>
    
      <tr>
        <td colspan="2">&#160;</td>
      </tr>    
 
  
    <![CDATA[<!--end: results-->]]>
  </table>

</xsl:template>


<xsl:template match="cgi:result_navigation">
  <div style="text-align: center">
    <![CDATA[<!--cgi: previous--> [ <!--cgi: navbar--> ] <!--cgi: next-->]]>
    <br/>
    <br/>  
  </div>  
</xsl:template>

<xsl:template match="cgi:result_newsearch">  
  <div style="text-align: center">
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
  </div>
</xsl:template>

<xsl:template match="cgi:search_form">
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

<xsl:template match="cgi:*">
  <![CDATA[<!--]]><xsl:value-of select="name()"/><![CDATA[-->]]>

  <!--
    query_str 		= Suchstring
    baseurl 		= Durchsuchte URL
    first_number	= Beginn Ergebnis-Liste
    last_number		= Ende Ergebnis-Liste
    results_num		= Anzahl der Ergebnisse
    docs_total		= Anzahl indizierter Dokumente
    search_time		= Dauer der Suche
    ignored_terms	= Ignorierte Wörter
  -->
</xsl:template>


</xsl:stylesheet>
