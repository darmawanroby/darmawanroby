 

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
$currentDate =16;//date("d");
//echo $currentDate;


//MEMILIH DATA JSON BERDASARKAN TANGGAL AKHIR PELAPORAN

if ($currentDate < $tglLap ){
$urlTemp='http://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/05/2015/remun@dktu99';
//$urlTemp = 'http://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/'.date("m").'/'.date("Y").'/remun@dktu99';
//$urlTemp = 'remun0614.txt';
$contentRemun = file_get_contents($urlTemp);
$jsonRemun = json_decode($contentRemun, true);

  
 
 //membersihkan table taKaryawanTMP_json

	
	  $sql = "select * from taKaryawanTMP_json";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taKaryawanTMP_json";
		    sqlsrv_query($conn, $dest);
		    
		};
		 

//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach( $jsonRemun as $i){
  //echo fnDecrypt($i['TMTCPNS'],$sSecretKey);
//echo fnDecrypt($i['NamaLengkap'],$sSecretKey)."<br>";
	 
     $sql_data = "insert into taKaryawanTMP_json (NIP,NAMA,TMT,KODE_INSTANSI,KODE_UNIT,KODE_DEPUTI,KODE_BIRO,KODE_BAGIAN,KODE_SUBBAGIAN,KODE_GOLONGAN,KODE_GRADE,KODE_ESELON,NIP_BARU,JABATAN,NO_URUT,KET,NPWP,UM,TGL_PENSIUN,JPEG) VALUES ('".fnDecrypt($i['NIPLama'],$sSecretKey)."','".str_replace('\'','\'\'',fnDecrypt($i['NamaLengkap'],$sSecretKey))."','".date('Y-m-d',  strtotime(fnDecrypt($i['TMTCPNS'],$sSecretKey)))."','".fnDecrypt($i['IdInstansi'],$sSecretKey)."','".fnDecrypt($i['IdUnit'],$sSecretKey)."','".fnDecrypt($i['IdDeputi'],$sSecretKey)."','".fnDecrypt($i['IdBiro'],$sSecretKey)."','".fnDecrypt($i['IdBagian'],$sSecretKey)."','".fnDecrypt($i['IdSubbagian'],$sSecretKey)."','".fnDecrypt($i['KdGol'],$sSecretKey)."','".fnDecrypt($i['IdClass'],$sSecretKey)."','".fnDecrypt($i['KdEselon'],$sSecretKey)."','".fnDecrypt($i['NIPBaru'],$sSecretKey)."','".fnDecrypt($i['Jabatan'],$sSecretKey)."','".fnDecrypt($i['Urut'],$sSecretKey)."','".fnDecrypt($i['Ket'],$sSecretKey)."','".fnDecrypt($i['NPWP'],$sSecretKey)."','".fnDecrypt($i['UM'],$sSecretKey)."','".date('Y-m-d',strtotime(fnDecrypt($i['BUP'],$sSecretKey)))."','".fnDecrypt($i['JenisPegawai'],$sSecretKey)."')";
 
    sqlsrv_query($conn, $sql_data);
  
 
}}

 






if ($currentDate>$tglLap){
   
    $month = date("m");
   
  //$urlTemp = 'http://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/'.++$month.'/'.date("Y").'/remun@dktu99';
   $urlTemp = 'http://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/05/2015/remun@dktu99';
  
  //$urlTemp = 'remun0614.txt';
//echo $urlTemp;
 
 $contentRemun = file_get_contents($urlTemp);
$jsonRemun = json_decode($contentRemun, true);

  
 
 //membersihkan table taKaryawanTMP_json

	
	  $sql = "select * from taKaryawanTMP_json";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taKaryawanTMP_json";
		    sqlsrv_query($conn, $dest);
		    
		};
 
//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
//$i =1;
foreach( $jsonRemun as $i){
  //echo fnDecrypt($i['NIPLama'],$sSecretKey).','.fnDecrypt($i['NamaLengkap'],$sSecretKey).'<br>';
  //echo fnDecrypt($i['NIPLama'],$sSecretKey)."','".str_replace('\'','\'\'',fnDecrypt($i['NamaLengkap'],$sSecretKey))."','".date('Y-m-d',  strtotime(fnDecrypt($i['TMTCPNS'],$sSecretKey)))."','".fnDecrypt($i['IdInstansi'],$sSecretKey)."','".fnDecrypt($i['IdUnit'],$sSecretKey)."','".fnDecrypt($i['IdDeputi'],$sSecretKey)."','".fnDecrypt($i['IdBiro'],$sSecretKey)."','".fnDecrypt($i['IdBagian'],$sSecretKey)."','".fnDecrypt($i['IdSubbagian'],$sSecretKey)."','".fnDecrypt($i['KdGol'],$sSecretKey)."','".fnDecrypt($i['IdClass'],$sSecretKey)."','".fnDecrypt($i['KdEselon'],$sSecretKey)."','".fnDecrypt($i['NIPBaru'],$sSecretKey)."','".fnDecrypt($i['Jabatan'],$sSecretKey)."','".fnDecrypt($i['Urut'],$sSecretKey)."','".fnDecrypt($i['Ket'],$sSecretKey)."','".fnDecrypt($i['NPWP'],$sSecretKey)."','".fnDecrypt($i['UM'],$sSecretKey)."','".date('Y-m-d',strtotime(fnDecrypt($i['BUP'],$sSecretKey)))."','".fnDecrypt($i['JenisPegawai'],$sSecretKey).'<br>';
	 
    $sql_data = "insert into taKaryawanTMP_json (NIP,NAMA,TMT,KODE_INSTANSI,KODE_UNIT,KODE_DEPUTI,KODE_BIRO,KODE_BAGIAN,KODE_SUBBAGIAN,KODE_GOLONGAN,KODE_GRADE,KODE_ESELON,NIP_BARU,JABATAN,NO_URUT,KET,NPWP,UM,TGL_PENSIUN,JPEG) VALUES ('".fnDecrypt($i['NIPLama'],$sSecretKey)."','".str_replace('\'','\'\'',fnDecrypt($i['NamaLengkap'],$sSecretKey))."','".date('Y-m-d',  strtotime(fnDecrypt($i['TMTCPNS'],$sSecretKey)))."','".fnDecrypt($i['IdInstansi'],$sSecretKey)."','".fnDecrypt($i['IdUnit'],$sSecretKey)."','".fnDecrypt($i['IdDeputi'],$sSecretKey)."','".fnDecrypt($i['IdBiro'],$sSecretKey)."','".fnDecrypt($i['IdBagian'],$sSecretKey)."','".fnDecrypt($i['IdSubbagian'],$sSecretKey)."','".fnDecrypt($i['KdGol'],$sSecretKey)."','".fnDecrypt($i['IdClass'],$sSecretKey)."','".fnDecrypt($i['KdEselon'],$sSecretKey)."','".fnDecrypt($i['NIPBaru'],$sSecretKey)."','".fnDecrypt($i['Jabatan'],$sSecretKey)."','".fnDecrypt($i['Urut'],$sSecretKey)."','".fnDecrypt($i['Ket'],$sSecretKey)."','".fnDecrypt($i['NPWP'],$sSecretKey)."','".fnDecrypt($i['UM'],$sSecretKey)."','".date('Y-m-d',strtotime(fnDecrypt($i['BUP'],$sSecretKey)))."','".fnDecrypt($i['JenisPegawai'],$sSecretKey)."')";
 
    sqlsrv_query($conn, $sql_data);
  
 
}
  
 }




//$urlRemun = 'remun0614.txt';

 
  
 
  