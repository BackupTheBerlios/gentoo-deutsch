  // SETTINGS
  function __ctl() {
    this.menuExtraMarginTop=0 //-1
    this.submenuExtraMarginLeft=0 //1
    this.submenuExtraMarginTop=0
    
    if (browser.moz)
    {
      this.menuExtraMarginTop=-1
      this.submenuExtraMarginLeft=1
    }

    if (browser.op)
    {
      this.menuExtraMarginTop=-1
    }

    if (browser.ie)
    {
      this.menuExtraMarginTop=-2
      this.submenuExtraMarginLeft=1
    }
    
    
  }

  // BROWSERCHECK
  function __browser() {
    var ua=navigator.userAgent
    var an=navigator.appName
    var av=navigator.appVersion
    var ln=navigator.language
    var os=navigator.platform

    this.title="unknown"
    this.version="unknown"

    if (ln==undefined || ln==null)
      this.language="en"
    else if (ln == "de" || ln == "de_DE")
      this.language="de"
    else
      this.language="en"


    if (document.getElementById) {
      this.dom=true

      if (document.createTextNode && document.firstChild && document.getElementsByTagName && document.createElement)
        this.domfull=true
      else
        this.domfull=false
    } else {
      this.dom=false
      this.domfull=false
    }

    if (document.all)
      this.all=true
    else
      this.all=false

    if (document.layers)
      this.layers=true
    else
      this.layers=false
      
    this.unix=false
    this.mac=false
    this.win=false     

    if (os.indexOf("Linux") >= 0)
      this.unix=true
    else if (os.indexOf("Mac") >= 0)  
      this.mac=true
    else
      this.win=true
      
    this.op=false
    this.knq=false
    this.is=false
    this.moz=false

    if (this.layers==true)
    {
      this.title="Netscape Navigator"
      this.version="4"
    }
    else if (this.dom==true)
    {
      if (ua.indexOf("Opera") > 0) {
        this.title="Opera"
        this.op=true
        this.all="false"
        if (ua.indexOf("Opera 6") > 0)
          this.version="6"
        else if (ua.indexOf("Opera 5") > 0)
          this.version="5"
        else
          this.version="4"
      }
      else if (ua.indexOf("Konqueror") > 0) {
        this.title="Konqueror"
        this.knq=true
	this.all=false
        if (ua.indexOf("Konqueror/3") > 0)
          this.version="3"
        else
          this.version="2"
      }
      else if (ua.indexOf("Gecko") > 0) {
        this.title="Mozilla"
        this.moz=true

	if (ua.indexOf("rv:0.") > 0)
	  this.version="0"

	if (ua.indexOf("rv:1.0") > 0)
	  this.version="1"

	if (ua.indexOf("rv:1.1") > 0)
	  this.version="1.1"
      }
      else if (ua.indexOf("MSIE") > 0) {
        this.title="Microsoft Internet Explorer"
        this.ie=true

        if (ua.indexOf("MSIE 6.0") > 0) this.version="6"
        else this.version="5"

      }
    }
    else if (this.all==true)
    {
      this.title="Microsoft Internet Explorer"
      this.version="4"
      this.ie=true
    }
    else
    {
      if (an=="Links") {
        this.title="Links"
	this.version="2"
      }
    }
  }

  // Ermittelt abhaengige Objekte
  function __depend(objname)
  {
    return objname.substr(objname.lastIndexOf("_")+1,objname.length)
  }

  // Initialisiert Menues und Buttons
  function __init()
  {
    var btnid, menuid, divs;
    
    ctl.bar=__getobj("bar")
    ctl.special=__getobj("special")

    ctl.buttons=__getall("a", ctl.bar)

    /*
    if (browser.ie)
    {
      ctl.bar.style.filter="progid:DXImageTransform.Microsoft.shadow(color=aaaaaa,Direction=115,Strength=4);"
      ctl.special.style.filter="progid:DXImageTransform.Microsoft.shadow(color=aaaaaa,Direction=205,Strength=4);"
      __getobj("about").style.filter="progid:DXImageTransform.Microsoft.shadow(color=aaaaaa,Direction=115,Strength=4);"
    }
    */ 
    
    // Reparieren der linken Position der Special-Bar...
    if (browser.op)
      ctl.special.style.left=window.innerWidth-ctl.special.offsetWidth

    divs=__getall("div")

    for (var i=0; i<ctl.buttons.length; i++)
    {
      btnid=__depend(ctl.buttons[i].id)

      for (var j=0; j<divs.length; j++)
      {
        if (divs[j].className=="menu")
        {
          menuid=__depend(divs[j].id)

          if (menuid == btnid) {
            // Registrieren des Menues
            ctl.buttons[i].menu=divs[j].id

            // Filter festlegen
            /*
            if (browser.ie)
              divs[j].style.filter="progid:DXImageTransform.Microsoft.fade(duration=0.4); progid:DXImageTransform.Microsoft.shadow(color=aaaaaa,Direction=115,Strength=4);"
            */

            // Linke Ausrichtung vornehmen
            divs[j].style.left=__getPageOffsetLeft(ctl.buttons[i])

	    // Obere Ausrichtung vornehmen
            //divs[j].style.top=__getPageOffsetTop(ctl.buttons[i])+ctl.buttons[i].offsetHeight+ctl.menuExtraMarginTop
            divs[j].style.top=__getPageOffsetTop(ctl.bar)+ctl.bar.offsetHeight+ctl.menuExtraMarginTop
          }
        }
      }
    }

    ctl.submenues=new Array()

    if (browser.op) var maxwidth=new Array()

    for (var i=0; i<ctl.buttons.length; i++)
    {
      var obj=__getobj(ctl.buttons[i].menu)
      ctl.submenues[i]=__getall("a", obj)

      // Noch umstaendlicher als gleich im IE... aller Menuepunkte durchgehen, maximale Breite ermitteln
      // und diese im naechsten Schritt jedem Link explizit zuweisen.
      if (browser.op)
      {
        maxwidth[i]=0
        for (var j=0; j<ctl.submenues[i].length; j++)
          if (maxwidth[i]<ctl.submenues[i][j].offsetWidth) maxwidth[i]=ctl.submenues[i][j].offsetWidth
      }

      // Anpassen des Padding um die Pfeile rechts zu halten...
      var fullWidth=0
      for (var j=0; j<ctl.submenues[i].length; j++)
      {
        var idname=ctl.submenues[i][j].id;
        if (ctl.submenues[i][j].id!="")
        {
          var spanlist=__getall("span", __getobj(idname));

          if(!fullWidth) fullWidth=ctl.submenues[i][j].offsetWidth
          for (var k=0; k<spanlist.length; k++)
            if (__useclass(spanlist[k], "text")) var objtext = spanlist[k]
            else                                 var objarrow = spanlist[k]

          // fixt das Pfeilsymbol in manchen IE Version (pre XP)
          if (browser.ie)
          {
            objarrow.style.fontFamily = "Webdings";
            objarrow.firstChild.nodeValue = "4";
            objarrow.style.lineHeight = "2.5ex";
          }

          objtext.style.paddingRight=(fullWidth-(objtext.offsetWidth + objarrow.offsetWidth)) + "px"
        }
      }

      for (var j=0; j<ctl.submenues[i].length; j++)
      {
        btnid=__depend(ctl.submenues[i][j].id)

        // Korrigieren des Link-Breite... damit der Link ueberall und nicht nur beim Text funktioniert.
        if (browser.ie)
          ctl.submenues[i][j].style.width=ctl.submenues[i][j].offsetWidth
          
        // Maximale Breite zuweisen...
        if (browser.op)
          ctl.submenues[i][j].style.width=maxwidth[i]

        if (btnid!="")
        {
          for (var k=0; k<divs.length; k++)
          {
            if (divs[k].className=="menu")
            {
              menuid=__depend(divs[k].id)

              if (menuid == btnid)
              {
                // Registrieren des Menues
                ctl.submenues[i][j].menu=divs[k].id

                // Wie oben ... Breite der Untermenues fixen
                if (browser.op||browser.ie)
                {
                  var oplinks=__getall("a", __getobj(divs[k].id))
                  var opmax=0
                  for (var op=0; op<oplinks.length; op++)
                    if (opmax<oplinks[op].offsetWidth) opmax=oplinks[op].offsetWidth

                  for (var op=0; op<oplinks.length; op++)
                    oplinks[op].style.width=opmax;
                }

                // Filter festlegen
                /*
                if (browser.ie)
                  divs[k].style.filter="progid:DXImageTransform.Microsoft.fade(duration=0.4); progid:DXImageTransform.Microsoft.shadow(color=aaaaaa,Direction=115,Strength=4);"
                */

                // Linke Ausrichtung vornehmen
                divs[k].style.left=__getPageOffsetLeft(ctl.submenues[i][j])+ctl.submenues[i][j].offsetWidth+ctl.submenuExtraMarginLeft

                // Obere Ausrichtung vornehmen
                divs[k].style.top=__getPageOffsetTop(ctl.submenues[i][j])+ctl.submenuExtraMarginTop
              }
            }
          }
        }
      }
    }
    
    if (browser.ie)
    {
      // Fix some IE CSS to get a nice menu-bar :)
      __getobj("bar").style.paddingTop="0.2em"
      __getobj("bar").style.paddingBottom="0.3em"
      __getobj("special").style.paddingTop="0.2em"
      __getobj("special").style.paddingBottom="0.3em"
    }
    
    if (browser.unix)
    {
      if (browser.knq) var value="5px"
      else var value="7px"
    
      for (var i=0; i<ctl.buttons.length; i++)      
        ctl.buttons[i].style.paddingTop=value
      
      specbuttons=__getall("a", ctl.special)
      
      for (var i=0; i<specbuttons.length; i++)
        specbuttons[i].style.paddingTop=value
    } 	
    
    if (browser.knq) {
      __getobj("bar").style.width="400px";
      __getobj("bar").style.fontSize="0.85em";
      __getobj("special").style.fontSize="0.85em";      
      __getobj("body").style.fontSize="1.0em";
    }  
    
  }

  function __iefilter(obj) {
    if (browser.ie)
    {
      obj.filters[0].Apply();
      obj.filters[1].Apply();
    }
  }

  function __ieplay(obj) {
    if (browser.ie)
      obj.filters[0].Play();
  }

  function __hide(obj) {
//    __iefilter(obj)
    obj.style.visibility="hidden"
//    __ieplay(obj)
  }

  function __show(obj) {
//    __iefilter(obj)
    obj.style.visibility="visible"
//    __ieplay(obj)
  }

  function __focus(obj)
  {
    if(obj.blur) obj.blur()
  }

  function __main(obj)
  {
    var handle;

    // Entferne evtl. offene Untermenues
    __sub(obj)

    for (var i=0; i<ctl.buttons.length; i++)
    {
      menu=__getobj(ctl.buttons[i].menu)

      if (ctl.buttons[i].menu == obj.menu)
      {
        __addclass(obj, "active")
        __show(menu)
      } else {
        __hide(menu)
        __removeclass(__getobj(ctl.buttons[i].id), "active")
      }
    }
  }

  // Handelt Unter-Menues ... blendet Zugeordnetes ein,
  // entfernt alle Anderen
  function __sub(obj)
  {
    if(obj.blur) obj.blur()

    for (var i=0; i<ctl.submenues.length; i++)
    {
      for (var j=0; j<ctl.submenues[i].length; j++)
      {
        var menuname = ctl.submenues[i][j].menu;

        if (typeof(menuname)=="string")
        {
          var menu=__getobj(menuname)

          if (obj.menu == menuname) {
            __addclass(obj, "active")
            __show(menu)
          }
          else
          {
            __hide(menu)
            __removeclass(__getobj(ctl.submenues[i][j].id), "active")
          }
        }
      }
    }
  }


  // Entfernt alle Menues und setzt alle
  // evtl. aktiven Buttons zurueck
  function __body()
  {
    divs=__getall("div")

    // Alle Ebenen verstecken
    for (var i=0; i<divs.length; i++)
      if (divs[i].className=="menu")
        __hide(divs[i])

    // Aktive Hauptmenue-Punkte zuruecksetzen
    for (var i=0; i<ctl.buttons.length; i++)
      __removeclass(__getobj(ctl.buttons[i].id), "active")

    // Aktive Punkte in Menues zuruecksetzen
    for (var i=0; i<ctl.submenues.length; i++)
      for (var j=0; j<ctl.submenues[i].length; j++)
        if (typeof(ctl.submenues[i][j].menu)=="string")
          __removeclass(__getobj(ctl.submenues[i][j].id), "active")
  }

  /* ************************************************** */

  // Den Typ eines Events ermitteln
  function __geteventtype(event)
  {
    return event.type;
  }

  // Das Ziel eines Events ermitteln
  function __geteventtarget(event)
  {
    if (event.srcElement)
      return event.srcElement.tagName
    else
      return event.target.nodeName
  }

  function __getobj(objname, base) {
    if (base==null)
      base=document;

    return base.getElementById(objname)
  }

  function __getall(objname, base) {
    if (base==null)
      base=document;

    return base.getElementsByTagName(objname)
  }


  function __useclass(obj, name) {
    var list = obj.className.split(" ");

    for (var i = 0; i < list.length; i++)
      if (list[i] == name)
        return true;

    return false;
  }


  function __addclass(obj, name) {
    var list = obj.className.split(" ");

    if (list.length = 0)
      obj.className=name
    else
      obj.className=obj.className+" "+name

  }


  function __removeclass(obj, name) {
    if (obj.className == null) return;

    var newList = new Array();
    var curList = obj.className.split(" ");

    for (var i = 0; i < curList.length; i++)
      if (curList[i] != name)
        newList.push(curList[i]);

    obj.className = newList.join(" ");
  }


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
