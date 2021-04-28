<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="salary.aspx.cs" Inherits="rtwin.salary" title="Sistem Kehadiran Kerja Pegawai Sekretariat Negara" Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
      <div class="maincontent">
        	<div class="contentinner content-dashboard">               
                <div class="row-fluid">
                	<div class="span12">
                        <h4 class="widgettitle nomargin shadowed">
              <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                        </h4>
                        <div class="widgetcontent bordered shadowed">
                                 
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><DIV id="hideForm" runat="server">
    <TABLE style="WIDTH: 50%" id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 border=0 runat="server"><TBODY><TR>
        <TD style="WIDTH: 50%"><BR />
        <TABLE cellPadding=1 width=750 border=0>
            <TBODY>
                <TR><TD style="WIDTH: 100px" vAlign=top align=left>
                    <asp:Label id="lblTglAwal" runat="server" Text="<%$ Resources:Label1 %>" width="100px"></asp:Label></TD><TD style="WIDTH: 100px" vAlign=top align=left>
    <asp:DropDownList ID="DropBulan" runat="server">
    </asp:DropDownList>&nbsp;
</TD><TD style="WIDTH: 50px" vAlign=top align=center><asp:Label id="lblTglAkhir" runat="server" Text="<%$ Resources:Label2 %>"></asp:Label></TD>
                    <TD style="WIDTH: 100px" vAlign=top align=left>
                            <asp:DropDownList ID="ddlTahun" runat="server">
                            </asp:DropDownList>&nbsp;
                        </TD>
                    <TD style="WIDTH: 50px" vAlign=top><asp:Button id="btnRefresh" 
                            onclick="btnRefresh_Click" runat="server" Text="Tampilkan"></asp:Button></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR>
            <TD style="WIDTH: 100%" vAlign=top><BR /><BR />
                <asp:GridView id="GvSalary" width="40%" runat="server" DataSourceID="dsSalary" OnDataBound="GvSalary_DataBound" OnRowDataBound="GvSalary_RowDataBound" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="NIP" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GvSalary_RowEditing" EnableModelValidation="True">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:BoundField ReadOnly="True" SortExpression="NIP" HeaderText="NIP">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
</asp:BoundField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column1 %>">
<HeaderStyle Width="250px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged" SkinID="textBoxJam"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> 
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Hapus Data" />
                <br />
                <asp:SqlDataSource id="dsSalary" runat="server" SelectCommand="select taPPH.bulan,taPPH.tahun,taPPH.nip,taPPH.gjpokok,taPPH.tjistri,taPPH.tjanak,taPPH.tjupns,taPPH.tjstruk,taPPH.tjfungs,	taPPH.pembul,taPPH.tjberas,taKaryawan.Nama from taPPH
left join taKaryawan on taKaryawan.NIP = taPPH.NIP" ConnectionString="<%$ ConnectionStrings:strCn %>" UpdateCommand="UPDATE taPenilaianKinerja SET NILAI_INDIKATOR_01 = @NILAI_INDIKATOR_01, NILAI_INDIKATOR_02 = @NILAI_INDIKATOR_02, NILAI_INDIKATOR_03 = @NILAI_INDIKATOR_03, NILAI_INDIKATOR_04 = @NILAI_INDIKATOR_04, NILAI_INDIKATOR_05 = @NILAI_INDIKATOR_05, WAKTU_SIMPAN = getdate() WHERE (NIP = @NIP) AND (PERIODE = @PERIODE)" OnDeleted="dsperformance_Deleted" OnUpdating="dsperformanceEdit_Updating" OnUpdated="dsperformanceEdit_Updated" OnInserting="dsperformanceEdit_Inserting" OnInserted="dsperformanceEdit_Inserted"><DeleteParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="PERIODE"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="PERIODE"></asp:Parameter>
    <asp:Parameter Name="NILAI_INDIKATOR_01" />
    <asp:Parameter Name="NILAI_INDIKATOR_02" />
    <asp:Parameter Name="NILAI_INDIKATOR_03" />
    <asp:Parameter Name="NILAI_INDIKATOR_04" />
    <asp:Parameter Name="NILAI_INDIKATOR_05" />
</UpdateParameters>
</asp:SqlDataSource><asp:SqlDataSource id="dsBagian" runat="server" SelectCommand="SELECT KODE_BAGIAN, NAMA_BAGIAN, KODE_CABANG, KODE_BIRO FROM q_Bagian ORDER BY KODE_BAGIAN" ConnectionString="<%$ ConnectionStrings:strCn %>">
                </asp:SqlDataSource> &nbsp;&nbsp; <BR /><BR /><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender></TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsBiro" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_BIRO, NAMA_BIRO, KODE_CABANG FROM q_Biro ORDER BY KODE_BIRO">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsPola" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_POTONGAN, '[' + KODE_POTONGAN + '] : ' + KET_POTONGAN AS Keterangan FROM taPotongan">
    </asp:SqlDataSource>
    <asp:Panel ID="PNLKonfirmasi" runat="server" Style="border-right: black 2px solid;
        padding-right: 20px; border-top: black 2px solid; display: none; padding-left: 20px;
        padding-bottom: 20px; border-left: black 2px solid; width: 300px; padding-top: 20px;
        border-bottom: black 2px solid; background-color: white">
        <asp:Label ID="lblConfirmTitle" runat="server" Font-Bold="True" Font-Size="Small"
            Text="<%$ Resources:Resource, lblConfirmation %>"></asp:Label>
        <hr />
        <table>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblConfirmDelete" runat="server" Font-Bold="True" Font-Size="Small"
                        Text="<%$ Resources:Resource, lblConfirmDelete %>"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="height: 26px">
                    <asp:Button ID="btnOK" runat="server" Text="OK" />&nbsp;<asp:Button ID="btnCancel"
                        runat="server" Text="<%$ Resources:ImgCancel %>" /></td>
            </tr>
        </table>
        <div style="text-align: right">
            &nbsp;</div>
    </asp:Panel>
    <asp:Panel ID="PNL_Lookup" runat="server" Style="border-right: black 2px solid; padding-right: 20px;
        border-top: black 2px solid; display: none; padding-left: 20px; padding-bottom: 20px;
        border-left: black 2px solid; width: 600px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small"></asp:Label> 
<HR />
<asp:Label id="lblLookupCariPegawai" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblNama %>" Font-Size="Small"></asp:Label> <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan=2>
    <asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="70%" style="width:500px" DataSourceID="dsLookup" OnDataBound="GvLookupPegawai_DataBound" DataKeyNames="NIP" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"><Columns>
<asp:TemplateField SortExpression="NIP" HeaderText="NIP"><EditItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("NIP") %>'></asp:Label>
                                                
</EditItemTemplate>

<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("NIP") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="PIN" SortExpression="PIN" HeaderText="PIN">
<HeaderStyle width="100px"></HeaderStyle>
</asp:BoundField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Resource, lblNama %>"><EditItemTemplate>
<asp:TextBox id="TextBox1" runat="server" Text='<%# Bind("NAMA") %>'></asp:TextBox> 
</EditItemTemplate>

<HeaderStyle width="300px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label2" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Resource, lblPilih %>" ShowHeader="False">
<HeaderStyle width="70px"></HeaderStyle>
<ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" Text="<%$ Resources:Resource, lblPilih %>" CausesValidation="False" CommandName="Select"></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" CausesValidation="False" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" CausesValidation="False" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalamanLookup_TextChanged" Columns="3" MaxLength="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" CausesValidation="False" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" CausesValidation="False" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan=2><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" ImageUrl="~/images/exit4_16.png" AlternateText="<%$ Resources:Resource, lblClose %>"></asp:ImageButton> <asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
                <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False" width="330px"></asp:Label><asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>"
                    Visible="False" width="259px"></asp:Label><asp:Label ID="lblWrongDate" runat="server" Text="<%$ Resources:Resource, lblWrongDate %>"
                    Visible="False" width="320px"></asp:Label><asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
          </div>


  
   
</asp:Content>



