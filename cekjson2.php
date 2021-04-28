<?php

$urlTemp = 'https://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/01/2016/remun@dktu99';
 
 
 
			$contentRemun = file_get_contents($urlTemp);
	echo $contentRemun;
 

?>