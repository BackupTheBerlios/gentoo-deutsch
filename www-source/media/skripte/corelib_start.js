/******************************************************************************

  The xKit [0.1 alpha]
  Name of Component "corelib_start.js"

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
//  Startup
// =================================

// Debug aktiv?
debug = new x_debug(false);

// Browser Type und Environment-Parameter
browser = new x_browser();

// Konfigurations-Schnittstelle
config = new x_config();

// Event-Schnittstelle
// action = new x_action();

// Menue konfigurieren
config.store("x_menu/border/width/first_horiz", 0)
config.store("x_menu/border/width/first_verti", 0)
config.store("x_menu/border/width/next_horiz", 1)
config.store("x_menu/border/width/next_verti", 0)
config.store("x_menu/class/submenu", "submenu")

// Debug-Objekt, Name der Layer, Name der Links, Menü-Objekt
menu = new x_menu("gmenu", "glink");

