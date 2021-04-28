<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
$sSecretKey ="Jalan$1289&KMY%8789";
//$sSecretKey = "Jalan$1289&KMY%8";
function fnDecrypt($sValue, $sSecretKey)
{
	return rtrim(
			mcrypt_decrypt(
					MCRYPT_RIJNDAEL_256,
					$sSecretKey,
					base64_decode($sValue),
					MCRYPT_MODE_ECB,
					mcrypt_create_iv(
							mcrypt_get_iv_size(
									MCRYPT_RIJNDAEL_256,
									MCRYPT_MODE_ECB
							),
							MCRYPT_RAND
					)
			), "\0"
	);
}

$urlTemp =  'https://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/03/2016/remun@dktu99';
 //$urlTemp = '012016.txt';
  //echo $urlTemp;
  //$urlTemp = 'remun0614.txt';
 
 
			//$contentRemun = file_get_contents($urlTemp);
	//$jsonRemun = json_decode($contentRemun, true);

		$contentRemun = file_get_contents($urlTemp);
		$jsonRemun = json_decode($contentRemun, true);
	//

foreach( $jsonRemun as $i){
  echo fnDecrypt($i['NamaLengkap'],$sSecretKey)."=>".fnDecrypt($i['UM'],$sSecretKey)."<br>";
	// echo fnDecrypt($i['StrukturBaru'],$sSecretKey)."<br>";
	 
	 

}

?>