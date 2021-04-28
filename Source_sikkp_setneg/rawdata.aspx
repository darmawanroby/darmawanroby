<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="rawdata.aspx.cs" Inherits="rtwin.rawdata" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="Label11" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><asp:Label id="lblJmlRecord" runat="server" Visible="False"></asp:Label> <TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD><TABLE cellSpacing=0 cellPadding=0 border=0><TBODY><TR><TD vAlign=top align=left><asp:Label id="lblTanggal" runat="server" Text="<%$ Resources:lblTgl %>"></asp:Label></TD><TD vAlign=top align=left><asp:TextBox id="txtFilterItem0" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem0" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem0_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><cc1:calendarextender id="cexFilterItem0" runat="server" targetcontrolid="txtFilterItem0" popupbuttonid="imgFilterItem0" format="<%$ Resources:Resource, formatTanggal %>" enabled="True" cssclass="cal_Theme1"> </cc1:calendarextender> <cc1:MaskedEditExtender id="mexFilterItem0" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem0"></cc1:MaskedEditExtender></TD><TD vAlign=top align=left><asp:Label id="lblTo" runat="server" Text="<%$ Resources:lblTo %>"></asp:Label></TD><TD vAlign=top align=left><asp:TextBox id="txtFilterItem1" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem1" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem1_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valFilterItem1_2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:confirm2 %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" ControlToCompare="txtFilterItem0">*</asp:CompareValidator><cc1:calendarextender id="cexFilterItem1" runat="server" targetcontrolid="txtFilterItem1" popupbuttonid="imgFilterItem1" format="<%$ Resources:Resource, formatTanggal %>" enabled="True" cssclass="cal_Theme1"> </cc1:calendarextender> <cc1:MaskedEditExtender id="mexFilterItem1" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem1"></cc1:MaskedEditExtender></TD><TD vAlign=top align=right><asp:button id="btnRefresh" tabIndex=4 onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>" EnableViewState="False"></asp:button></TD></TR><TR><TD vAlign=top align=left><asp:CheckBox id="cbPIN" tabIndex=3 runat="server" Text="<%$ Resources:cbPIN %>" meta:resourceKey="cbFilter"></asp:CheckBox></TD><TD vAlign=top align=left><asp:TextBox id="txtPIN" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>
                <asp:LinkButton ID="lnkFilterItem0" runat="server" CausesValidation="False" 
                    onclick="lnkCol2Footer_Click">Lookup</asp:LinkButton>
                </TD><TD vAlign=top align=left></TD><TD vAlign=top align=left>&nbsp;</TD><TD vAlign=top align=left></TD></TR><TR><TD vAlign=top align=left>
                &nbsp;</TD><TD vAlign=top align=left>
                    <asp:Label ID="Label12" runat="server"></asp:Label>
                </TD>
                <td align="left" valign="top">
                    &nbsp;</td>
                <td align="left" valign="top">
                    &nbsp;</td>
                <td align="left" valign="top">
                    &nbsp;</td>
                </TR><TR><TD vAlign=top align=left><asp:CheckBox id="cbAlamatKoneksi" tabIndex=3 
                        runat="server" Text="<%$ Resources:lblLokasi %>" meta:resourceKey="cbFilter"></asp:CheckBox></TD><TD vAlign=top align=left colSpan=4>
                        <asp:DropDownList id="DropAlamatKoneksi" runat="server" 
                            DataSourceID="ds_AlamatKoneksi" DataValueField="KODE_LOKASI" 
                            DataTextField="NAMA_LOKASI">
                    </asp:DropDownList></TD></TR>
                <tr>
                    <td align="left" valign="top">
                        <asp:CheckBox ID="cbStatusMesin" runat="server" meta:resourceKey="cbFilter" 
                            tabIndex="3" Text="<%$ Resources:cbStatusMesin %>" />
                    </td>
                    <td align="left" colspan="4" valign="top">
                        <asp:DropDownList ID="ddlStatusMesin" runat="server" 
                            DataSourceID="dsStatusMesin" DataTextField="NAMA_STATUS_MESIN" 
                            DataValueField="KODE_STATUS_MESIN">
                        </asp:DropDownList>
                        &nbsp;</td>
                </tr>
                </TBODY></TABLE></TD></TR></TBODY></TABLE><BR /><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%"><asp:GridView id="GvDataMurni" runat="server" DataSourceID="dsDataMurni" OnDataBound="GvDataMurni_DataBound" GridLines="Vertical" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" EmptyDataText="<%$ Resources:lblEmptyData %>" OnRowDataBound="GvDataMurni_RowDataBound"><Columns>
<asp:TemplateField SortExpression="TGL" HeaderText="<%$ Resources:Column0 %>">
<ItemStyle height="17px" horizontalalign="Center"></ItemStyle>

<HeaderStyle width="80px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("TGL", "{0:d}") %>' width="120px"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="WAKTU" HeaderText="<%$ Resources:Column1 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="60px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("WAKTU", "{0:HH:mm}") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="PIN" HeaderText="<%$ Resources:Column2 %>">
<HeaderStyle width="80px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("PIN") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NIP" HeaderText="<%$ Resources:Column3 %>">
<HeaderStyle width="80px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label9" runat="server" Text='<%# Bind("NIP") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column4 %>">
<HeaderStyle width="120px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label10" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column10 %>">
<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label11" runat="server" Text='<%# Bind("NAMA_LOKASI") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NO_READER" HeaderText="<%$ Resources:Column6 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="70px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("NO_READER") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="ALAMAT_KONEKSI" Visible="False" HeaderText="<%$ Resources:Column5 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="80px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("ALAMAT_KONEKSI") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_STATUS_MESIN" HeaderText="<%$ Resources:Column7 %>">
<ItemStyle horizontalalign="Left"></ItemStyle>

<HeaderStyle width="150px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label6" runat="server" Text='<%# Bind("NAMA_STATUS_MESIN") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="ACTIVITY_CODE" Visible="False" HeaderText="<%$ Resources:Column8 %>">
<ItemStyle horizontalalign="Right"></ItemStyle>

<HeaderStyle width="85px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label7" runat="server" Text='<%# Bind("ACTIVITY_CODE") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="VALUE_CODE" Visible="False" HeaderText="<%$ Resources:Column9 %>">
<ItemStyle horizontalalign="Right"></ItemStyle>

<HeaderStyle width="75px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label8" runat="server" Text='<%# Bind("VALUE_CODE") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="5" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton>&nbsp;&nbsp;&nbsp; <asp:Label id="lbljml" runat="server"></asp:Label> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsDataMurni" runat="server" SelectCommand="SELECT [TGL], [WAKTU], [PIN], [ALAMAT_KONEKSI], [NO_READER], [KODE_STATUS_MESIN], [ACTIVITY_CODE], [VALUE_CODE], [NAMA_STATUS_MESIN], [STATUS_ABSEN], [NIP], [NAMA], [KODE_LOKASI], [NAMA_LOKASI], [NO_MESIN] FROM [q_DataMurni]" ConnectionString="<%$ ConnectionStrings:strCn %>">
                </asp:SqlDataSource> <BR /><asp:Button id="btnGrab" onclick="btnGrab_Click" runat="server" Text="<%$ Resources:btnGrab %>"></asp:Button><cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="btnGrab" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="btnGrab" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender></TD></TR></TBODY></TABLE>
                <asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" Drag="True" BackgroundCssClass="modalBackground" PopupControlID="PNL_Lookup" targetcontrolid="lnkLookupTriger"></cc1:ModalPopupExtender> 
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
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
                        Text="<%$ Resources:lblConfirm %>"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="height: 26px">
                    <asp:Button ID="btnOK" runat="server" Text="OK" />&nbsp;<asp:Button ID="btnCancel"
                        runat="server" Text="<%$ Resources:imgCancel %>" /></td>
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

<asp:TemplateField SortExpression="PIN" HeaderText="PIN">
<EditItemTemplate><asp:Label ID="LabelPINEdit" runat="server" Text='<%# Eval("PIN") %>'></asp:Label></EditItemTemplate>

<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="LabelPINItem" runat="server" Text='<%# Bind("PIN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>


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
    <asp:SqlDataSource ID="dsStatusMesin" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_STATUS_MESIN, NAMA_STATUS_MESIN FROM taStatusMesin ORDER BY KODE_STATUS_MESIN">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ds_AlamatKoneksi" runat="server" ConnectionString="<%$ ConnectionStrings:strCnImageMesin %>"
        SelectCommand="SELECT KODE_LOKASI, NAMA_LOKASI FROM taLokasi"></asp:SqlDataSource>
    <asp:Label ID="lblRevisiOk" runat="server" Text="<%$ Resources:lblRevisiOk %>"
        Visible="False"></asp:Label>
    <asp:Label ID="lblRevisiNotOk" runat="server" Text="<%$ Resources:lblRevisiNotOk %>"
        Visible="False"></asp:Label>
    <asp:Label ID="lblValidRange" runat="server" Text="<%$ Resources:lblValidRange %>"
        Visible="False"></asp:Label>
    <asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label>
 
</asp:Content>

