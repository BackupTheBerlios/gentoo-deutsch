
<table border="0" cellpadding="0" cellspacing="0">
<th class="ebuilds">
Ebuilds vom 13.08.2002
</th>

<?php
$f=fopen("ebuilds","r"); 
if ($f==false) return 0; 
while ($rec=fgetcsv($f,1000, ";")) { 
  echo '<tr><td class="ebuilds"><a href="'.$rec[1].'" class="ebuilds">'.$rec[0].'</a></td></tr>';
  
} 

?>

</table>