
<html>
<head>
    <title></title>
</head>
<body>
 

<!-- Progress bar holder unit-->
<div id="progress2" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information2" style="width"></div>

<!-- Progress bar holder Deputi-->
<div id="progress3" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information3" style="width"></div>

<!-- Progress bar holder Biro-->
<div id="progress4" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information4" style="width"></div>

<!-- Progress bar holder Bagian-->
<div id="progress5" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information5" style="width"></div>

<!-- Progress bar holder SubBagian-->
<div id="progress6" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information6" style="width"></div>


<!-- Progress bar holder Grade-->
<div id="progress7" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information7" style="width"></div>


<!-- Progress bar holder -->
<div id="progress" style="width:500px;border:1px solid #ccc;"></div>
<!-- Progress information -->
<div id="information" style="width"></div>






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


//SYNCHRONISASI UNIT

//MENGAMBIL DATA DARI WEBSERVICE
$urlUnit = 'https://simsdm.setneg.go.id/proses/integrasi/wsreferensi.php/remun@dktu99/2';
//$urlUnit = 'unit.txt';
$contentUnit = file_get_contents($urlUnit);
$jsonUnit = json_decode($contentUnit, true);


//menghapus data temporary

 $sql = "select * from taUnitTmp";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taUnitTmp";
		    sqlsrv_query($conn, $dest);
		    
		};

//Menghitung total record

$total2 = count($jsonUnit);
$m=1;



//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach($jsonUnit as $i){
//echo "00".fnDecrypt($i['Id_Unit'],$sSecretKey);
				$sql = "insert into taUnitTmp (KODE_UNIT,KODE_INSTANSI,NAMA_UNIT) VALUES ('".fnDecrypt($i['Id_Unit'],$sSecretKey)."',".fnDecrypt($i['Id_Instansi'],$sSecretKey).",'".fnDecrypt($i['Unit'],$sSecretKey)."')";

			sqlsrv_query($conn, $sql);
		
  $percent2 = intval($m++/$total2 * 100)."%";

    // Javascript for updating the progress bar and information
    echo '<script language="javascript">
    document.getElementById("progress2").innerHTML="<div style=\"width:'.$percent2.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information2").innerHTML="'.$percent2.' row(s) processed.";
    </script>';


// This is for the buffer achieve the minimum size in order to flush data
    echo str_repeat(' ',1024*64);


// Send output to browser immediately
    flush();



}
 for($m=1; $m<=$total2; $m++){
    // Calculate the percentation
   
}
// Tell user that the process is completed
echo '<script language="javascript">document.getElementById("information2").innerHTML="Import Unit Selesai"</script>';



//SYNCHRONISASI DEPUTI

//MENGAMBIL DATA DARI WEBSERVICE
$urlDeputi = 'https://simsdm.setneg.go.id/proses/integrasi/wsreferensi.php/remun@dktu99/3';
$contentDeputi = file_get_contents($urlDeputi);
$jsonDeputi = json_decode($contentDeputi, true);

//menghapus data temporary

 $sql = "select * from taDeputiTmp";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taDeputiTmp";
		    sqlsrv_query($conn, $dest);
		    
		};

//menghitung jumlah record deputi

$total3 = count($jsonDeputi);
$n=1;


//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach($jsonDeputi as $i){
	 
			$sql = "insert into taDeputiTmp (KODE_DEPUTI,KODE_UNIT,NAMA_DEPUTI) VALUES ('".fnDecrypt($i['Id_deputi'],$sSecretKey)."',".fnDecrypt($i['Id_unit'],$sSecretKey).",'".fnDecrypt($i['Deputi'],$sSecretKey)."')";

			sqlsrv_query($conn, $sql);
		 




  $percent3 = intval($n++/$total3 * 100)."%";

    // Javascript for updating the progress bar and information
    echo '<script language="javascript">
    document.getElementById("progress3").innerHTML="<div style=\"width:'.$percent3.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information3").innerHTML="'.$percent3.' row(s) processed.";
    </script>';


// This is for the buffer achieve the minimum size in order to flush data
    echo str_repeat(' ',1024*64);


// Send output to browser immediately
    flush();



}
 for($n=1; $n<=$total3; $n++){
    // Calculate the percentation
   
}
// Tell user that the process is completed
echo '<script language="javascript">document.getElementById("information3").innerHTML="Import Deputi Selesai"</script>';




//SYNCHRONISASI BIRO

//MENGAMBIL DATA DARI WEBSERVICE
$urlBiro = 'https://simsdm.setneg.go.id/proses/integrasi/wsreferensi.php/remun@dktu99/4';
//$urlBiro = 'biro.txt';

$contentBiro = file_get_contents($urlBiro);
$jsonBiro = json_decode($contentBiro, true);

//menghapus data temporary

 $sql = "select * from taBiroTmp";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taBiroTmp";
		    sqlsrv_query($conn, $dest);
		    
		};


//menghitung jumlah record
$total4 = count($jsonBiro);
$o=1;


//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach($jsonBiro as $i){
	 		$sql = "insert into taBiroTmp (KODE_BIRO,KODE_DEPUTI,NAMA_BIRO) VALUES (".fnDecrypt($i['Id_Biro'],$sSecretKey).",'".fnDecrypt($i['Id_Deputi'],$sSecretKey)."','".fnDecrypt($i['Biro'],$sSecretKey)."')";

			sqlsrv_query($conn, $sql);
		 
  $percent4 = intval($o++/$total4 * 100)."%";

    // Javascript for updating the progress bar and information
    echo '<script language="javascript">
    document.getElementById("progress4").innerHTML="<div style=\"width:'.$percent4.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information4").innerHTML="'.$percent4.' row(s) processed.";
    </script>';


// This is for the buffer achieve the minimum size in order to flush data
    echo str_repeat(' ',1024*64);


// Send output to browser immediately
    flush();



}
 for($o=1; $o<=$total4; $o++){
    // Calculate the percentation
   
}
// Tell user that the process is completed
echo '<script language="javascript">document.getElementById("information4").innerHTML="Import Biro Selesai"</script>';





//SYNCHRONISASI BBAGIAN

//MENGAMBIL DATA DARI WEBSERVICE
$urlBagian = 'https://simsdm.setneg.go.id/proses/integrasi/wsreferensi.php/remun@dktu99/5';
//$urlBagian = 'bagian.txt';
$contentBagian = file_get_contents($urlBagian);
$jsonBagian = json_decode($contentBagian, true);

//menghapus data temporary

 $sql = "select * from taBagianTmp";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taBagianTmp";
		    sqlsrv_query($conn, $dest);
		    
		};

		
//Menghitung total bagian

$total5 = count($jsonBagian);
$p=1;


//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach($jsonBagian as $i){
 
			$sql = "insert into taBagianTmp (KODE_BAGIAN,KODE_BIRO,NAMA_BAGIAN) VALUES (".fnDecrypt($i['Id_Bagian'],$sSecretKey).",".fnDecrypt($i['Id_Biro'],$sSecretKey).",'".fnDecrypt($i['Bagian'],$sSecretKey)."')";

			sqlsrv_query($conn, $sql);
		 
$percent5 = intval($p++/$total5 * 100)."%";

    // Javascript for updating the progress bar and information
    echo '<script language="javascript">
    document.getElementById("progress5").innerHTML="<div style=\"width:'.$percent5.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information5").innerHTML="'.$percent5.' row(s) processed.";
    </script>';


// This is for the buffer achieve the minimum size in order to flush data
    echo str_repeat(' ',1024*64);


// Send output to browser immediately
    flush();



}
 for($p=1; $p<=$total5; $p++){
    // Calculate the percentation
   
}
// Tell user that the process is completed
echo '<script language="javascript">document.getElementById("information5").innerHTML="Import Bagian Selesai"</script>';




//SYNCHRONISASI SUBBBAGIAN

//MENGAMBIL DATA DARI WEBSERVICE
$urlSubBagian = 'https://simsdm.setneg.go.id/proses/integrasi/wsreferensi.php/remun@dktu99/6';
//$urlSubBagian = 'subbagian.txt';
$contentSubBagian = file_get_contents($urlSubBagian);
$jsonSubBagian = json_decode($contentSubBagian, true);

//menghapus data temporary

 $sql = "select * from taSubbagianTmp";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taSubbagianTmp";
		    sqlsrv_query($conn, $dest);
		    
		};


//Menghitung jumlah record
$total6 = count($jsonSubBagian);
$q=1;


//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach($jsonSubBagian as $i){ 
				$sql = "insert into taSubBagianTmp (KODE_SUBBAGIAN,KODE_BAGIAN,NAMA_SUBBAGIAN) VALUES (".fnDecrypt($i['Id_Subbagian'],$sSecretKey).",".fnDecrypt($i['Id_Bagian'],$sSecretKey).",'".fnDecrypt($i['Subbagian'],$sSecretKey)."')";

			sqlsrv_query($conn, $sql);
		 

$percent6 = intval($q++/$total6 * 100)."%";

    // Javascript for updating the progress bar and information
    echo '<script language="javascript">
    document.getElementById("progress6").innerHTML="<div style=\"width:'.$percent6.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information6").innerHTML="'.$percent6.' row(s) processed.";
    </script>';


// This is for the buffer achieve the minimum size in order to flush data
    echo str_repeat(' ',1024*64);


// Send output to browser immediately
    flush();



}
 for($q=1; $q<=$total6; $q++){
    // Calculate the percentation
   
}
// Tell user that the process is completed
echo '<script language="javascript">document.getElementById("information6").innerHTML="Import SubBagian Selesai"</script>';
 

//SYNCHRONISASI GRADE

//MENGAMBIL DATA DARI WEBSERVICE
$urlClass = 'https://simsdm.setneg.go.id/proses/integrasi/wsreferensi.php/remun@dktu99/7';
//$urlClass = 'grade.txt';
$contentClass = file_get_contents($urlClass);
$jsonClass = json_decode($contentClass, true);

//menghapus data temporary

 $sql = "select * from taGradeTmp";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taGradeTmp";
		    sqlsrv_query($conn, $dest);
		    
		};

//Menghitung record grade

$total7 = count($jsonClass);
$r=1;


//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach($jsonClass as $i){
  		$sql = "insert into taGradeTmp (KODE_GRADE,NILAI_GRADE) VALUES (".fnDecrypt($i['Id_Class'],$sSecretKey).",".fnDecrypt($i['Job_Class'],$sSecretKey).")";

			sqlsrv_query($conn, $sql);
		 

$percent7 = intval($r++/$total7 * 100)."%";

    // Javascript for updating the progress bar and information
    echo '<script language="javascript">
    document.getElementById("progress7").innerHTML="<div style=\"width:'.$percent7.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information7").innerHTML="'.$percent7.' row(s) processed.";
    </script>';


// This is for the buffer achieve the minimum size in order to flush data
    echo str_repeat(' ',1024*64);


// Send output to browser immediately
    flush();



}
 for($r=1; $r<=$total7; $r++){
    // Calculate the percentation
   
}
// Tell user that the process is completed
echo '<script language="javascript">document.getElementById("information7").innerHTML="Import Grade Selesai"</script>';


//SYNCHRONISASI ESELON

//MENGAMBIL DATA DARI WEBSERVICE
$urlEselon = 'https://simsdm.setneg.go.id/proses/integrasi/wsreferensi.php/remun@dktu99/8';

//$urlEselon = 'eselon.txt';
$contentEselon = file_get_contents($urlEselon);
$jsonEselon = json_decode($contentEselon, true);

//menghapus data temporary

 $sql = "select * from taEselonTmp";
		if(sqlsrv_query($conn, $sql)){
		    $dest = "delete from taEselonTmp";
		    sqlsrv_query($conn, $dest);
		    
		};

	//echo "Jumlah Array : ".count($jsonEselon)."<br>";
	$total = count($jsonEselon);
$k=1;
	//EKSEKUSI DAN MEMBANDINGKAN DATA DENGAN DATA LOKAL
foreach($jsonEselon as $i){
   
			$sql = "insert into taEselonTmp (KODE_ESELON,NAMA_ESELON) VALUES (".fnDecrypt($i['kdeselon'],$sSecretKey).",'".fnDecrypt($i['nmeselon'],$sSecretKey)."')";

			sqlsrv_query($conn, $sql);
		 
	  $percent = intval($k++/$total * 100)."%";

    // Javascript for updating the progress bar and information
    echo '<script language="javascript">
    document.getElementById("progress").innerHTML="<div style=\"width:'.$percent.';background-color:#ddd;\">&nbsp;</div>";
    document.getElementById("information").innerHTML="'.$percent.' row(s) processed.";
    </script>';


// This is for the buffer achieve the minimum size in order to flush data
    echo str_repeat(' ',1024*64);


// Send output to browser immediately
    flush();


// Sleep one second so we can see the delay
    //sleep(1);
}
for($k=1; $k<=$total; $k++){
    // Calculate the percentation
   
}
// Tell user that the process is completed
echo '<script language="javascript">document.getElementById("information").innerHTML="Import Eselon Selesai"</script>';

//upddate data refernsi

$sql3 = "exec proc_unitKerja";
$stmt3 = sqlsrv_query($conn,$sql3);




?>

</body>
</html>