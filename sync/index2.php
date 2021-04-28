<!DOCTYPE html>

<html>

<head>
<title>Sinkronisasi Data SDM</title>

<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
   <script src="https://code.jquery.com/jquery-1.10.2.js" integrity="sha256-it5nQKHTz+34HijZJQkpNBIHsjpV8b6QzMJs9tmOBSo=" crossorigin="anonymous"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <style>
  
  
  .ui-progressbar {
    position: relative;
  }
  .progress-label {
    position: absolute;
    left: 50%;
    top: 4px;
    font-weight: bold;
    text-shadow: 1px 1px 0 #fff;
  }
  
  .container {
    width: 400px;
    height: 100px;
    

    position: absolute;
    top:0;
    bottom: 0;
    left: 0;
    right: 0;

    margin: auto;
}
  </style>
  <script>
 /*
  $.ajax({
	
  xhr: function()
  {
    var xhr = new window.XMLHttpRequest();
    //Upload progress
    xhr.upload.addEventListener("progress", function(evt){
      if (evt.lengthComputable) {
        var percentComplete = evt.loaded / evt.total;
        //Do something with upload progress
		
        console.log(percentComplete);
      }
    }, false);
    //Download progress
    xhr.addEventListener("progress", function(evt){
      if (evt.lengthComputable) {
        var percentComplete = evt.loaded / evt.total;
        //Do something with download progress
	//	setTimeout( progress, percentComplete );
        console.log(percentComplete);
		
      }
    }, false);
    return xhr;
  },
  type: 'POST',
  url: "http://localhost:81/wsremunsetneg/loading.php",
  data: {},
  success: function(data){
  //alert(percentComplete);
      /*progressbar.progressbar({
      value: false,
      change: function() {
        progressLabel.text( progressbar.progressbar( "value" ) + "%" );
      },
      complete: function() {
        progressLabel.text( "Complete!" );
      }
    });
	
	$('#foo-bar').html(data);
  }
});
  */
  $( document ).ready(function() {
    $('#periode').hide();
});
 	  
	
	
	
	
  </script>
</head>

<body>

<div id="foo-bar"></div>

     <div class="container" style="text-align:center">
	 <img src="workgroup.png" title="Import Unit Kerja" style="cursor:pointer" id="unitKerja"> 
	 <img src="employee.png" title="Import Karyawan" style="cursor:pointer" id="importKaryawan"> 
	 <img src="employe_history2.png" title="Update History Karyawan" style="cursor:pointer" id="updateRiwayat">
	 <img src="search.png" title="Data Pegawai SIM SDM" style="cursor:pointer;width:80px;height:80px" id="cariPegawai">
		
	 <div id="status"></div>
	 <div id="periode" style="margin-top:20px">Pilih Periode : 
	  
			<select id="selectPeriode">
				<option value="0" selected>Pilih Periode</option>
				<option value="1">Januari</option>
				<option value="2">Februari</option>
				<option value="3">Maret</option>
				<option value="4">April</option>
				<option value="5">Mei</option>
				<option value="6">Juni</option>
				<option value="7">Juli</option>
				<option value="8">Agustus</option>
				<option value="9">September</option>
				<option value="10">Oktober</option>
				<option value="11">November</option>
				<option value="12">Desember</option>
			</select>
			&nbsp;&nbsp;
			<select id="selectYear">
			<option value="<?php echo date('Y')?>" selected><?php echo date('Y')?></option>
			<option value="<?php echo (date('Y')-1)?>" ><?php echo (date('Y')-1)?></option>
			</select>
			&nbsp;<button id="prosesPeriode">Proses</button>
		</div> 

	 </div>

	

<p>
</p>
<script type="text/javascript">
    $('#unitKerja').click(function() {
   
	$.ajax({
            xhr: function() {

                    var xhr = new window.XMLHttpRequest();
                    xhr.addEventListener("progress", function(e){
                        console.log(e.currentTarget.response);
                        $("#status").html(e.currentTarget.response);
                    });
                return xhr;

            }
            , type: 'post'
            , cache: false
            , url: "datapost.php"
        });

    });
	
	$('#importKaryawan').click(function() {
     $('#periode').show();
	
    });
	
	$('#cariPegawai').click(function() {
     window.location.href="karyawantmp.php?mode="+2;
	
    });
	
	$('#prosesPeriode').click(function() {
	var bulan = $('#selectPeriode').val();
	var tahun = $('#selectYear').val();
	//alert(tahun);
	$('#periode').hide();
	$.ajax({
            xhr: function() {

                    var xhr = new window.XMLHttpRequest();
                    xhr.addEventListener("progress", function(e){
                        console.log(e.currentTarget.response);
                        $("#status").html(e.currentTarget.response);
                    });
                return xhr;

            }
            , type: 'post'
            , cache: false
            , url: "remun4.php?periode="+bulan+"&tahun="+tahun
        });
		

	});
	
	$('#updateRiwayat').click(function() {
	//$('#periode').hide();
	$.ajax({
            xhr: function() {

                    var xhr = new window.XMLHttpRequest();
                    xhr.addEventListener("progress", function(e){
                        console.log(e.currentTarget.response);
                        $("#status").html(e.currentTarget.response);
                    });
                return xhr;

            }
            , type: 'post'
            , cache: false
            , url: "update_riwayat.php"
        });

	});
	

</script>
	 
	 </body>

</html>