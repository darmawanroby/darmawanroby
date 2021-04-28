<head>
    <title>Progress Bar</title>
</head>
<body>
<!-- Progress bar holder -->
<div id="progress" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information" style="width"></div>
 

<?php



error_reporting(E_ALL);
ini_set('display_errors', 1);

$sSecretKey = "Jalan$1289&KMY%8789";
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

$arrContextOptions=array(
    "ssl"=>array(
         
        "verify_peer"=> false,
        "verify_peer_name"=> false,
    ),
);

$myServer = "localhost";

// SQL Server User that has permission to the database
$myUser = "rekabio";

// SQL Server User Password
$myPass = "Meinardi";

// Database
$myDB = "DataReal";

// Notice that the latest driver uses sqlsrv rather than mssql
$conn = sqlsrv_connect($myServer, array('UID'=>$myUser, 'PWD'=>$myPass, 'Database'=>$myDB));

// memilih tanggal laporan dari taVariable

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

//TANGGAL AKTUAL
$currentDate =14; //date("d");

//echo $currentDate;


//MEMILIH DATA JSON BERDASARKAN TANGGAL AKHIR PELAPORAN

//echo $periode;
//echo "jalan";
   
    $month = date("m");
   
  $urlTemp = 'https://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/04/2016/remun@dktu99';
//  $urlTemp = '122015.txt';
  //echo $urlTemp;
  //$urlTemp = 'remun0614.txt';
 
 
			//$contentRemun = file_get_contents($urlTemp);
	//$jsonRemun = json_decode($contentRemun, true);

	
	//
//	if (is_readable($urlTemp)){
		$contentRemun = file_get_contents($urlTemp);
		$jsonRemun = json_decode($contentRemun, true);
	/*  $sql = "select * from taKaryawanTMP_json";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taKaryawanTMP_json";
		    sqlsrv_query($conn, $dest);
		    
		};*/
 //echo $urlTemp;
//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
$total = count($jsonRemun);
//echo $total;

$k =1;
foreach( $jsonRemun as $i){
  echo fnDecrypt($i['NamaLengkap'],$sSecretKey)."=>".fnDecrypt($i['UM'],$sSecretKey)."<br>";
	// echo fnDecrypt($i['StrukturBaru'],$sSecretKey)."<br>";
	 
	/* 
    $sql_data = "insert into taKaryawanTmp_json (NIP,NAMA,TMT,KODE_INSTANSI,KODE_UNIT,KODE_DEPUTI,KODE_BIRO,KODE_BAGIAN,KODE_SUBBAGIAN,KODE_GOLONGAN,KODE_GRADE,KODE_ESELON,NIP_BARU,JABATAN,NO_URUT,KET,NPWP,UM,TGL_PENSIUN,JPEG,STRUKTUR_BARU) VALUES ('".fnDecrypt($i['NIPLama'],$sSecretKey)."','".str_replace('\'','\'\'',fnDecrypt($i['NamaLengkap'],$sSecretKey))."','".date('Y-m-d',  strtotime(fnDecrypt($i['TMTCPNS'],$sSecretKey)))."','".fnDecrypt($i['IdInstansi'],$sSecretKey)."','".fnDecrypt($i['IdUnit'],$sSecretKey)."','".fnDecrypt($i['IdDeputi'],$sSecretKey)."','".fnDecrypt($i['IdBiro'],$sSecretKey)."','".fnDecrypt($i['IdBagian'],$sSecretKey)."','".fnDecrypt($i['IdSubbagian'],$sSecretKey)."','".fnDecrypt($i['KdGol'],$sSecretKey)."','".fnDecrypt($i['IdClass'],$sSecretKey)."','".fnDecrypt($i['KdEselon'],$sSecretKey)."','".fnDecrypt($i['NIPBaru'],$sSecretKey)."','".fnDecrypt($i['Jabatan'],$sSecretKey)."','".fnDecrypt($i['Urut'],$sSecretKey)."','".fnDecrypt($i['Ket'],$sSecretKey)."','".fnDecrypt($i['NPWP'],$sSecretKey)."','".fnDecrypt($i['UM'],$sSecretKey)."','".date('Y-m-d',strtotime(fnDecrypt($i['BUP'],$sSecretKey)))."','".fnDecrypt($i['JenisPegawai'],$sSecretKey)."','".fnDecrypt($i['StrukturBaru'],$sSecretKey)."')";
 
    sqlsrv_query($conn, $sql_data);
  */
  //$percent = intval($k++/$total * 100)."%";

    // Javascript for updating the progress bar and information
    /*echo '<script language="javascript">
    document.getElementById("progress").innerHTML="<div style=\"width:'.$percent.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information").innerHTML="'.$percent.'  processed.";
    </script>';
*/

// This is for the buffer achieve the minimum size in order to flush data
   // echo str_repeat(' ',1024*128);


// Send output to browser immediately
    flush();


// Sleep one second so we can see the delay
   // sleep(1);
}

?>




 </body>
  
 
  