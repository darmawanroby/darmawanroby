<?php
$myServer = "localhost";

// SQL Server User that has permission to the database
$myUser = "rekabio";

// SQL Server User Password
$myPass = "Meinardi";

// Database
$myDB = "DataReal";

// Notice that the latest driver uses sqlsrv rather than mssql
$conn = sqlsrv_connect($myServer, array('UID'=>$myUser, 'PWD'=>$myPass, 'Database'=>$myDB));







//exec proc_compare_karyawantmp
$sql = "exec proc_compare_karyawantmp";
$stmt = sqlsrv_query($conn,$sql);

if( $stmt === false ) {
    if( ($errors = sqlsrv_errors() ) != null) {
        foreach( $errors as $error ) {
            echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
            echo "code: ".$error[ 'code']."<br />";
            echo "message: ".$error[ 'message']."<br />";
        }
    }
}


 
else
{
    //echo "Update Riwayat Karyawan Berhasil";
}


//exec proc_compare_karyawan
$sql2 = "exec proc_compare_karyawan";
$stmt2 = sqlsrv_query($conn,$sql2);

if( $stmt2 === false ) {
    if( ($errors = sqlsrv_errors() ) != null) {
        foreach( $errors as $error ) {
            echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
            echo "code: ".$error[ 'code']."<br />";
            echo "message: ".$error[ 'message']."<br />";
        }
    }
}


 
else
{
    //echo "Update Riwayat Karyawan Berhasil";
}

//exec proc_compare_riwayat_karyawan
$sql3 = "exec proc_compare_riwayat_karyawan";
$stmt3 = sqlsrv_query($conn,$sql3);

if( $stmt2 === false ) {
    if( ($errors = sqlsrv_errors() ) != null) {
        foreach( $errors as $error ) {
            echo "SQLSTATE: ".$error[ 'SQLSTATE']."<br />";
            echo "code: ".$error[ 'code']."<br />";
            echo "message: ".$error[ 'message']."<br />";
        }
    }
}


 
else
{
    //echo "Update Riwayat Karyawan Berhasil";
}

sqlsrv_close( $conn);
echo "Update Riwayat Karyawan Berhasil";
//echo "Connection closed.\n";
//$proc = sqlsrv_init('proc_compare_karyawantmp', $conn);
//$proc_result = sqlsrv_execute($proc);


?>