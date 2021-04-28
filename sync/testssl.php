<?php # OpenSSL_HTTPS_fopen_with_CA.php
#- Copyright (c) 2011, HerongYang.com, All Rights Reserved.
#
$script = array_shift($argv);
$url = array_shift($argv);

$context = stream_context_create(array(
    'ssl' => array(
        'verify_peer' => false
        //'cafile' => 'CA_Bundle.crt' 
    )
));

$handle = file_get_contents('https://simsdm.setneg.go.id/proses/integrasi/wsremunerasi.php/11/2015/remun@dktu99', 'r', false, $context);
//while ( ($line = fgets($handle)) !== false) {
  //echo "$line\n";

?>