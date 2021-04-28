<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="wfh_schedule.aspx.cs" Inherits="rtwin.wfhschedule" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <asp:ScriptManager id="ScriptManager1" runat="server"></asp:ScriptManager>

    <script src="assets/jquery-3.3.1.js"></script>
     <script src="assets/jquery-ui.js"></script>
    <script src="assets/bootstrap-datepicker.js"></script>
    <script src="assets/jquery.dataTables.min.js"></script>
     <script src="assets/dataTables.bootstrap4.min.js"></script>
  
<link href="assets/dataTables.bootstrap4.min.css" rel="stylesheet"/>
<link href="assets/bootstrap.css" rel="stylesheet"/>
    <link href="assets/jquery-ui.css" rel="stylesheet"/>
    <link href="assets/bootstrap-datepicker.css" rel="stylesheet"/>
    

<table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="backgroundTitle" style="width: 200px">
                <img src="images/back_title.gif" height="27px" style="vertical-align:middle" alt=""/>&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
            </td>
        </tr>
    </table><br />
    <table width="100%" cellpadding="3" id="tableFilter" style="font-size:12px">
    <tr>
        <td>Bulan</td>
        <td>:</td>
        <td><select id="blnFilter" runat=server style="width:130px;display:inline-block;font-size:12px"  class="form-control input-sm" />&nbsp;&nbsp;&nbsp;Tahuh&nbsp;:&nbsp;<select id="thnFilter" runat=server style="width:90px;display:inline-block;font-size:12px"  class="form-control input-sm" /> &nbsp;&nbsp;<a href="#" class="btn btn-primary btn-sm"  id="filterDataWfh">Tampilkan </a> </td>
        <td></td>

    </tr>
    <tr>
        <td>NIP/Nama</td>
        <td>:</td>
        <td colspan="2"> <input type="text" class="form-control input-sm"  placeholder="Nama Pegawai" id="namaPegawai" style="display:inline-block;font-size:12px" /></td>
    </tr>
    <tr>
        <td>Deputi/Biro</td>
        <td>:</td>
        <td colspan="2"><select id="ddlDeputi" class="form-control" style="font-size:12px"></select></td>
    </tr>
    <tr>
        <td>Biro/Bagian/Bidang</td>
        <td>:</td>
        <td colspan="2"> <select id="ddlBiro" class="form-control" style="font-size:12px"></select></td>
    </tr>
    

    </table>
    <br />
     <table width="100%" cellpadding="3" id="tblForm" style="font-size:12px">
                <tr>
                    <td>NAMA</td>
                    <td>:</td>
                    <td> <input type="text" class="form-control input-sm"  placeholder="Nama Pegawai" id="namaPegawaiInputEdit" style="display:inline-block;font-size:12px" /></td>
                </tr>
                <tr>
                    <td>NIK/NIP</td>
                    <td>:</td>
                    <td> <label id="nip"></label></td>
                </tr>
                   <tr>
                    <td>Pangkat/Golongan</td>
                    <td>:</td>
                    <td> <label id="lblPangkat"></label></td>
                </tr>
                 <tr>
                    <td>Jabatan</td>
                    <td>:</td>
                    <td> <label id="lblJabatan"></label></td>
                </tr>
				 <tr id="rowBulan">
                    <td>Bulan</td>
                    <td>:</td>
                    <td> <label id="lblBulan"></label></td>
                </tr>
				 <tr id="rowTahun">
                    <td>Tahun</td>
                    <td>:</td>
                    <td> <label id="lblTahun"></label></td>
                </tr>
                 <tr>
                    <td>Jadwal WFH</td>
                    <td>:</td>
                    <td> <input type ="text" id="jadwalWfh" class="form-control input-sm" style="font-size:12px"/></td>
                </tr>
                <tr>
                    <td colspan="3"><input type ="text" id="mode" class="form-control input-sm" style="font-size:12px;display:none"/><label id="bulan" style="display:none"></label><label id="tahun" style="display:none"></label></td>
                </tr>
                </table><br />

    <table border="0" cellpadding="0" class="border_table" cellspacing="0" width="100%">
        <tr>
            <td align="left" style="width: 90%">
            

                <div style="width:100%;border:5px">
               <p>  <a href="#" class="btn btn-primary btn-sm"  id="tambahWfh">Tambah </a>  <a href="#" class="btn btn-primary btn-sm"  id="SimpanWfh">Simpan </a> &nbsp;&nbsp;&nbsp;<a href="#" class="btn btn-primary btn-sm"  id="cancel">Cancel </a>
                
               </p>
							 <table class="table" id="tblWFH" width="150%" style="font-size:12px">
                        <thead>
                           <tr>
                              <th>NIK</th>
                              <th>NAMA</th>
                              <th>PANGKAT/GOLONGAN</th>
                              <th>JABATAN</th>
                              <th>JADWAL_WFH</th>
                              <th>STATUS</th>
                              <th style="width:150px">ACTION</th>

                               
                           </tr>
                        </thead>
                        <tbody>
                           
                        </tbody>
                     </table>
                     </div>
						</td>
                        </tr>
                </table><br />
                <table>
                <tr><td><a href="#" class="btn btn-primary btn-sm"  id="prosesWfh">Proses </a></td></tr>
                </table>

              
               
          
      
      <script type="text/javascript">


          jQuery(document).ready(function () {
              $("#jadwalWfh").datepicker({
                  format: 'd',
                  inline: false,
                  lang: 'en',
                  // step: 5,
                  multidate: true,
                  closeOnDateSelect: false

              });

              $("#tblForm").hide();
              $("#SimpanWfh").hide();
              $("#cancel").hide();

              //tambah wfh
              $("#tambahWfh").click(function () {
                  // alert();
                  $("#tableFilter").hide();

                  $("#tambahWfh").hide();
                  $("#tblForm").show();
                  $("#SimpanWfh").show();
                  $("#cancel").show();
                  $("#jadwalWfh").val('');
                  $("#namaPegawaiInputEdit").val('');
                  $("#jadwalWfh").each(function () {
                      $(this).datepicker('setDate', $(this).val());
                  });
                  $("#mode").val('1');
                  $("#bulan").text($("#ctl00_cphWithMenu_blnFilter").val());
                  $("#tahun").text($("#ctl00_cphWithMenu_thnFilter").val());
				        $("#lblBulan").show();
				    $("#lblTahun").show();
					$("#rowBulan").show();
				    $("#rowTahun").show();
				  $("#lblBulan").text($("#ctl00_cphWithMenu_blnFilter option:selected").text());
				   $("#lblTahun").text($("#ctl00_cphWithMenu_thnFilter option:selected").text());
                  $("#nip").text("");
              });
              $("#cancel").click(function () {
                  // alert();
                  $("#tableFilter").show();

                  $("#tambahWfh").show();
                  $("#tblForm").hide();
                  $("#SimpanWfh").hide();
                  $("#cancel").hide();

              });


              $("#namaPegawai").autocomplete({
                  minLength: 3,
                  source: 'control.aspx?paramUrl=autocompleteNIP',
                  select: function (event, ui) {
                      $("#namaPegawai").val(ui.item.NIP);
                      return false;
                  }
              })
            .data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                .data("item.autocomplete-item", item)
                 .append("<a>" + item.NAMA + "-" + item.NIP + "</a>")
                 .appendTo(ul);
            };
              $("#namaPegawaiInputEdit").autocomplete({
                  minLength: 3,
                  source: 'control.aspx?paramUrl=autocompleteNIP',
                  select: function (event, ui) {
                      $("#namaPegawaiInputEdit").val(ui.item.NAMA);
                      $("#nip").text(ui.item.NIP);
                      $("#lblPangkat").text(ui.item.NAMA_GOLONGAN);
                      $("#lblJabatan").text(ui.item.NAMA_JABATAN);
                      return false;
                  }
              })
            .data("ui-autocomplete")._renderItem = function (ul, item) {
                return $("<li>")
                .data("item.autocomplete-item", item)
                 .append("<a>" + item.NAMA + "-" + item.NIP + "</a>")
                 .appendTo(ul);
            };

              $("#jadwal").datepicker({
                  format: 'd',
                  inline: false,
                  lang: 'en',
                  step: 5,
                  multidate: true,
                  closeOnDateSelect: true
              });

              $.ajax({
                  type: "POST",
                  url: "control.aspx?paramUrl=dsDeputi",
                  data: "{}",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (data) {
                      var toAppend = '';
                      $.each(data, function (i, o) {
                          toAppend += '<option value=' + o.KODE_DEPUTI + '>' + o.NAMA_DEPUTI + '</option>';
                      });

                      $('#ddlDeputi').append(toAppend);
                  }
              });

              $.ajax({
                  type: "POST",
                  url: "control.aspx?paramUrl=dsBiro&kodeDeputi=000",
                  data: "{}",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  success: function (data) {
                      var toAppend = '';
                      $.each(data, function (i, o) {
                          toAppend += '<option value=' + o.KODE_BIRO + '>' + o.NAMA_BIRO + '</option>';
                      });

                      $('#ddlBiro').append(toAppend);
                  }
              });

              $('#ddlDeputi').change(function () {
                  var kodeDeputi = $('#ddlDeputi').val();
                  if (kodeDeputi !== "null") {
                      $.ajax({
                          type: "POST",
                          url: "control.aspx?paramUrl=dsBiro&kodeDeputi=" + kodeDeputi,
                          //"destroy": true,
                          data: { kodeDeputi: kodeDeputi },
                          contentType: "application/json; charset=utf-8",
                          dataType: "json",
                          success: function (data) {
                              $('#ddlBiro').empty();
                              var toAppend = '';
                              $.each(data, function (i, o) {
                                  toAppend += '<option value=' + o.KODE_BIRO + '>' + o.NAMA_BIRO + '</option>';
                              });

                              $('#ddlBiro').append(toAppend);
                          }
                      });
                  }
                  else {
                      $.ajax({
                          type: "POST",
                          url: "control.aspx?paramUrl=dsBiro&kodeDeputi=",
                          //"destroy": true,
                          // data: {kodeBiro:kodeBiro},
                          contentType: "application/json; charset=utf-8",
                          dataType: "json",
                          success: function (data) {
                              $('#ddlBiro').empty();
                              var toAppend = '';
                              $.each(data, function (i, o) {
                                  toAppend += '<option value=' + o.KODE_BIRO + '>' + o.NAMA_BIRO + '</option>';
                              });

                              $('#ddlBiro').append(toAppend);
                          }
                      });
                  }
              });




              //DATA TABLE
              $('#tblWFH_filter input').addClass('form-control input-sm ui-autocomplete-input');
              $('#tblWFH_filter input').css({ "width": "250px" }, { "font-size": "12px" });
              $('#tblWFH_length select').addClass('form-control input-sm ui-autocomplete-input');


              //parameter filter data table
              var bulan = $("#ctl00_cphWithMenu_blnFilter").val();
              var tahun = $("#ctl00_cphWithMenu_thnFilter").val();
              var kodedeputi = $('#ddlDeputi').val();
              var kodebiro = $('#ddlBiro').val();
              var nip = $("#namaPegawai").val();

              $("#filterDataWfh").click(function () {
                  var bulan = $("#ctl00_cphWithMenu_blnFilter").val();
                  var tahun = $("#ctl00_cphWithMenu_thnFilter").val();
                  var kodedeputi = $('#ddlDeputi').val();
                  var kodebiro = $('#ddlBiro').val();
                  var nip = $("#namaPegawai").val();

                  $('#tblWFH').dataTable({
                      "ajax": "control.aspx?paramUrl=dsWFH&bulan=" + bulan + "&tahun=" + tahun + "&nip=" + nip + "&kodebiro=" + kodebiro + "&kodedeputi=" + kodedeputi,
                      "type": "POST",
                      "destroy": true,
                      "bPaginate": true,
                      "bLengthChange": false,
                      "bFilter": true,
                      "bInfo": false,
                      //"data": { nip: nip, kodebiro: kodebiro, kodedeputi: kodedeputi,bulan:bulan,tahun:tahun },
                      // dataType: "json",
                      "recordsFiltered": 10,
                      "columns": [
                        { "data": "NIP", "orderable": false },
                         { "data": "NAMA" },

                        { "data": "NAMA_GOLONGAN", "orderable": false },
                        { "data": "JABATAN" },
                        { "data": "JADWAL_WFH", "orderable": false },
                        { "data": "STATUS_JADWAL", "orderable": false },
                         {
                             data: null,
                             className: "center",
                             "orderable": false,
                             // "width": "1%",
                             render: function (data, type, row) {
                                 return '<a href="#" class="btn btn-primary btn-sm"     nip="' + row.NIP + '" nama="' + row.NAMA + '" golongan="' + row.NAMA_GOLONGAN + '" jabatan="' + row.JABATAN + '" jadwal ="' + row.JADWAL_WFH + '" tahun="' + row.TAHUN + '" bulan="' + row.BULAN + '">Edit  </a>&nbsp;<a href="#" class="btn btn-danger btn-sm"  tahun="' + row.TAHUN + '" nip="' + row.NIP + '" bulan="' + row.BULAN + '">Delete <i class="icon-remove"></i></a>'
                             }

                         }

                        ],
                      "language": {
                          "search": "Cari :"
                      },
                      "destroy": true

                  });
              });

              $('#tblWFH').dataTable({
                  "ajax": "control.aspx?paramUrl=dsWFH&bulan=" + bulan + "&tahun=" + tahun + "&nip=" + nip + "&kodebiro=0000&kodedeputi=000",
                  "type": "POST",
                  "destroy": true,
                  "bPaginate": true,
                  "bLengthChange": false,
                  "bFilter": true,
                  "bInfo": false,
                  //"data": { nip: nip, kodebiro: kodebiro, kodedeputi: kodedeputi,bulan:bulan,tahun:tahun },
                  // dataType: "json",
                  "recordsFiltered": 10,
                  "columns": [
                        { "data": "NIP", "orderable": false },
                         { "data": "NAMA" },

                        { "data": "NAMA_GOLONGAN", "orderable": false },
                        { "data": "JABATAN" },
                        { "data": "JADWAL_WFH", "orderable": false },
                        { "data": "STATUS_JADWAL", "orderable": false },
                         {
                             data: null,
                             className: "center",
                             "orderable": false,
                             // "width": "1%",
                             render: function (data, type, row) {
                                 return '<a href="#" class="btn btn-primary btn-sm"     nip="' + row.NIP + '" nama="' + row.NAMA + '" golongan="' + row.NAMA_GOLONGAN + '" jabatan="' + row.JABATAN + '" jadwal ="' + row.JADWAL_WFH + '" tahun="' + row.TAHUN + '" bulan="' + row.BULAN + '">Edit  </a>&nbsp;<a href="#" class="btn btn-danger btn-sm"  tahun="' + row.TAHUN + '" nip="' + row.NIP + '" bulan="' + row.BULAN + '">Delete <i class="icon-remove"></i></a>'
                             }

                         }

                        ],
                  "language": {
                      "search": "Cari :"
                  },
                  "destroy": true

              });

              //PROSES WFH
              $("#prosesWfh").click(function () {
                  //  blnFilter
                  var bulan = $("#ctl00_cphWithMenu_blnFilter").val();
                  var tahun = $("#ctl00_cphWithMenu_thnFilter").val()

                  $.ajax({
                      type: "POST",
                      url: "control.aspx?paramUrl=prosesWfh",
                      data: { bulan: bulan, tahun: tahun },
                      //contentType: "application/json; charset=utf-8",
                      //dataType: "json",
                      success: function (data) {
                          //alert(data);
                          $('#tblWFH').DataTable().ajax.reload();
                      }
                  });
              });

              //fungsi insert edit delete datatable
              $("#SimpanWfh").click(function () {
                  var nip = $("#nip").text();
                  var mode = $("#mode").val();
                  var jadwal = $("#jadwalWfh").val();
                  var bulan = $("#bulan").text();
                  var tahun = $("#tahun").text();
                  //alert(jadwal);
                  $.ajax({
                      type: "POST",
                      url: "control.aspx?paramUrl=simpanJadwalWfh",
                      data: { nip: nip, mode: mode, jadwal: jadwal, bulan: bulan, tahun: tahun },
                      //contentType: "application/json; charset=utf-8",
                      //dataType: "json",
                      success: function (data) {
                          //alert(data);
                          $('#tblWFH').DataTable().ajax.reload();
                      }
                  });


              });
              $('#tblWFH').on("click", "a.btn.btn-danger.btn-sm", function () {
                  if (confirm("Yakin Akan Dihapus ?")) {
                      var nip = $(this).attr("nip");
                      var bulan = $(this).attr("bulan");
                      var tahun = $(this).attr("tahun");
                      //alert(nip + "bulan" + bulan + "tahun" + tahun);
                      var mode = "3";
                      $.ajax({
                          type: "POST",
                          url: "control.aspx?paramUrl=simpanJadwalWfh",
                          data: { nip: nip, bulan: bulan, tahun: tahun, mode: mode },
                          success: function (data) {
                              // alert(data);
                              $('#tblWFH').DataTable().ajax.reload();
                          }
                      });
                  }
              });

              $('#tblWFH').on("click", "a.btn.btn-primary.btn-sm", function () {
                   $("#lblBulan").hide();
				    $("#lblTahun").hide();
				   $("#rowBulan").hide();
				    $("#rowTahun").hide();
					$("#cancel").show();
                  var nama = $(this).attr("nama");
                  var nip = $(this).attr("nip");
                  var bulan = $(this).attr("bulan");
                  var tahun = $(this).attr("tahun");
                  var jadwal = $(this).attr("jadwal");
                  var golongan = $(this).attr("golongan");
                  var jabatan = $(this).attr("jabatan");
                  var bulan = $(this).attr("bulan");
                  var tahun = $(this).attr("tahun");

                  $("#namaPegawaiInputEdit").val(nama);
                  $("#jadwalWfh").val(jadwal)
                  $("#nip").text(nip);
                  $("#lblPangkat").text(golongan);
                  $("#lblJabatan").text(jabatan);
                  $("#bulan").text(bulan);
                  $("#tahun").text(tahun);
                  $("#mode").val(2);

                  $("#tableFilter").hide();

                  $("#tambahWfh").hide();
                  $("#tblForm").show();
                  $("#SimpanWfh").show();
              });


          });

                </script>
</asp:Content>



