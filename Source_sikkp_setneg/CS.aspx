﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CS.aspx.cs" Inherits="CS" %>

 
  <asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
  <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="backgroundTitle" style="width: 200px">
                 
            </td>
        </tr>
    </table>

    <asp:GridView ID="GridView1" HeaderStyle-BackColor="#3AC0F2" HeaderStyle-ForeColor="White"
        RowStyle-BackColor="#A1DCF2" AlternatingRowStyle-BackColor="White" AlternatingRowStyle-ForeColor="#000"
        runat="server" AutoGenerateColumns="false" AllowPaging="true" OnPageIndexChanging="OnPageIndexChanging">
        <Columns>
            <asp:BoundField DataField="PIN" HeaderText="PIN" ItemStyle-Width="150px" />
            <asp:BoundField DataField="NIP" HeaderText="NIP" ItemStyle-Width="150px" />
            <asp:BoundField DataField="NIP_BARU" HeaderText="NIP_BARU" ItemStyle-Width="150px" />
            <asp:BoundField DataField="NAMA" HeaderText="NAMA" ItemStyle-Width="350px" />
            <asp:BoundField DataField="KODE_DEPARTEMEN" HeaderText="KODE_DEPARTEMEN" ItemStyle-Width="80px" />
            <asp:BoundField DataField="KODE_JABATAN" HeaderText="KODE_JABATAN" ItemStyle-Width="80px" />
            <asp:BoundField DataField="KODE_GOLONGAN" HeaderText="KODE_GOLONGAN" ItemStyle-Width="80px" />
            <asp:BoundField DataField="KODE_SHIFT" HeaderText="KODE_SHIFT" ItemStyle-Width="80px" />
            <asp:BoundField DataField="STATUS" HeaderText="STATUS" ItemStyle-Width="80px" />
            <asp:BoundField DataField="KELOMPOK" HeaderText="KELOMPOK" ItemStyle-Width="80px" />
            <asp:BoundField DataField="KODE_GRADE" HeaderText="KODE_GRADE" ItemStyle-Width="80px" />
            <asp:BoundField DataField="NILAI_GRADE" HeaderText="NILAI_GRADE" ItemStyle-Width="150px" />
            <asp:BoundField DataField="NOREK_BANK" HeaderText="NOREK_BANK" ItemStyle-Width="150px" />
            <asp:BoundField DataField="NPWP" HeaderText="NPWP" ItemStyle-Width="150px" />
            <asp:BoundField DataField="KODE_POTONGAN" HeaderText="KODE_POTONGAN" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PERSEN_POTONGAN" HeaderText="PERSEN_POTONGAN" ItemStyle-Width="90px" />
            <asp:BoundField DataField="TIPE_POTONGAN" HeaderText="TIPE_POTONGAN" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PNS" HeaderText="PNS" ItemStyle-Width="20px" />
            <asp:BoundField DataField="PERIODE_ABSEN" HeaderText="PERIODE_ABSEN" ItemStyle-Width="50px" />
            <asp:BoundField DataField="TUGAS_BELAJAR" HeaderText="TUGAS_BELAJAR" ItemStyle-Width="150px" />
            <asp:BoundField DataField="JML_POT_TKK" HeaderText="JML_POT_TKK" ItemStyle-Width="150px" />
            <asp:BoundField DataField="JML_TELAT_IJIN" HeaderText="JML_TELAT_IJIN" ItemStyle-Width="150px" />
            <asp:BoundField DataField="JML_CEPAT_PULANG_IJIN" HeaderText="JML_CEPAT_PULANG_IJIN" ItemStyle-Width="150px" />
            <asp:BoundField DataField="PERSENTMCP_IJIN" HeaderText="PERSENTMCP_IJIN" ItemStyle-Width="100px" />
            <asp:BoundField DataField="JML_TELAT" HeaderText="JML_TELAT" ItemStyle-Width="100px" />
            <asp:BoundField DataField="JML_CEPAT_PULANG" HeaderText="JML_CEPAT_PULANG" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KENA_SANGSI" HeaderText="KENA_SANGSI" ItemStyle-Width="100px" />
            <asp:BoundField DataField="JML_TMPC" HeaderText="JML_TMPC" ItemStyle-Width="100px" />
            <asp:BoundField DataField="PERSENTMCP_" HeaderText="PERSENTMCP_" ItemStyle-Width="100px" />
            <asp:BoundField DataField="JML_MANGKIR" HeaderText="JML_MANGKIR" ItemStyle-Width="100px" />
            <asp:BoundField DataField="PERSENMANGKIR_" HeaderText="PERSENMANGKIR_" ItemStyle-Width="100px" />
            <asp:BoundField DataField="JML_CUTI" HeaderText="JML_CUTI" ItemStyle-Width="100px" />
            <asp:BoundField DataField="JML_POTONGAN_TDK_UPACARA" HeaderText="JML_POTONGAN_TDK_UPACARA" ItemStyle-Width="100px" />
            <asp:BoundField DataField="POTPERSENTKK" HeaderText="POTPERSENTKK" ItemStyle-Width="100px" />
            <asp:BoundField DataField="TERIMAPERSENTKK" HeaderText="TERIMAPERSENTKK" ItemStyle-Width="100px" />
            <asp:BoundField DataField="TERIMATKK" HeaderText="TERIMATKK" ItemStyle-Width="100px" />
            <asp:BoundField DataField="POTPAJAK" HeaderText="POTPAJAK" ItemStyle-Width="100px" />
            <asp:BoundField DataField="TUNPAJAK" HeaderText="TUNPAJAK" ItemStyle-Width="100px" />
            <asp:BoundField DataField="POTTKK" HeaderText="POTTKK" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_CABANG" HeaderText="KODE_CABANG" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_UNIT" HeaderText="KODE_UNIT" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_DEPUTI" HeaderText="KODE_DEPUTI" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_BIRO" HeaderText="KODE_BIRO" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_BAGIAN" HeaderText="KODE_BAGIAN" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_SUBBAGIAN" HeaderText="KODE_SUBBAGIAN" ItemStyle-Width="100px" />
            <asp:BoundField DataField="JABATAN" HeaderText="JABATAN" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_JENIS" HeaderText="KODE_JENIS" ItemStyle-Width="100px" />
            <asp:BoundField DataField="KODE_UNIT2" HeaderText="KODE_UNIT2" ItemStyle-Width="100px" />







        </Columns>
    </asp:GridView>
    <br />
    <asp:Button ID="btnExport" runat="server" Text="Export To Excel" OnClick = "ExportToExcel" />
</asp:Content>