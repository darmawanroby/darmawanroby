<head>
   <style>
h2 {
  margin-bottom: 50px;
}

.container {
  text-align: center;
  overflow: hidden;
  width: 800px;
  margin: 0 auto;
}

.container table {
  width: 100%;
}

.container td, .container th {
  padding: 10px;
}

.container td:first-child, .container th:first-child {
  padding-left: 20px;
}

.container td:last-child, .container th:last-child {
  padding-right: 20px;
}

.container th {
  border-bottom: 1px solid #ddd;
  position: relative;
}

	</style>
	<script type="text/javascript">
	(function(document) {
	'use strict';

	var LightTableFilter = (function(Arr) {

		var _input;

		function _onInputEvent(e) {
			_input = e.target;
			var tables = document.getElementsByClassName(_input.getAttribute('data-table'));
			Arr.forEach.call(tables, function(table) {
				Arr.forEach.call(table.tBodies, function(tbody) {
					Arr.forEach.call(tbody.rows, _filter);
				});
			});
		}

		function _filter(row) {
			var text = row.textContent.toLowerCase(), val = _input.value.toLowerCase();
			row.style.display = text.indexOf(val) === -1 ? 'none' : 'table-row';
		}

		return {
			init: function() {
				var inputs = document.getElementsByClassName('light-table-filter');
				Arr.forEach.call(inputs, function(input) {
					input.oninput = _onInputEvent;
				});
			}
		};
	})(Array.prototype);

	document.addEventListener('readystatechange', function() {
		if (document.readyState === 'complete') {
			LightTableFilter.init();
		}
	});

})(document);
	</script>
</head>
<body>


<?php



error_reporting(E_ALL);
ini_set('display_errors', 1);

$myServer = "localhost";

// SQL Server User that has permission to the database
$myUser = "rekabio";

// SQL Server User Password
$myPass = "Meinardi";

// Database
$myDB = "DataReal";

// Notice that the latest driver uses sqlsrv rather than mssql
$conn = sqlsrv_connect($myServer, array('UID'=>$myUser, 'PWD'=>$myPass, 'Database'=>$myDB));

 
		
$sql= "select [NIP],[NAMA],CONVERT(varchar(10), [TMT], 20) as TMT,[KODE_CABANG],[KODE_DEPARTEMEN],[KODE_JABATAN],[KODE_GOLONGAN],[KODE_INSTANSI],[KODE_UNIT],[KODE_DEPUTI],[KODE_BIRO],[KODE_BAGIAN],[KODE_SUBBAGIAN],[KODE_GRADE],[KODE_ESELON],[NIP_BARU],[JABATAN],[ID_JABATAN],[NO_URUT],[KET],[NPWP],[JPEG],[UM],CONVERT(varchar(10), [TGL_PENSIUN], 20) as TGL_PENSIUN,[STRUKTUR_BARU],[NEW_ORG] from taKaryawanTmp_json order by nama ASC";
$tmpKaryawan = sqlsrv_query($conn,$sql);
$resultTmpKaryawan = array();

do {
	while ($row = sqlsrv_fetch_array($tmpKaryawan, SQLSRV_FETCH_ASSOC)){
		$resultTmpKaryawan[] = $row;
	}
}while ( sqlsrv_next_result($tmpKaryawan) );

$jsonTmpKaryawan =  json_encode($resultTmpKaryawan);
$decodeTmpKayawan =  json_decode($jsonTmpKaryawan,TRUE);


 

ECHO "
<script src=\"jquery-1.10.2.min.js\"></script>
<SCRIPT TYPE=TEXT/JAVASCRIPT>
$(\"#progress\").hide();
$(\"#information\").hide();
</SCRIPT>";

echo "<style type=\"text/css\">    
            .pg-normal {
                color: black;
                font-weight: normal;
                text-decoration: none;    
                cursor: pointer;    
            }
            .pg-selected {
                color: black;
                font-weight: bold;        
                text-decoration: underline;
                cursor: pointer;
            }
			table {
    border-collapse: collapse;
}

table, td, th {
    border: 1px solid black;
}
        </style>";
        
        echo "<script type=\"text/javascript\" src=\"paging.js\"></script>";

echo "<section class=\"container\" style=\"overflow-x: scroll;width:100% \">";

echo "<input type=\"search\" class=\"light-table-filter\" data-table=\"order-table\" placeholder=\"Filter\" />";
echo "<table class=\"order-table\" id=\"results\" style=\"font:arial 10px\">
		<thead style=\"font-size:11px;font:arial\">
			<tr>
<th>NIP</th><th>NAMA</th><th>TMT</th><th>KODE_CABANG</th><th>KODE_DEPARTEMEN</th><th>KODE_JABATAN</th><th>KODE_GOLONGAN</th><th>KODE_INSTANSI</th><th>KODE_UNIT</th><th>KODE_DEPUTI</th><th>KODE_BIRO</th><th>KODE_BAGIAN</th><th>KODE_SUBBAGIAN</th><th>KODE_GRADE</th><th>KODE_ESELON</th><th>NIP_BARU</th><th>JABATAN</th><th>ID_JABATAN</th><th>NO_URUT</th><th>KET</th><th>NPWP</th><th>JPEG</th><th>UM</th><th>TGL_PENSIUN</th><th>STRUKTUR_BARU</th><th>NEW_ORG</th></tr>
		</thead>";

		
foreach ($decodeTmpKayawan as $i){
  echo "<tr style=\"font-size:11px;font:arial\"><td >".$i['NIP']."</td><td>".$i['NAMA']."</td><td>".$i['TMT']."</td><td>".$i['KODE_CABANG']."</td><td>".$i['KODE_DEPARTEMEN']."</td><td>".$i['KODE_JABATAN']."</td><td>".$i['KODE_GOLONGAN']."</td><td>".$i['KODE_INSTANSI']."</td><td>".$i['KODE_UNIT']."</td><td>".$i['KODE_DEPUTI']."</td><td>".$i['KODE_BIRO']."</td><td>".$i['KODE_BAGIAN']."</td><td>".$i['KODE_SUBBAGIAN']."</td><td>".$i['KODE_GRADE']."</td><td>".$i['KODE_ESELON']."</td><td>".$i['NIP_BARU']."</td><td>".$i['JABATAN']."</td><td>".$i['ID_JABATAN']."</td><td>".$i['NO_URUT']."</td><td>".$i['KET']."</td><td>".$i['NPWP']."</td><td>".$i['JPEG']."</td><td>".$i['UM']."</td><td>".$i['TGL_PENSIUN']."</td><td>".$i['STRUKTUR_BARU']."</td><td>".$i['NEW_ORG']."</td></tr>";
	 
  


// This is for the buffer achieve the minimum size in order to flush data
   // echo str_repeat(' ',1024*128);


// Send output to browser immediately
    flush();


// Sleep one second so we can see the delay
   // sleep(1);
}
echo "</table>";

echo "</section>";
ECHO "<div id=\"pageNavPosition\" style=\"font-size:11px;font:arial\"></div>";
echo "<a href=\"index2.php\"><< Back</a>";
echo "<script type=\"text/javascript\"><!--
        var pager = new Pager('results', 10); 
        pager.init(); 
        pager.showPageNav('pager', 'pageNavPosition'); 
        pager.showPage(1);
    //--></script>";


 
?>




 </body>
  
 
  