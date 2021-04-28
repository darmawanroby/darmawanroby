
<?php



error_reporting(E_ALL);
ini_set('display_errors', 1);

define("ENCRYPTION_KEY", "!@#$%^&*");

function encrypt($pure_string, $encryption_key) {
    $iv_size = mcrypt_get_iv_size(MCRYPT_BLOWFISH, MCRYPT_MODE_ECB);
    $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
    $encrypted_string = mcrypt_encrypt(MCRYPT_BLOWFISH, $encryption_key, utf8_encode($pure_string), MCRYPT_MODE_ECB, $iv);
    return $encrypted_string;
}

/**
 * Returns decrypted original string
 */
function decrypt($encrypted_string, $encryption_key) {
    $iv_size = mcrypt_get_iv_size(MCRYPT_BLOWFISH, MCRYPT_MODE_ECB);
    $iv = mcrypt_create_iv($iv_size, MCRYPT_RAND);
    $decrypted_string = mcrypt_decrypt(MCRYPT_BLOWFISH, $encryption_key, $encrypted_string, MCRYPT_MODE_ECB, $iv);
    return $decrypted_string;
}

//include('enkripsi.php');
$myServer = "localhost";

// SQL Server User that has permission to the database
$myUser = "rekabio";

// SQL Server User Password
$myPass = "Meinardi";

// Database
$myDB = "DataReal";

// Notice that the latest driver uses sqlsrv rather than mssql
$conn = sqlsrv_connect($myServer, array('UID'=>$myUser, 'PWD'=>$myPass, 'Database'=>$myDB));
/*
if( $conn ) {
     echo "Connection established.<br />";
}else{
     echo "Connection could not be established.<br />";
     die( print_r( sqlsrv_errors(), true));
}
*/


if(ISSET($_GET['indek'])){
   $kodeMasterData = $_GET['indek'];
  // echo $kodeMasterData;
   if($kodeMasterData=='1'){
		$sql = "select KODE_IJIN,KET_IJIN,PERHITUNGAN from taIjin where KODE_TIDAK_HADIR='1'";
		$command = sqlsrv_query($conn,$sql);
		$result = array();

		do {
			while ($row = sqlsrv_fetch_array($command,SQLSRV_FETCH_ASSOC)){
				$result[] = $row;
			}
		}while ( sqlsrv_next_result($command) );

		$json =  json_encode($result);

		echo $json;
		//echo $encrypted=encrypt($json,ENCRYPTION_KEY);
		echo "<br />";
		echo "<br />";
		//echo $decrypt=decrypt($encrypted,ENCRYPTION_KEY);
   }
   if($kodeMasterData=='2'){
		if(ISSET($_GET['tglAwal'],$_GET['tglAkhir'])){
		$tglAwal = $_GET['tglAwal'];
		
		$tglAkhir = $_GET['tglAkhir'];
		$sql = "select cast(day(TGL_LIBUR) as varchar) + '-' + 
        cast(month(TGL_LIBUR) as varchar) + '-' + 
        cast(year(TGL_LIBUR) as varchar) as TGL_LIBUR,KET_LIBUR from taLibur where TGL_LIBUR >='".$tglAwal."' AND TGL_LIBUR <='".$tglAkhir."'";
		$command = sqlsrv_query($conn,$sql);
		if( $command ) {
     	$result = array();

		do {
			while ($row = sqlsrv_fetch_array($command, SQLSRV_FETCH_ASSOC)){
				$result[] = $row;
			}
		}while ( sqlsrv_next_result($command) );

		$json =  json_encode($result);

		echo $json;

		}else{
			echo "Query Error.<br />";
			die( print_r( sqlsrv_errors(), true));
		}
	
		}
		
   }
   
   if($kodeMasterData=='3'){
		if(ISSET($_GET['nip'])){
			$nip = $_GET['nip'];
			$sql = "select NIP,KODE_IJIN,CONVERT(VARCHAR(10),TGL_AWAL,110) AS TGL_AWAL,CONVERT(VARCHAR(10),TGL_AKHIR,110) AS TGL_AKHIR,JATAH_IJIN,CONVERT(VARCHAR(10),TGL_BERLAKU,110) AS TGL_BERLAKU,CONVERT(VARCHAR(10),EXPIRED,110) AS EXPIRED,DIAMBIL,TIDAK_DIAMBIL,SISA_IJIN from taJatahIjin where SISA_IJIN>0 AND NIP='".$nip."'";
			$command = sqlsrv_query($conn,$sql);
			if( $command ) {
			$result = array();

			do {
				while ($row = sqlsrv_fetch_array($command, SQLSRV_FETCH_ASSOC)){
					$result[] = $row;
				}
			}while ( sqlsrv_next_result($command) );

			$json =  stripslashes(json_encode($result));

			echo $json;

			}else{
				echo "Query Error.<br />";
				die( print_r( sqlsrv_errors(), true));
			}
		}
	
		
		
		else{
			$sql = "select NIP  ,KODE_IJIN,CONVERT(VARCHAR(10),TGL_AWAL,110) AS TGL_AWAL,CONVERT(VARCHAR(10),TGL_AKHIR,110) AS TGL_AKHIR,JATAH_IJIN,CONVERT(VARCHAR(10),TGL_BERLAKU,110) AS TGL_BERLAKU,CONVERT(VARCHAR(10),EXPIRED,110) AS EXPIRED,DIAMBIL,TIDAK_DIAMBIL,SISA_IJIN from taJatahIjin where SISA_IJIN>0";
			$command = sqlsrv_query($conn,$sql);
			if( $command ) {
				$result = array();

				do {
					while ($row = sqlsrv_fetch_array($command, SQLSRV_FETCH_ASSOC)){
						$result[] = $row;
					}
				}while ( sqlsrv_next_result($command) );

				$json =  stripslashes(json_encode($result));

				echo $json;

			}
			else{
				echo "Query Error.<br />";
				die( print_r( sqlsrv_errors(), true));
			}
	
		}
		}
		
   
   
   if($kodeMasterData=='4'){
		if(ISSET($_GET['nip'],$_GET['tgl_jatah'])){
			$nip = $_GET['nip'];
			$tgl_jatah = $_GET['tgl_jatah'];
			$sql = "select NIP,KODE_IJIN,CONVERT(VARCHAR(10),TGL_JATAH,110) AS TGL_JATAH, CONVERT(VARCHAR(10),TGL_PROSES,110) AS TGL_PROSES,KODE_JATAH,JML_HARI,CONVERT(VARCHAR(10),WAKTU_SIMPAN,110) AS WAKTU_SIMPAN FROM taJatahIjinDetail WHERE TGL_JATAH ='".$tgl_jatah."' AND NIP='".$nip."'";
			$command = sqlsrv_query($conn,$sql);
			if( $command ) {
			$result = array();

			do {
				while ($row = sqlsrv_fetch_array($command, SQLSRV_FETCH_ASSOC)){
					$result[] = $row;
				}
			}while ( sqlsrv_next_result($command) );

			$json =  stripslashes(json_encode($result));

			echo $json;

			}else{
				echo "Query Error.<br />";
				die( print_r( sqlsrv_errors(), true));
			}
		}
	
		
		
		/*else{
			$sql = "select NIP  ,KODE_IJIN,CONVERT(VARCHAR(10),TGL_AWAL,110) AS TGL_AWAL,CONVERT(VARCHAR(10),TGL_AKHIR,110) AS TGL_AKHIR,JATAH_IJIN,CONVERT(VARCHAR(10),TGL_BERLAKU,110) AS TGL_BERLAKU,CONVERT(VARCHAR(10),EXPIRED,110) AS EXPIRED,DIAMBIL,TIDAK_DIAMBIL,SISA_IJIN from taJatahIjin where SISA_IJIN>0";
			$command = sqlsrv_query($conn,$sql);
			if( $command ) {
				$result = array();

				do {
					while ($row = sqlsrv_fetch_array($command, SQLSRV_FETCH_ASSOC)){
						$result[] = $row;
					}
				}while ( sqlsrv_next_result($command) );

				$json =  stripslashes(json_encode($result));

				echo $json;

			}
			else{
				echo "Query Error.<br />";
				die( print_r( sqlsrv_errors(), true));
			}
	
		}*/
		}
		
}



?>




 
  
 
  