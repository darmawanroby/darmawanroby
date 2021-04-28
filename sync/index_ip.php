<?
	
  $server = $_SERVER['SERVER_ADDR'];
  
  //echo $server;
  
  //read mac adress list
   
  
  $array = explode("\n", file_get_contents('iplist.txt'));
  
//get client mac adress	 
	$ip2 = $_SERVER['REMOTE_ADDR'];
	$mac=shell_exec("arp -a ".escapeshellarg($ip2));

 

$findme = "Physical";
$pos = strpos($mac, $findme);
$macp =  trim(substr($mac,($pos+42),26)," ");
 
 if ((in_array((string)$macp, $array)) || ($server=='127.0.0.1')) {
   // echo "Your Mac Address :".$macp;
	header("Location: http://192.168.1.14:81/index2.php"); 
}
else {
	//Echo "Access Restricted";
	header("Location: http://192.168.1.14:81/index2.php"); 
}

  ?>