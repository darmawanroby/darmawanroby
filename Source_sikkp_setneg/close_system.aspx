<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" Inherits="rtwin.close_system" CodeFile="close_system.aspx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
      <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:250px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" AsyncPostBackTimeOut="36000" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary> <asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%">
<TBODY><TR><TD style="WIDTH: 200px"><BR /><TABLE cellSpacing=0 width=700 border=0><TBODY>
<tr>
    <td width="100px">
        <asp:Label ID="Label6" runat="server" Text="<%$ Resources:lblNIP %>" Visible="False"></asp:Label>
    </td>
    <td>
        <asp:TextBox ID="TxtNIP" width="150px" runat="server" Visible="False"></asp:TextBox><br />
        <asp:Label ID="LabelNama" runat="server" Visible="False"></asp:Label>
    </td>
    <td>&nbsp;
        <asp:LinkButton ID="lnkFilterItem0" runat="server" CausesValidation="False" 
            onclick="lnkCol2Footer_Click" Visible="False">Lookup</asp:LinkButton>
    </td>
    <td colspan="2"></td>
</tr>
<tr><td colspan="5"></td></tr>
<TR>
    <td style="height: 24px" align="left" vAlign="middle" width="15">

                     <asp:Label ID="Label4" runat="server" 
                         Text="<%$ Resources:lblBulan %>"></asp:Label>

                     </td>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <TD style="WIDTH: 100px; height: 24px;" vAlign=top align=left>
                    <asp:DropDownList ID="DropBulan" runat="server" AutoPostBack="True" 
                        ontextchanged="DropBulan_TextChanged">
                    </asp:DropDownList>
                </TD>
    <TD style="height: 24px" align="center">
                    <asp:Label ID="Label5" runat="server" 
                        Text="<%$ Resources:lblTahun %>"></asp:Label>
                </TD>
        <td style="height: 24px" align="left" valign="top">
            
            <asp:DropDownList ID="ddlTahun" runat="server" AutoPostBack="True">
            </asp:DropDownList>
            
        </td>
                <TD width="15" style="height: 24px">
                    <asp:Button ID="btnProsesTK" runat="server" OnClick="Button1_Click" Text="Proses Tunjangan Kinerja" Visible="False" />
                    <br />
                    <asp:CheckBox ID="chkTanpaPotongan" runat="server" Checked="True" Text="Tanpa Potongan"
                        Width="168px" />
                    <asp:Button ID="btnProsesTK13" runat="server" OnClick="btnProsesTK13_Click" Text="Proses Tunjangan Kinerja 13" Visible="True" />
                </TD>

</tr>                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
<tr><td style="height: 24px">
    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:lblJenisLaporan %>"></asp:Label></td><td style="height: 24px">
    <asp:DropDownList ID="ddlJenisTransaksi" runat="server" AutoPostBack="True">
        <asp:ListItem Selected="True" Value="TK">Tunjangan Kinerja</asp:ListItem>
        <asp:ListItem Value="UM">Uang Makan</asp:ListItem>
        <asp:ListItem Value="UL">Uang Lembur</asp:ListItem>
    </asp:DropDownList></td>
    <td colspan="3" style="height: 24px"></td>
    </tr>             </TR>
                </TBODY></TABLE></TD></TR>
</TBODY></TABLE><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="90%" border=0><TBODY>
<TR><TD style="WIDTH: 100%" vAlign=top rowSpan=2>
    &nbsp;
    <BR /><BR /><asp:GridView id="GvTutupPeriode" runat="server" DataSourceID="dsTutupPeriode" OnDataBound="GvTutupPeriode_DataBound" OnRowDataBound="GvTutupPeriode_RowDataBound" EmptyDataText="<%$ Resources:lblEmptyData %>" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GvTutupPeriode_RowEditing" OnRowCommand="GvTutupPeriode_RowCommand" DataKeyNames="JENIS_TRANSAKSI,TAHUN,BULAN,KODE_CABANG">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
        <Columns>
            <asp:BoundField DataField="JENIS_TRANSAKSI" HeaderText="JENIS_TRANSAKSI" ReadOnly="True"
                SortExpression="JENIS_TRANSAKSI" Visible="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="TAHUN" HeaderText="TAHUN" ReadOnly="True" SortExpression="TAHUN" Visible="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="BULAN" HeaderText="BULAN" ReadOnly="True" SortExpression="BULAN" Visible="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="KODE_CABANG" HeaderText="KODE_CABANG" ReadOnly="True"
                SortExpression="KODE_CABANG" Visible="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="NAMA_CABANG" HeaderText="Nama Satuan Kerja" SortExpression="NAMA_CABANG" />
            <asp:BoundField DataField="TGL_PROSES_TERAKHIR" HeaderText="Tgl Proses Terakhir"
                SortExpression="TGL_PROSES_TERAKHIR" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:CheckBoxField DataField="STATUS_DITUTUP" HeaderText="Status Periode Ditutup" SortExpression="STATUS_DITUTUP" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:CheckBoxField>
            <asp:BoundField DataField="TGL_DITUTUP" HeaderText="Tgl Periode Ditutup" SortExpression="TGL_DITUTUP" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="TGL_PROSES_KOREKSI" HeaderText="Tgl Koreksi" SortExpression="TGL_PROSES_KOREKSI" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
    <asp:TemplateField HeaderText="Tutup Transaksi">
        <ItemTemplate>
            <asp:ImageButton ID="imgTutup" runat="server" AlternateText="Tutup Transaksi"
                CausesValidation="False" CommandName="Update2" ImageUrl="~/images/lock.png" />
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        <HeaderStyle HorizontalAlign="Center" Width="50px" />
    </asp:TemplateField>
            <asp:TemplateField HeaderText="Buka Transaksi">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgBuka" runat="server" ImageUrl="~/images/unlock.png" AlternateText="Buka Transaksi" CommandName="Reset"></asp:ImageButton> 
    <asp:Label ID="lblKodeCabang" runat="server" Text='<%# BIND("KODE_CABANG") %>' Visible="False"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Koreksi Transaksi">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgKoreksi" runat="server" ImageUrl="~/images/restart.png" AlternateText="Koreksi Transaksi" CommandName="Delete"></asp:ImageButton>&nbsp;
</ItemTemplate>
</asp:TemplateField>
        </Columns>
</asp:GridView><asp:SqlDataSource id="dsTutupPeriode" OnSelecting="dsTutupPeriode_Selecting" runat="server"  SelectCommand="SELECT * FROM q_TutupPeriode WHERE BULAN = @BULAN AND TAHUN = @TAHUN AND JENIS_TRANSAKSI = @JENIS_TRANSAKSI" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="UPDATE taTutupPeriode SET TGL_PROSES_KOREKSI = getdate()&#13;&#10;WHERE JENIS_TRANSAKSI = @JENIS_TRANSAKSI AND TAHUN = @TAHUN AND BULAN = @BULAN AND KODE_CABANG = @KODE_CABANG&#13;&#10;" UpdateCommand="UPDATE taTutupPeriode SET STATUS_DITUTUP = 1, TGL_PROSES_TERAKHIR = getdate(), TGL_DITUTUP = getdate(), TGL_PROSES_KOREKSI = NULL&#13;&#10;WHERE JENIS_TRANSAKSI = @JENIS_TRANSAKSI AND TAHUN = @TAHUN AND BULAN = @BULAN AND KODE_CABANG = @KODE_CABANG" InsertCommand="UPDATE taTutupPeriode SET STATUS_DITUTUP = 0, TGL_DITUTUP = NULL&#13;&#10;WHERE JENIS_TRANSAKSI = @JENIS_TRANSAKSI AND TAHUN = @TAHUN AND BULAN = @BULAN AND KODE_CABANG = @KODE_CABANG&#13;&#10;">
    <DeleteParameters>
        <asp:Parameter Name="JENIS_TRANSAKSI" />
        <asp:Parameter Name="TAHUN" />
        <asp:Parameter Name="BULAN" />
        <asp:Parameter Name="KODE_CABANG" />
    </DeleteParameters>
    <InsertParameters>
        <asp:ControlParameter ControlID="ddlJenisTransaksi" Name="JENIS_TRANSAKSI" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="ddlTahun" Name="TAHUN" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropBulan" Name="BULAN" PropertyName="SelectedValue" />
        <asp:SessionParameter Name="KODE_CABANG" SessionField="param_cabang" />
    </InsertParameters>
    <UpdateParameters>
       <asp:ControlParameter ControlID="ddlJenisTransaksi" Name="JENIS_TRANSAKSI" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="ddlTahun" Name="TAHUN" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="DropBulan" Name="BULAN" PropertyName="SelectedValue" />
        <asp:SessionParameter Name="KODE_CABANG" SessionField="param_cabang" />
    </UpdateParameters>
    <SelectParameters>
        <asp:ControlParameter ControlID="DropBulan" Name="BULAN" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="ddlTahun" Name="TAHUN" PropertyName="SelectedValue" />
        <asp:ControlParameter ControlID="ddlJenisTransaksi" Name="JENIS_TRANSAKSI" PropertyName="SelectedValue" />
    </SelectParameters>
</asp:SqlDataSource>
    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<BR />
    <asp:Label ID="lblTglTutup" runat="server" Font-Bold="True" Text="Label"></asp:Label><br />
                <asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton> <cc1:ModalPopupExtender id="LookupMPE" runat="server" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="PNL_Lookup" targetcontrolid="lnkLookupTriger"></cc1:ModalPopupExtender> </TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    &nbsp;
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
                    <asp:Label ID="lblConfirm" runat="server" Font-Bold="True" Font-Size="Small" Text="<%$ Resources:confirm %>"></asp:Label>
                </td>
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
        border-left: black 2px solid; width: 300px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white; width:600px">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small"></asp:Label> 
<HR />
 <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan="2"><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" OnDataBound="GvLookupPegawai_DataBound" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NIP"><Columns>
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
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan="2"><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" AlternateText="<%$ Resources:Resource, lblClose %>" ImageUrl="~/images/exit4_16.png"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
    <asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>" Visible="False"></asp:Label>
                    <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                        Visible="False"></asp:Label><asp:Label ID="lblNotSaved" runat="server"
                            Text="<%$ Resources:Resource, lblNotSaved %>" Visible="False" width="704px"></asp:Label><br />
                              
</asp:Content>
			