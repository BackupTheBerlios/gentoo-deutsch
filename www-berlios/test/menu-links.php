<?php
function createItem($name) {
  $id=$name;  
  echo '<tr><td class="menu-links" id="'.$id.'" onmouseover="set_mouseover(\''.$id.'\')" onmouseout="set_mouseout(\''.$id.'\')">';
  echo '<a style="text-decoration: none">'.$name.'</a></td></tr>';

}

function createRubrik($name) {
  echo '<th class="menu-links">'.$name.'</th>';

}

?>

<table border="0" cellpadding="0" cellspacing="0">
<?php
createRubrik("Dokumentationen");
createItem("Gentoo Installation");
createItem("Lokalisierung");
createItem("Localization (english)");
createItem("Gentoo Linux FAQ");
createItem("gentoo.de FAQ");
createItem("Alternative Installationen");
createItem("Portage Leitfaden");
createItem("Die Gentoo USE Flags");
createItem("Das Gentoo Init System");
createItem("Nano Grundlagen");
createItem("Mirroring Anleitung");
createItem("Installation von Java");
createItem("Portage Handbuch");

createRubrik("Dokumente in Arbeit");
createItem("Fluxbox Desktop in Gentoo");
createItem("Entwickler HOWTO");
createItem("Gentoo-Sicherheitsleitfaden");

createRubrik("Gentoo Links");
createItem("offizielle Seite");
createItem("gentoouser.org");
createItem("gentoo-linux.net");
createItem("gentoo-de.org");
createItem("Gentoo Art");

createRubrik("Gentoo international");
createItem("Dänemark");
createItem("Frankreich");
createItem("Korea");
createItem("Norwegen");
?>

</table>