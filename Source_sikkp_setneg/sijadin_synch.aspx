<%@ Page  Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="sijadin_synch.aspx.cs" Inherits="sijadin_synch" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto"%>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <link href="assets/dataTables.bootstrap4.min.css" rel="stylesheet"/>
<link href="assets/bootstrap.css" rel="stylesheet"/>
    <link href="assets/jquery-ui.css" rel="stylesheet"/>
    <link href="assets/bootstrap-datepicker.css" rel="stylesheet"/>
    <div class="card col-lg-12">
          <div class="card-header">
            Penarikan
          </div>
      <div class="card-body">
          <div class="row">
              <div class="col">
            <div class="form-group">
                
                <input type="text" id="tglAwal"   class="form-control datepicker" placeholder="Masukan Tanggal Awal" >

          </div>
        </div>
     <%--   <div class="col">
            <div class="form-group">
                <input type="text" id="tglAkhir"  class="form-control datepicker" placeholder="Masukan Tanggal Akhir" >
            </div>
        </div>--%>
      <div class="col">
          <input type="button" class="btn btn-primary" value="tarik" id="btnTarik" />          
          <input type="button" class="btn btn-primary" value="Proses" id="btnProses" />
      </div>    
     <div class=" col-lg-10">
           <div class="progress">
                <div class="progress-bar" id="progSynch" role="progressbar" aria-valuenow="90" aria-valuemin="0" aria-valuemax="100"></div>
         </div>
     </div>
              <div class="col-lg-2">
                  <label id="persen">0%</label>
              </div>
     </div>

            
      </div>
</div>
    <br />
    <div class="card col-lg-12">
        <div class="card-header">
            Log Proses
        </div>
        <div class="card-body">

        </div>
    </div>
    <br />
    <div class="card col-lg-12">
        <div class="card-header bg-primary">
            Tabel
        </div>
        <div class="card-body">
                <table class="table" width="100%" cellpadding="3" id="tableFilter" style="font-size:12px">
    <tr>
        <td>Tanggal</td>
        <td>:</td>
        <td >                <input type="text" id="tglAwalTbl"  class="form-control datepicker" placeholder="Masukan Tanggal Awal" ></td>
         <td >                <input type="text" id="tglAkhirTbl"  class="form-control datepicker" placeholder="Masukan Tanggal Akhir" ></td>
    </tr>
    <tr>
        <td>Deputi/Biro</td>
        <td>:</td>
        <td colspan="2"><select id="ddlBiro" class="form-control" style="font-size:12px"></select></td>
    </tr>
    <tr>
        <td>Biro/Bagian/Bidang</td>
        <td>:</td>
        <td colspan="2"> <select id="ddlBagian" class="form-control" style="font-size:12px"></select></td>
    </tr>
                    <tr>
                        <td colspan="4"><input type="button" class="btn btn-danger" value="Tampilkan" id="btnTampilkan" /></td>
                    </tr>
    

    </table>
            <table class="table table-responsive-lg " id="tblSijadin">
                <thead>
                     <tr>
                    <th>NIP</th>
                    <th>Nama</th>
                    <th>Tgl. Awal</th>
                    <th>Tgl. Akhir</th>
                    <th>No. Surat</th>
                </tr>
                </thead>
               
            </table>
        </div>
    </div>
    <script src="assets/jquery-3.3.1.js"></script>
     <script src="assets/jquery-ui.js"></script>
    <script src="assets/bootstrap-datepicker.js"></script>
    <script src="assets/jquery.dataTables.min.js"></script>
     <script src="assets/dataTables.bootstrap4.min.js"></script>

    <script type="text/javascript">
        
        var i = 0;
        var dataMasuk = 0;
        function move(count) {
            var elem = document.getElementById("progSynch");
            var persen = document.getElementById("persen");
            elem.style.width = "";
            var countTemp = 0;
            if (count < 100) {
                countTemp = count / 10;
            } else {
                countTemp = (100 / count) / 3;

            }

            //alert(countTemp);
            var width = 0;
            var id = setInterval(frame, countTemp);
            function frame() {
                if (width >= 100) {
                    clearInterval(id);
                    dataMasuk = 0;
                    // alert("test");
                } else {
                    if (dataMasuk % countTemp == 0) {
                        width++;
                        elem.style.width = width + "%";
                        persen.innerHTML = width + "%";
                    }   
                }
            }
        }
        $(function () {

            $(".datepicker").datepicker({
                format: 'dd/mm/yyyy',
                autoclose: true,
                todayHighlight: true,
            });
            $("#tglAwal").val(getDateNow());
            $("#tglAkhir").val(getDateNow());
            $("#tglAwalTbl").val(getDateNow());
            $("#tglAkhirTbl").val(getDateNow());
            $.post("Api/sijadin.aspx?paramurl=ddlBiro", function (data) {
                $("#ddlBiro").empty();
                $("#ddlBiro").append(data);
                $.post("Api/sijadin.aspx?paramurl=ddlBagian", { kodeBiro: $("#ddlBiro").val() }, function (data) {
                    $("#ddlBagian").empty();
                    $("#ddlBagian").append(data);
                    generateTable();
                });
            });
            $("#ddlBiro").change(function () {
                $.post("Api/sijadin.aspx?paramurl=ddlBagian", { kodeBiro: $("#ddlBiro").val() }, function (data) {
                    $("#ddlBagian").empty();
                    $("#ddlBagian").append(data);
                   // generateTable();
                });
            });
            $("#btnTampilkan").click(function () {
                $('#tblSijadin').DataTable().ajax.reload();
            });
            $("#btnProses").click(function () {
                $.post("Api/sijadin.aspx?paramurl=synchSijadin", function (callback) {
                    alert(callback);
                });
            });
            $("#btnTarik").click(function () {
               var url = "Api/sijadin.aspx?paramurl=aksesSijadin&tgl_awal=" + convertDate($("#tglAwal").val());
                //var url = "Api/sijadin2.xml";
                $.ajax({
                    url: url, type: "GET", dataType: "xml",
                    error: function (e) {
                        alert("An error occurred while processing XML file");
                        console.log("XML reading Failed: ", e);
                    },
                    success: function (data) {
                        
                        deletejadin();
                       // move($(data).find("entrypd").length);
                        var elem = document.getElementById("progSynch");
                        var persen = document.getElementById("persen");
                        var countTemp = $(data).find("entrypd").length / 100;
                        
                        var countData = 0;
                        var width = 0;
                        if (countTemp < 100) {
                            width = 10;
                        }
                        var banyakRequest = 0;
                        elem.style.width = "";
                        $(data).find("entrypd").each(function () {
                            $.post("Api/sijadin.aspx?paramurl=synch", { nip: $(this).find('username').text(), tgl_awal: $(this).find('berangkat_tgl').text() + ":00", tgl_akhir: $(this).find('kembali_tgl').text() + ":00", no_sprin: $(this).find('sprin_no').text() }, function (callback) {
                                banyakRequest++;
                                if (callback != "") {
                                    countData++;
                                    if (countData % Math.ceil(countTemp) == 0) {
                                        if (width <= 100) {
                                            if (countTemp < 100) {
                                                if (width <= 99) {
                                                    width = width + 10;
                                                }

                                            } else {
                                                width++;
                                            }
                                            
                                            elem.style.width = width + "%";
                                            persen.innerHTML = width + "%";
                                        }

                                    }
                                }
                                if ((banyakRequest == $(data).find("entrypd").length)) {
                                    elem.style.width = "100%";
                                    persen.innerHTML = "100%";
                                    setTimeout(function () {
                                        elem.style.width = "";
                                        persen.innerHTML = "0%";
                                    },10000);
                                }
                                
                            });
                        });
                    }

                });
            });
            function deletejadin() {
                $.post("Api/sijadin.aspx?paramurl=deleteSijadin", { tgl_awal: convertDate($("#tglAwal").val())}, function (callback) {
                    console.log(callback);
                });
            }
            function setKolom() {
                return [{ "data": "NIP" }, { "data": "NAMA" }, { "data": "TGL_AWAL" }, { "data": "TGL_AKHIR" }, { "data": "NO_SPRIN" }];
            }
            function generateTable() {
                $('#tblSijadin').DataTable({
                    "processing": true,
                    "serverSide": true,
                    "ajax": {
                        "url": "Api/sijadin.aspx?paramurl=tableSijadin", "type": "POST",
                        "data": function (d) {
                            d.tglAwal = convertDate($("#tglAwalTbl").val());
                            d.tglAkhir = convertDate($("#tglAkhirTbl").val());
                            d.ddlBiro = $("#ddlBiro").val();
                            d.ddlBagian = $("#ddlBagian").val();
                         }
                     },
                    "searching": false, "order": [[0, 'desc']],
                    "columns": setKolom()
                 });
            }
            function convertDate(inputFormat) {
                var hasilTgl = inputFormat.split("/");
                return hasilTgl[2] + "-" + hasilTgl[1] + "-" + hasilTgl[0];
            }
            function getDateNow() {
                var d = new Date();

                var month = d.getMonth() + 1;
                var day = d.getDate();

                //var output = d.getFullYear() + '/' +
                //    (month < 10 ? '0' : '') + month + '/' +
                //    (day < 10 ? '0' : '') + day;
                var output = (day < 10 ? '0' : '') + day + '/' +
                    (month < 10 ? '0' : '') + month + '/' +
                    d.getFullYear();
                return output;
            }
        });
    </script>
</asp:Content>

