 


<?php
//echo "cuti online";

// memilih tanggal laporan dari taVariable




error_reporting(E_ALL);
ini_set('display_errors', 1);
$sSecretKey ="Ij1n579#B0r4%kA6";
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

//DATABASE CONNECTION

$myServer = "localhost";

// SQL Server User that has permission to the database
$myUser = "rekabio";

// SQL Server User Password
$myPass = "Meinardi";

// Database
$myDB = "DataReal";

// Notice that the latest driver uses sqlsrv rather than mssql
$conn = sqlsrv_connect($myServer, array('UID'=>$myUser, 'PWD'=>$myPass, 'Database'=>$myDB));



$sqlTglLaporan = "select TGL_LAPORAN from taVariabel";
$tglLaporan = sqlsrv_query($conn,$sqlTglLaporan);
$resultTgl = array();

do {
	while ($row = sqlsrv_fetch_array($tglLaporan, SQLSRV_FETCH_ASSOC)){
		$resultTgl[] = $row;
	}
}while ( sqlsrv_next_result($tglLaporan) );

$jsonTglTemp =  json_encode($resultTgl);
$decodeTgl =  json_decode($jsonTglTemp,TRUE);

foreach ($decodeTgl as $lap){
    $tglLap = $lap['TGL_LAPORAN'];
}

$tutupPeriode =  $tglLap;
echo '<br>';


 //$date = date('Y-m-d H:i:s');
 $string = date('Y-m-d');;
 $date = DateTime::createFromFormat("Y-m-d", $string);
 $tglCurrent = $date->format("d");
 
  


if ($tglLap>=$tglCurrent){
	$tglAwal = date("Y-n-j", strtotime("first day of previous month"));
	$tglAkhir = date("Y-n-j", strtotime("last day of previous month"));


$urlTemp='https://simsdm.setneg.go.id/proses/integrasi/wscuti.php/cuti@simsdm75/'.$tglAwal.'/'.$tglAkhir;
$content= file_get_contents($urlTemp);
$jsonCuti = json_decode($content, true);

 //echo $urlTemp;

foreach( $jsonCuti as $i){
 
	
		$sql_data = "insert into taIjinHariTemp (NIP,TGL_AWAL,TGL_AKHIR,KODE_IJIN,JML_HARI,TGL_JATAH,BUKTI_IJIN,STATUS_IJIN,WAKTU_SIMPAN,tgl_bersalin) values ('".fnDecrypt($i['nip'],$sSecretKey)."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgl_awal'],$sSecretKey)))."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgl_akhir'],$sSecretKey)))."','".fnDecrypt($i['kode_cuti'],$sSecretKey)."','".fnDecrypt($i['jml'],$sSecretKey)."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgljt'],$sSecretKey)))."','".fnDecrypt($i['bukti_ijin'],$sSecretKey)."','".fnDecrypt($i['status_ijin'],$sSecretKey)."','".date('Y-m-d',  strtotime(fnDecrypt($i['waktu_simpan'],$sSecretKey)))."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgl_bersalin'],$sSecretKey)))."')";
		
		sqlsrv_query($conn, $sql_data);
}
}
else{
	$tglAwal    = date('Y-m-01');
    $tglAkhir= date('Y-m-t');
	
	$urlTemp='https://simsdm.setneg.go.id/proses/integrasi/wscuti.php/cuti@simsdm75/'.$tglAwal.'/'.$tglAkhir;
$content= file_get_contents($urlTemp);
$jsonCuti = json_decode($content, true);

echo $urlTemp;

foreach( $jsonCuti as $i){
//	echo fnDecrypt($i['tgl_awal'],$sSecretKey);
	
		$sql_data = "insert into taIjinHariTemp (NIP,TGL_AWAL,TGL_AKHIR,KODE_IJIN,JML_HARI,TGL_JATAH,BUKTI_IJIN,STATUS_IJIN,WAKTU_SIMPAN,tgl_bersalin) values ('".fnDecrypt($i['nip'],$sSecretKey)."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgl_awal'],$sSecretKey)))."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgl_akhir'],$sSecretKey)))."','".fnDecrypt($i['kode_cuti'],$sSecretKey)."','".fnDecrypt($i['jml'],$sSecretKey)."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgljt'],$sSecretKey)))."','".fnDecrypt($i['bukti_ijin'],$sSecretKey)."','".fnDecrypt($i['status_ijin'],$sSecretKey)."','".date('Y-m-d',  strtotime(fnDecrypt($i['waktu_simpan'],$sSecretKey)))."','".date('Y-m-d',  strtotime(fnDecrypt($i['tgl_bersalin'],$sSecretKey)))."')";
		
		sqlsrv_query($conn, $sql_data);
}
}

$sql3 = "exec proc_sync_cuti";
$stmt3 = sqlsrv_query($conn,$sql3);

?>

 <script type="text/javascript">setTimeout("window.close();", 3000);</script>