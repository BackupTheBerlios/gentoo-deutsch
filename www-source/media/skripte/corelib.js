/******************************************************************************

  The xKit [0.1.3 alpha]
  Name of Component "corelib.js"

  ===========================================================================

  Copyright, Sebastian Werner - Germany, 2002-2003
  http://www.sebastian-werner.net

  ===========================================================================

  Licensed under:
  GPL - The GNU General Public License    http://www.gnu.org/licenses/gpl.txt
  Permits anyone the right to use and modify the software without limitations
  as long as proper  credits are given  and the original  and modified source
  code are included. Requires  that the final product, software derivate from
  the original  source or any  software  utilizing a GPL  component, such  as
  this, is also licensed under the GPL license.

******************************************************************************/


// =================================
//  Helper functions
// =================================

function __getPageOffsetLeft(obj) {
  var x;
  
  x = obj.offsetLeft;
  if (obj.offsetParent != null)
    x += __getPageOffsetLeft(obj.offsetParent);

  return x;
}

function __getPageOffsetTop(obj) {
  var y;

  y = obj.offsetTop;
  if (obj.offsetParent != null)
    y += __getPageOffsetTop(obj.offsetParent);
  
  return y;
}


// =================================
//  Worker Functions
// =================================

function __x_show()
{
  this.style.visibility = "visible"
}

function __x_hide()
{
  this.style.visibility = "hidden"
}

function __x_checkClass(name)
{
  var list = this.obj.className.split(" ");
  
  for (var i = 0; i < list.length; i++)
    if (list[i] == name)
      return true;

  return false;
}

function __x_addClass(name)
{
  // Bereitet Probleme mit Konq in KDE 3.1 (SW, 18.12.2002)
  // und Opera 7...
  // dort wird solange bis eine andere Loesung gefunden wird
  // der ganze ClassString... also alle anderen definierten Klassen
  // ueberschrieben

  if (browser.op || browser.kq)
  {
    this.obj.className=name
  }
  else
  {
    var list = this.obj.className.split(" ");

    if (list.length == 0)
      this.obj.className=name
    else
      this.obj.className=this.obj.className+" "+name
  }
}

function __x_removeClass(name)
{
  if (this.obj.className == null) return;

  var newList = new Array();
  var curList = this.obj.className.split(" ");
  
  for (var i = 0; i < curList.length; i++)
    if (curList[i] != name)
      newList.push(curList[i]);

  this.obj.className = newList.join(" ");
}

function __x_getChilds(name)
{
  if (name == undefined)
  {
    return this.obj.childNodes
  }  
  else  
  {
    return this.obj.getElementsByTagName(name)
  }  
}

function __x_getX()
{
  return __getPageOffsetLeft(this.obj);
}

function __x_getY()
{
  return __getPageOffsetTop(this.obj);
}

function __x_getFullWidth()
{
  return this.obj.offsetWidth;
}

function __x_getFullHeight()
{
  return this.obj.offsetHeight;
}

function __x_getWidth()
{
  return this.style.width;
}

function __x_getHeight()
{
  return this.style.height;
}

function __x_setWidth(value)
{
  if (browser.op && !browser.op7) 
    return this.style.width=parseInt(value)
  else 
    return this.style.width=parseInt(value)+"px"
}

function __x_setHeight(value)
{
  if (browser.op && !browser.op7) 
    return this.style.height = parseInt(value)
  else
    return this.style.height = parseInt(value)+"px"
}

function __x_getChilds(name)
{
  if (name == undefined)
  {
    return this.obj.childNodes
  }  
  else  
  {
    return this.obj.getElementsByTagName(name)
  }  
}

function __x_checkAvailability(name)
{
  return document.getElementById(name)
}

function __x_addEvent(name, value)
{
  this.obj.setAttribute("on" + name, value)
}

// =================================
//  Object definition
// =================================

// ---------------------------------
// DEBUG
// ---------------------------------
function x_debug(active)
{
  this.active = active
  
  if (this.active) this.open();

  return true;
}

x_debug.prototype.open = function()
{
  this.win = window.open("", "debugwin", "height=400,width=400,scrollbars=yes,menubar=yes")
  this.print("<style type='text/css'>body{font-size: 0.8em;}</style>")
}

x_debug.prototype.print = function(value)
{
  if (this.active) this.win.document.write(value)
}

x_debug.prototype.header = function(value)
{
  if (this.active) this.print("<h3>" + value + "</h3>")
}

x_debug.prototype.msg = function(value)
{
  if (this.active) this.print("<li>" + value + "</li>")
}

x_debug.prototype.start = function()
{
  if (this.active) this.print("<ul>")
}

x_debug.prototype.stop = function()
{
  if (this.active) this.print("</ul>")
}

x_debug.prototype.enable = function()
{
  this.active=true;
  if (!this.win) this.open();
}

x_debug.prototype.disable = function()
{
  this.active=false;
}


// ---------------------------------
// BROWSER
// ---------------------------------

function x_browser()
{
  var c = this.check;

  this.all = document.all ? true : false;
  this.dom = document.getElementById ? true : false;
  this.domfull = this.dom && document.createTextNode && document.firstChild && document.getElementsByTagName && document.createElement ? true : false;
  this.layers = document.layers ? true : false;

  this.win = c("windows");
  this.win2k = this.win && c("windows 2000");
  this.unix = !this.win && (c("unix") || c("linux") || c("x11"));
  this.mac = !this.win && !this.unix && (c("apple") || c("mac"));

  this.op = c("opera");
  this.kq = c("konqueror") && this.unix;
  this.gk = this.dom && !this.op && !this.kq && !this.all;
  this.ie = this.all && this.dom && !this.op && !this.kq;

  this.op7 = this.op && c("opera 7.");
  this.op6 = this.op && !this.op7 && c("opera 6.");
  this.op5 = this.op && !this.op7 && !this.op6 && c("opera 5.");

  this.ie6 = this.ie && c("msie 6.");
  this.ie55 = this.ie && !this.ie6 && c("msie 5.5");
  this.ie5 = this.ie && !this.ie6 && !this.ie55 && c("msie 5.0");

  debug.msg("Features: all: " + this.all + "; dom: " + this.dom + "; domfull: " + this.domfull + "; layers: " + this.layers)
  
  debug.msg("Browser-String: " + this.nav)

  debug.msg("Betriebssystem Windows: " + this.win)
  debug.msg("Betriebssystem Linux/Unix/BSD: " + this.unix)
  debug.msg("Betriebssystem Apple/Mac: " + this.mac)

  debug.msg("Opera: " + this.op)
  debug.msg("Opera 7: " + this.op7)
  debug.msg("Opera 6: " + this.op6)
  debug.msg("Opera 5: " + this.op5)

  debug.msg("Internet Explorer: " + this.ie)
  debug.msg("Internet Explorer 6: " + this.ie6)
  debug.msg("Internet Explorer 5.5: " + this.ie55)
  debug.msg("Internet Explorer 5: " + this.ie5)

  debug.msg("Mozilla: " + this.gk)
  debug.msg("Konqueror: " + this.kq)
}

x_browser.prototype.check = function(string)
{
  this.nav = navigator.userAgent.toLowerCase()
  var i = this.nav.indexOf(string) != -1 ? true : false;
  return i;
}


// ---------------------------------
// OBJECT
// ---------------------------------

function x_object(name)
{
  this.name = name;
  
  debug.msg("Initialisiere xObject: " + this.name);
  
  this.obj = document.getElementById(name);
  this.style = this.obj.style;

  // map common functions
  this.hide = __x_hide
  this.show = __x_show
  
  this.getChilds = __x_getChilds
  
  this.checkClass = __x_checkClass
  this.removeClass = __x_removeClass
  
  this.addClass = __x_addClass  
  this.addEvent = __x_addEvent  
  
  this.getFullWidth = __x_getFullWidth
  this.getFullHeight = __x_getFullHeight
  this.getX = __x_getX
  this.getY = __x_getY
  
  this.setWidth = __x_setWidth
  this.setHeight = __x_setHeight

  // return
  return true;  
}


// ---------------------------------
// LAYER
// ---------------------------------

function x_layer(name)
{
  this.name = name;
  
  debug.msg("Initialisiere xLayer: " + this.name);    
    
  this.obj = document.getElementById(name);
  this.style = this.obj.style;
  
  // map common functions
  this.hide = __x_hide
  this.show = __x_show
  
  this.getChilds = __x_getChilds  
  
  this.addClass = __x_addClass
  this.addEvent = __x_addEvent
  
  this.getFullWidth = __x_getFullWidth
  this.getFullHeight = __x_getFullHeight
  this.getX = __x_getX
  this.getY = __x_getY


  // return  
  return true;  
}

x_layer.prototype.position = function(value)
{
  if (value == "absolute" || value == "relative" || value == "fixed")
  {
    this.style.position=value
    return true;
  }

  return false;
}

x_layer.prototype.setX = function(value)
{
  this.style.left = parseInt(value) + "px"
  return true;
}

x_layer.prototype.setY = function(value)
{
  this.style.top = parseInt(value) + "px"
  return true;
}

// Move one xlayer object to another xlayer or xobject object
x_layer.prototype.placeToX = function(oobj, value, diffX)
{
  var moverX;

  if (typeof(oobj) == "string")
    var other=eval(oobj);
  else if (typeof(oobj) == "object")
    var other=oobj;
  else
    return false;

  if (value == "outleft")
    moverX=this.getFullWidth() * (-1)
  else if (value == "inleft")
    moverX=0;
  else if (value == "middle")
    moverX=(other.getFullWidth()/2)-(this.getFullWidth()/2)
  else if (value == "inright")
    moverX=other.getFullWidth()-this.getFullWidth()
  else if (value == "outright")
    moverX=other.getFullWidth()
  else
    return false;

  return this.setX(other.getX()+moverX+diffX);
}


// Move one xlayer object to another xlayer or xobject object
x_layer.prototype.placeToY = function(oobj, value, diffY)
{
  var moverY;

  if (typeof(oobj) == "string")
    var other=eval(oobj);
  else if (typeof(oobj) == "object")
    var other=oobj;
  else
    return false;

  if (value == "above")
    moverY=this.getFullHeight() * (-1)
  else if (value == "top")
    moverY=0;
  else if (value == "middle")
    moverY=(other.getFullHeight()/2)-(this.getFullHeight()/2)
  else if (value == "bottom")
    moverY=other.getFullHeight()-this.getFullHeight()
  else if (value == "under")
    moverY=other.getFullHeight()
  else
    return false;

  return this.setY(other.getY()+moverY+diffY);
}

// ---------------------------------
//  CONFIG
// ---------------------------------

function x_config()
{
  this.configcache = new Array();
}

x_config.prototype.store = function(key, value)
{
  var pos=this.find(key)
  if (pos == -1)
  {
    pos = this.configcache.length;
    this.configcache[pos] = new Array();
    this.configcache[pos][0] = key;
  }

  this.configcache[pos][1] = value;
}

x_config.prototype.find = function(key)
{
  for (var i=0; i<this.configcache.length; i++)
    if (this.configcache[i][0] == key) return i;

  return -1;
}

x_config.prototype.get = function(key)
{
  var pos=this.find(key)

  if (pos == -1) return false;
  else return this.configcache[pos][1];
}

// ---------------------------------
//  ACTION
// ---------------------------------

function x_action()
{
  this.actioncache = new Array();
}

x_action.prototype.registerEvent = function(aname, atype, acmd)
{
  var tmp_pos = actioncache.length;
  var aobj = document.getElementById(aname);

  debug.msg("Registriere Event Nr. " + tmp_pos + " fuer: " + aname)

  // Daten speichern
  this.actioncache[tmp_pos] = new Array()
  this.actioncache[tmp_pos][0] = aname;
  this.actioncache[tmp_pos][1] = atype;
  this.actioncache[tmp_pos][2] = acmd;

  // Diese Typen werden beobachtet:
  aobj.onmousemove = this.doEvent;
  aobj.onmouseover = this.doEvent;
  aobj.onclick = this.doEvent;

  return tmp_pos;
}

x_action.prototype.doEvent = function(event)
{
  var ncurrent, nrelated, ntarget, ntype, nname;

  // Internet Explorer
  if (window.event)
  {
    ncurrent = this;
    nrelated = window.event.toElement;
    ntarget = window.event.srcElement;
    nname = ntarget.id;
    ntype = window.event.type;
  }
  // W3C DOM
  else
  {
    ncurrent = event.currentTarget;
    nrelated = event.relatedTarget;
    ntarget = event.target;
    nname = ntarget.id;
    ntype = event.type;

    if (ntarget.nodeName == "#text")
      ntarget=ntarget.parentNode
  }

  // Target benötigt eine ID
  if (ntarget && ntarget.id && ntarget.id != "")
    for (var i=0; i<this.actioncache.length; i++)
      if (this.actioncache[i][0]== nname && this.actioncache[i][1] == ntype)
        eval (this.actioncache[i][2])
}


// ---------------------------------
//  MENU
// ---------------------------------

function x_menu(name_layer, name_link)
{
  // copy settings
  this.name_layer = name_layer
  this.name_link = name_link

  // map core functions
  this.checkAvailability = __x_checkAvailability

  debug.msg("Initialisiere xMenu: " + this.name_layer)

  this.menucache = new Array();
  this.linkcache = new Array();

  // call recurser
  this.recurser(this.name_layer)
  

  // return
  return true;
}


x_menu.prototype.recurser = function(parent_link)
{
  debug.start()

  if (typeof(parent_link) == "string")
  {
    this.recurser_level = 0;
    this.position = -1;

    var menucache_pos = 0;
    this.menucache[menucache_pos] = new x_layer(this.name_layer);
    this.menucache[menucache_pos].parent = false;
    this.menucache[menucache_pos].first = true;
  } else {
    this.recurser_level++;

    var menucache_pos = parent_link.childCachePos;
    this.menucache[menucache_pos] = new x_layer(this.link2layer(parent_link.name));
    this.menucache[menucache_pos].parent = parent_link;
    this.menucache[menucache_pos].first = false;
  }


  // Evtl. fehlende Klasse zuweisen (geht sicher auch noch schönes über x_config)
  /*
  if (this.recurser_level > 0)
    this.menucache[menucache_pos].addClass(config.get("x_menu/class/submenu"))
  */

  // Alle Links innerhalb des Layers cachen
  var childLinks = this.menucache[menucache_pos].getChilds("a")
  var linkcache_pos_diff = this.linkcache.length;


  // Daten für folgende Elemente cachen
  for (var i=0; i<childLinks.length; i++)
  {
    var linkcache_pos = linkcache_pos_diff + i;

    this.linkcache[linkcache_pos] = new x_object(childLinks[i].getAttribute("id"));
    this.linkcache[linkcache_pos].parent = this.menucache[menucache_pos]
    this.linkcache[linkcache_pos].level = this.menucache[menucache_pos].level;
    this.linkcache[linkcache_pos].hasChild = this.checkAvailability(this.link2layer(this.linkcache[linkcache_pos].name)) ? true : false;
  }
  

  // Pfeile für Submenues anhängen

  for (var i=0; i<childLinks.length; i++)
  {
    var linkcache_pos = linkcache_pos_diff + i;

    if (this.recurser_level > 0)
    {
      if (this.linkcache[linkcache_pos].hasChild && browser.domfull)
      {
        // Submenü-Elemente mit Untermenüs erhalten einen Pfeil
        this.linkcache[linkcache_pos].obj.appendChild(document.createElement("span"))
        this.linkcache[linkcache_pos].obj.appendChild(document.createElement("span"))

        var obj_text = this.linkcache[linkcache_pos].obj.getElementsByTagName("span")[0]
        var obj_arrow = this.linkcache[linkcache_pos].obj.getElementsByTagName("span")[1]

        // Auffuellen mit leerer zeichenkette
        obj_text.appendChild(document.createTextNode(""));
        obj_arrow.appendChild(document.createTextNode(""));

        // Text verschieben in span-Tag
        obj_text.firstChild.nodeValue=this.linkcache[linkcache_pos].obj.firstChild.nodeValue;
        this.linkcache[linkcache_pos].obj.firstChild.nodeValue="";

        if (browser.ie || browser.kq || (browser.op7 && browser.win))
        {
          // Wenn die Webdings Schriftart verfügbar, dann ist der Pfeil
          // aus diesem Schriftsatz noch schicker als der Unicode-Pfeil
          // Nebenbei erwähnt beherrscht der IE nicht den Pfeil als Unicode.
          
          // Bei Opera 7 (Beta2) sieht dies hier auch falsch aus aber immer noch
          // besser als untere Variante... :)
          obj_arrow.style.fontFamily = "Webdings";
          obj_arrow.firstChild.nodeValue = "4";
          obj_arrow.style.lineHeight = "2.5ex";
        } else {
          // der Unicode-Pfeil: &#9654; als UTF-8
          // obj_arrow.firstChild.nodeValue = "â–¶";
	  obj_arrow.firstChild.nodeValue = String.fromCharCode(9654);
        }
      }
      else if (browser.ie)
      {
      	// Rechten Abstand etwas hübscher machen :)
        this.linkcache[linkcache_pos].obj.style.paddingRight="1.3em"
      }
    }
  }

  var maxScaleToWidth = 0

  // Maximale Breite ermitteln
  for (var i=0; i<childLinks.length; i++)
  {
    var borderWidth = 1; // ugly hack
    var scaleToWidth = this.linkcache[linkcache_pos].parent.getFullWidth() - (2 * borderWidth)
    if (scaleToWidth > maxScaleToWidth) maxScaleToWidth=scaleToWidth;
  }

  // Pfeile nach rechts schieben
  for (var i=0; i<childLinks.length; i++)
  {
    var linkcache_pos = linkcache_pos_diff + i;

    if (this.recurser_level > 0)
    {
      this.linkcache[linkcache_pos].setWidth(maxScaleToWidth)

      if (this.linkcache[linkcache_pos].hasChild && browser.domfull)
      {
        var obj_text = this.linkcache[linkcache_pos].obj.getElementsByTagName("span")[0]
        var obj_arrow = this.linkcache[linkcache_pos].obj.getElementsByTagName("span")[1]

        obj_text.style.paddingRight=(maxScaleToWidth-(obj_text.offsetWidth + obj_arrow.offsetWidth)) + "px"
      }
    }
  }

  // Breite der Menüs in Opera 7 fixen
  if (browser.op7 && this.recurser_level > 0) 
    this.linkcache[linkcache_pos].parent.style.width = childLinks[0].offsetWidth + "px";

  // Je nach Level die Objekt positionieren
  var dfh=0; var dfv=0; var dnh=0; var dnv=0;

  // Unterschiede in den Browsern korrigieren
  if (browser.ie) dfv=-1;
  if (browser.op7) dfv=-2;
  if (browser.op6) { dfv=-1; dnh=-1; }

  if (this.recurser_level < 2)
  {
    this.menucache[menucache_pos].placeToX(this.menucache[menucache_pos].parent, "inleft", (config.get("x_menu/border/width/first_horiz") + dfh))
    this.menucache[menucache_pos].placeToY(this.menucache[menucache_pos].parent, "under", (config.get("x_menu/border/width/first_verti") + dfv))
  } else {
    this.menucache[menucache_pos].placeToX(this.menucache[menucache_pos].parent, "outright", (config.get("x_menu/border/width/next_horiz") + dnh))
    this.menucache[menucache_pos].placeToY(this.menucache[menucache_pos].parent, "top", (config.get("x_menu/border/width/next_verti") + dnv))
  }

  // Links durchsuchen und evtl. weiterer Recurser-Aufruf
  for (var i=0; i<childLinks.length; i++)
  {
    var linkcache_pos = linkcache_pos_diff + i;

    if (this.linkcache[linkcache_pos].hasChild)
    {
      this.linkcache[linkcache_pos].childCachePos=this.menucache.length;
      this.recurser(this.linkcache[linkcache_pos])
    }
  }

  this.recurser_level--
  debug.stop();
}


x_menu.prototype.handle = function(name)
{
  this.gotoEntry(this.findLayer(this.link2layer(name)))
}

x_menu.prototype.getLevel = function(id)
{
  return id.substr(id.indexOf("_") + 1, id.length)
}

x_menu.prototype.link2layer = function(name)
{
  return this.name_layer + "_" + this.getLevel(name)
}

x_menu.prototype.layer2link = function(name)
{
  return this.name_link + "_" + this.getLevel(name)
}

x_menu.prototype.hideAll = function()
{
  // erstes immer behalten ;-)
  for (var i=1; i<this.menucache.length; i++)
    if (this.menucache[i].active == true)
    {
      this.menucache[i].hide();
      this.menucache[i].active=false;
    }
}

x_menu.prototype.setAllToDefault = function()
{
  for (var i=0; i<this.linkcache.length; i++)
    if (this.linkcache[i].active == true)
    {
      this.linkcache[i].removeClass("marker");
      this.linkcache[i].active=false;
    }
}

x_menu.prototype.closeAll = function() 
{
  if (this.position == -1) 
  { 
    debug.msg("Menue ist zu!!!");
    return false;
  }

  debug.msg("Menue wird geschlossen");
  this.position = -1;

  this.hideAll()
  this.setAllToDefault()
}

x_menu.prototype.gotoEntry = function(tmp_menupos)
{
  // Wenn wir schon dort sind... Aktion abbrechen
  if (this.position == tmp_menupos) return false;

  debug.msg("Zeige Layer " + tmp_menupos + " und seine Eltern")

  // Erst mal alle bisherigen schliessen
  this.closeAll()

  // Aktuelles Menueposition speichern
  this.position=tmp_menupos
  
  
  var current_obj;
  var current_name = "";
  var posstring = "this.menucache[" + tmp_menupos + "]";

  while (current_name != this.name_layer)
  {
    current_obj = eval(posstring);
    current_name = current_obj.name;

    // Auf aktiv setzen
    current_obj.active=true;
        
    // Wenn ein Menü dann dieses anzeigen,
    // ansonsten ist es ein Link, dieser wird dann markiert
    if (current_obj.name.indexOf(this.name_layer) == 0)
      current_obj.show();
    else
      current_obj.addClass("marker");
    
    posstring = posstring + ".parent"
  }
}


x_menu.prototype.findLayer = function(name)
{
  for (var i=0; i<this.menucache.length; i++)
    if (this.menucache[i].name == name)
      return i; 

  return -1;
}


