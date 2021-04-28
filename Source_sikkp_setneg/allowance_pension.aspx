<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="allowance_pension.aspx.cs" Inherits="rtwin.allowancepension" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                        <td class="backgroundTitle" style="width:200px">
                            <img style="vertical-align: middle" height="27" src="images/back_title.gif" alt="" />&nbsp;
                            <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                        </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><TABLE id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 width="100%" runat="server"><TBODY><TR><TD><BR /><TABLE cellPadding=1 width=750 border=0><TBODY>

<TR><TD colspan="3">
                <asp:Label ID="Label24" runat="server" Text="Bulan"></asp:Label>
                <asp:DropDownList ID="DropBulan" runat="server" AutoPostBack="True">
                </asp:DropDownList>
                <asp:Label ID="Label25" runat="server" Text="Tahun"></asp:Label>
                <asp:DropDownList ID="ddlTahun" runat="server">
                </asp:DropDownList>
    </TD>

                </TR>
                <tr>
                    <td align="left" >
                        <asp:Label ID="lblNIP" runat="server" Text="<%$ Resources:lblNIP %>"></asp:Label>
                    </td>
                    <td align="left" valign="top">
                        <asp:TextBox ID="txtFilterItem0" runat="server" width="100px"></asp:TextBox>
                        <asp:LinkButton ID="lnkFilterItem0" runat="server" CausesValidation="False" 
                            onclick="lnkCol2Footer_Click">Lookup</asp:LinkButton>&nbsp; <asp:Button ID="btnRefresh" runat="server" onclick="btnRefresh_Click" 
                            Text="<%$ Resources:btnRefresh %>" />
                    </td>
                    <td align="left"  valign="top">
                       
                    </td>
                </tr>
                <TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblUnit %>"></asp:Label></TD><TD>
                    <asp:DropDownList id="ddlFilterItem1" runat="server" 
                        OnSelectedIndexChanged="ddlFilterItem1_SelectedIndexChanged" 
                        AutoPostBack="True" DataSourceID="dsUnit" DataValueField="KODE_CABANG" 
                        DataTextField="NAMA_CABANG" 
                        OnDataBound="ddlFilterItem1_SelectedIndexChanged"></asp:DropDownList>&nbsp; </TD><TD></TD></TR>
                        <TR><TD>
                &nbsp;</TD><TD>&nbsp;</TD><TD></TD></TR>
                <TR>
                <TD colspan="2">
                <asp:Label ID="Label27" runat="server"></asp:Label>
                </TD><TD>&nbsp;</TD><TD></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR>
            <TD vAlign=top><BR /><BR />
                <asp:GridView id="GvKaryawan" runat="server" DataSourceID="dsKaryawan" 
                    OnDataBound="GvKaryawan_DataBound" OnRowEditing="GvKaryawan_RowEditing" 
                    OnRowDataBound="GvKaryawan_RowDataBound" DataKeyNames="NIP" 
                    AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" 
                    EmptyDataText="<%$ Resources:lblEmptyData %>" 
                    OnRowCommand="GvKaryawan_RowCommand" EnableModelValidation="True" Width="700px">
<PagerSettings Mode="NumericFirstLast"></PagerSettings>
<Columns>
<asp:TemplateField SortExpression="NIP" HeaderText="<%$ Resources:lblNIP %>">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("NIP") %>' __designer:wfdid="w57"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:lblNama %>">
<HeaderStyle Width="200px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="Satuan Kerja">

    <ItemTemplate>
        <asp:Label ID="Label26" runat="server" Text='<%# Bind("NAMA_CABANG") %>'></asp:Label>
    </ItemTemplate>

<HeaderStyle Width="250px" />
<ItemStyle HorizontalAlign="Left"></ItemStyle>

</asp:TemplateField>
<asp:TemplateField HeaderText="Status Pensiun">
    <EditItemTemplate>
        <asp:CheckBox ID="CheckBox2" runat="server" 
            Checked='<%# Bind("STATUS_PENSIUN") %>' />
    </EditItemTemplate>
    <ItemTemplate>
        <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" 
            Checked='<%# Bind("STATUS_PENSIUN") %>' 
            oncheckedchanged="CheckBox1_CheckedChanged" />
    </ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnFirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton>&nbsp; <asp:ImageButton id="btnPrev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label>&nbsp;<asp:ImageButton id="btnNext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton>&nbsp;<asp:ImageButton id="btnLast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton>&nbsp; <asp:Label id="lbljml" runat="server"></asp:Label> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsKaryawan" runat="server" 
                    SelectCommand="SELECT BULAN,NIP, NAMA,NAMA_CABANG,STATUS_PENSIUN from taRapelTK where BULAN = @Bulan AND TAHUN= @Tahun " 
                    ConnectionString="<%$ ConnectionStrings:strCn %>" 
                    
                    
                    
                    DeleteCommand="alter table taAbsen disable trigger;tg_taAbsen_delete;DELETE FROM taKaryawan WHERE (NIP = @NIP)alter table taAbsen enable trigger tg_taAbsen_delete;alter table taIjinHari;enable trigger tg_taIjinHari_delete"><DeleteParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
</DeleteParameters>
                    <SelectParameters>
                        <asp:SessionParameter Name="Bulan" SessionField="iBulan" />
                        <asp:SessionParameter Name="Tahun" SessionField="iTahun" />
                    </SelectParameters>
</asp:SqlDataSource>
                <asp:Label id="lblJmlRecord" runat="server" Visible="False"></asp:Label> <BR /></TD></TR></TBODY></TABLE><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" Drag="True" BackgroundCssClass="modalBackground" PopupControlID="PNL_Lookup" targetcontrolid="lnkLookupTriger"></cc1:ModalPopupExtender> 
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsUnit" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_cabang, NAMA_cabang  FROM tacabang ORDER BY KODE_cabang"></asp:SqlDataSource>
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
                        Text="<%$ Resources:Resource, lblConfirmDelete %>"></asp:Label>
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
        border-left: black 2px solid; width: 600px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small"></asp:Label> 
<HR />
<asp:Label id="lblLookupCariPegawai" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblNama %>" Font-Size="Small"></asp:Label> <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan=2><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" OnDataBound="GvLookupPegawai_DataBound" DataKeyNames="NIP" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"><Columns>
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
    <br />
                <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False" width="330px"></asp:Label><asp:Label ID="lblerrorEdit" runat="server" Text="<%$ Resources:Resource, salahValidatorTanggal %>"
                    Visible="False" width="566px"></asp:Label>
    &nbsp;
</asp:Content>

