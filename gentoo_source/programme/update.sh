#!/bin/bash

## Gentoo WebPublisher v1.2
## By Sebastian Werner (sebastian@werner-productions.de)
## Copyright 2002 Sebastian Werner, Licensed under GPL v2

##
## Defaults
###########################################################

xsl_app="xsltproc"
src_templates="vorlagen"
def_temp="temp"
def_cache="cache"
def_conf="konfiguration"
def_rsync="rsync2.de.gentoo.org"
startdir="/home/groups/gentoo-deutsch/htdocs/gentoo_source"

##
## Functions
###########################################################

function o_job() {
  echo ">>> $*..."
}

function o_jobn() {
  echo -n ">>> $*..."
}

function o_sub() {
  echo -n "    * $*"
}

function o_err() {
  echo " -> ! $*"
}

function o_follow() {
  echo -n " -> $*"
}

function o_finish() {
  echo
}

function x_md5() {
  md5sum ${1} | cut -d" " -f1
}

function x_proc() {
  ${xsl_app} --param var_url "'/$4/'" --param var_title "'$5'" ${1} ${2} > ${3} 2> ${2}.err  
  if [ $? = 0 ]; then
    rm -f ${2}.err
    o_follow "ok"
    o_finish
  else
    o_err "Meldungen in `basename $2.err`"
  fi  
}


function x_doc() {
  name="$1"
  title="$2"
  input="${def_source}/${src_data}/${name}.xml"
  checkfile="${input}.md5"
  output="${def_public}/${pub_content}/${name}/${www_basename}.${www_extension}"
  transformer="${def_source}/${src_templates}/content.xsl"
  
  o_sub "$title [${name}]"
  
  if [ ! -r $input ]; then
    o_follow "datei nicht lesbar"
    o_finish 
    return
  fi
    
  md5=`x_md5 $input`
  
  if [ -r $checkfile ]; then
    md5_old=`cat $checkfile`
  fi  
  
  if [ "$md5" != "$md5_old" -o "$ctl_force" = "true" ]; then
    echo $md5 > $checkfile
  else
    o_follow "unverändert"
    o_finish
    return
  fi  

  outputdir=`dirname $output`
  if [ ! -d $outputdir ]; then
    mkdir -p $outputdir
  fi    
    
  x_proc $transformer $input $output "$url" "$title"
}

function x_xmlhead() {
  echo "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>"
}

function x_portentry2flatxml() {
  file="$1"

  cat=`echo $file | cut -d"/" -f1`
  pkg=`echo $file | cut -d"/" -f2`
  version=`echo $file | cut -d"/" -f3 | sed s:${pkg}-::g | sed s:.ebuild::g`
  
  rsync -a rsync://${def_rsync}/gentoo-portage/${cat}/${pkg} ${def_temp}
  description=`cat ${def_temp}/${pkg}/${pkg}-${version}.ebuild | grep DESCRIPTION | cut -d"=" -f2 | sed s:\"::g`
  
  echo "<entry cat=\"$cat\" pkg=\"$pkg\" version=\"$version\" description=\"$description\"/>"
}

function x_portagediff() {
  o_sub "Ermittle aktuellen Inhalt des Portage-Baumes... "
  rsync -na rsync://${def_rsync}/gentoo-portage/ . > $def_temp/list.txt
  if [ $? != 0 ]; then
    o_err "fehler"; return 1
  fi  
  o_follow "ok"
  o_finish

  o_sub "Vergleiche aktuelle mit gespeicherten Daten"
  diff $def_cache/ebuild_new_org.txt $def_temp/list.txt > $def_temp/diff.txt
  mv $def_temp/list.txt $def_cache/ebuild_new_org.txt
  if [ $? != 0 ]; then
    o_err "fehler"; return 1
  fi  
  o_follow "ok"
  o_finish
  
  o_sub "Konvertiere Vergleichsdaten in flaches XML "
  o_finish

  x_xmlhead > $def_cache/ebuild_new_org.xml
  echo "<ebuilds name=\"new_org\">" >> $def_cache/ebuild_new_org.xml
  i=0
  for file in `cat $def_temp/diff.txt | grep "^> " | grep ".ebuild" | cut -d" " -f2`; do
    i=$[$i+1] 
    echo "      - downloaden und parsen: $i ($file)"
    x_portentry2flatxml $file >> $def_cache/ebuild_new_org.xml
  done
  
  echo "</ebuilds>" >> $def_cache/ebuild_new_org.xml
}

function x_xmlpkglist() {
  for dir in `find ${1} -type d -mindepth 1 -maxdepth 1 -name "*-*"`; do
  
  shortdir=`basename $dir`
  echo "<cat name=\"$shortdir\">"
  lastname="empty"
  for file in `find $dir ${2} ! -type d -name "*.ebuild" -mindepth 2 | sort`; do
    dir=`dirname $file | sed s:${1}/::g`
    pkgname=`echo $dir | cut -d"/" -f2`
    base=`basename $file`
    pkgversion=`echo $base | sed s:${pkgname}-::g | sed s:.ebuild::g`
    pkgdescription=`cat $file | grep DESCRIPTION | cut -d"=" -f2 | sed s:\"::g`

    if [ "$pkgname" = "$lastname" ]; then        
      echo "  <pkgversion>$pkgversion</pkgversion>"    
    else
      if [ "$lastname" != "empty" ]; then
        echo "</pkg>"
      fi	
      echo "<pkg>"
      echo "  <pkgdescription><![CDATA[$pkgdescription]]></pkgdescription>"
      echo "  <pkgname>$pkgname</pkgname>"
      echo "  <pkgversion>$pkgversion</pkgversion>"
    fi 
  
    lastname="$pkgname"
  done
  if [ "$lastname" != "empty" ]; then
    echo "</pkg>"
  fi  
  echo "</cat>"
  
  done
}

function x_xslpkglist() {
  listname="$1"
  directory="$2"
  options="$3"

  o_sub Generiere Informationsdatei
  o_finish
  
  (
  x_xmlhead
  echo "<pkglist name=\"${listname}\">"
  x_xmlpkglist "${directory}" "${options}"
  echo "</pkglist>"
  ) > ${def_temp}/ebuild_${listname}.xml

  o_sub Erstelle einbettbares Dokument
  x_proc ${def_source}/${src_templates}/ebuild.xsl ${def_temp}/ebuild_${listname}.xml ${def_temp}/ebuild_${listname}.xsl
}

function x_xslchpkglist() {
  listname="$1"
  
  o_sub "Erstelle einbettbares Dokument"
  x_proc ${def_source}/${src_templates}/ebuild.xsl ${def_temp}/ebuild_${listname}.xml ${def_temp}/ebuild_${listname}.xsl
}



##
## Config
###########################################################

cd $startdir

for i in $*; do 
  case $i in
    "--force") 
      o_job "Übersetze alle Dateien neu"
      ctl_force="true";;
    "--portindex")
      o_job "Ermittle Änderungen im Portage-Baum"
      ctl_portindex="true";; 
    "--synccvs")
      o_job "Downloaden des aktuellen CVS-Standes"
      ctl_synccvs="true";;
  esac
done

o_job Erstelle Verzeichnisse
mkdir -p $def_temp
mkdir -p $def_cache

o_job Vorbereiten der Konfiguration
o_sub 1/4
x_proc ${src_templates}/cf_config2xsl.xsl ${def_conf}/index.xml ${def_temp}/config.xsl
o_sub 2/4
x_proc ${src_templates}/cf_xsl2bash.xsl ${def_temp}/config.xsl ${def_temp}/config.sh
o_sub 3/4
x_proc ${src_templates}/cf_config2proc.xsl ${def_conf}/index.xml ${def_temp}/proc.sh
o_sub 4/4
x_proc ${src_templates}/cf_xsl2bash.xsl ${def_temp}/config.xsl ${def_temp}/env.sh

o_job Laden der Konfiguration
source ${def_temp}/env.sh

##
## Portage-List
###########################################################

o_job "Erstelle Ebuild-Liste ORG"

if [ "$ctl_portindex" = "true" ]; then
  x_portagediff
fi
  
o_sub "Erstelle strukturierte Informationsdatei"
x_proc ${src_templates}/cf_flatxml2xml.xsl ${def_cache}/ebuild_new_org.xml ${def_temp}/ebuild_new_org.xml
  
x_xslchpkglist "new_org"

  
##                                                                                                         
## Ebuilds-DE
###########################################################   

if [ "$ctl_synccvs" = "true" ]; then
  test -d ${startdir}/cache/all-de || mkdir -p ${startdir}/cache/all-de
  cd ${startdir}/cache/all-de


  o_job "Syncronisiere Ebuild-Liste DE mit CVS"
  
  for module in ebuilds sonstiges; do
    o_sub "module: $module"
    cvs -z3 -d:pserver:anonymous@cvs.gentoo-deutsch.berlios.de:/cvsroot/gentoo-deutsch co $module > ${startdir}/temp/cvslog_${module}.txt 2>&1
    o_finish 
  done

  cd $startdir

fi

o_job "Erstelle Ebuild-Liste DE"
x_xslpkglist "all_de" "${def_source}/cache/all-de/ebuilds"

    
##                                                                                                         
## Startseite
###########################################################   

o_jobn "Erstelle Startseite"
x_proc \
  ${def_source}/${src_templates}/content.xsl \
  ${def_source}/${src_data}/index.xml \
  ${def_public}/${pub_content}/${www_basename}.${www_extension} \
  "" "Startseite"
  
  
o_jobn "Erstelle Ergebnis-Seite für Suche"
x_proc \
  ${def_source}/${src_templates}/content.xsl \
  ${def_source}/${src_data}/finden_ergebnis.xml \
  /home/groups/gentoo-deutsch/cgi-bin/perlfect/search/templates/search_de.html \
  "" "Ihr Suchergebnis"
    
o_jobn "Erstelle Kein-Ergebnis-Seite für Suche"
x_proc \
  ${def_source}/${src_templates}/content.xsl \
  ${def_source}/${src_data}/finden_leer.xml \
  /home/groups/gentoo-deutsch/cgi-bin/perlfect/search/templates/no_match_de.html \
  "" "Ihr Suchergebnis"


##
## Main
###########################################################

o_job Starte das Übersetzen der Daten
source ${def_temp}/proc.sh


##
## Cleanup
###########################################################

o_job Räume auf
#rm -rf $def_temp


##
## Finish
###########################################################

o_job "Fertig"

