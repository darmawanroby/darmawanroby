<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="shift_personal.aspx.cs" Inherits="rtwin.shift_personal" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" __designer:wfdid="w119" EnableViewState="False"></asp:Label> <TABLE style="WIDTH: 100%" class="border_table"><TBODY><TR><TD><TABLE><TBODY><TR><TD><asp:Label id="lblBulan" runat="server" Text="<%$ Resources:lblBulan %>" __designer:wfdid="w120"></asp:Label></TD><TD><asp:DropDownList id="DropBulan" runat="server" OnSelectedIndexChanged="DropBulan_SelectedIndexChanged" AutoPostBack="True" __designer:wfdid="w121">                                
                            </asp:DropDownList> &nbsp; &nbsp;<asp:Label id="lblTahun" runat="server" Text="<%$ Resources:lblTahun %>" __designer:wfdid="w122"></asp:Label>&nbsp;&nbsp;&nbsp;<asp:DropDownList id="ddlTahun" runat="server" OnSelectedIndexChanged="ddlTahun_SelectedIndexChanged" AutoPostBack="True" __designer:wfdid="w123">
                            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:lblNIP %>" __designer:wfdid="w124"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN" __designer:wfdid="w1"></asp:Label></TD><TD><asp:TextBox id="txtNIP" runat="server" AutoPostBack="True" width="100px" __designer:wfdid="w125" Columns="10" MaxLength="10" OnTextChanged="txtNIP_TextChanged"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False" __designer:wfdid="w194">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="Label3" runat="server" Text="<%$ Resources:nama %>" __designer:wfdid="w127"></asp:Label></TD><TD><asp:Label id="lblNama" runat="server" __designer:wfdid="w128"></asp:Label></TD></TR><TR><TD><asp:Label id="lblPola" runat="server" Text="<%$ Resources:lblPola %>" __designer:wfdid="w129"></asp:Label></TD><TD><asp:Label id="lblKodeShift" runat="server" __designer:wfdid="w130"></asp:Label> <asp:Label id="lblKetPola" runat="server" __designer:wfdid="w131"></asp:Label></TD></TR></TBODY></TABLE><asp:Button id="btnGenerate" onclick="btnGenerate_Click" runat="server" Text="<%$ Resources:btnGenerate %>" CausesValidation="False" __designer:wfdid="w132"></asp:Button><BR /></TD></TR><TR><TD class="backgroundTable" align=left><asp:Label id="lblShiftKFormat" runat="server" Visible="False" Text="Label" __designer:wfdid="w133"></asp:Label> <BR /><asp:Label id="lblShiftIFormat" runat="server" Visible="False" Text="Label" __designer:wfdid="w134"></asp:Label><BR /><TABLE style="TEXT-ALIGN: right" class="lblStandar"><TBODY><TR><TD style="WIDTH: 25%" align=right>1:<asp:DropDownList id="DropDownList1" runat="server" DataSourceID="dsRange" __designer:wfdid="w135" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD style="WIDTH: 25%" align=right>9:<asp:DropDownList id="DropDownList9" runat="server" DataSourceID="dsRange" __designer:wfdid="w136" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD style="WIDTH: 25%" align=right>17:<asp:DropDownList id="DropDownList17" runat="server" DataSourceID="dsRange" __designer:wfdid="w137" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD style="WIDTH: 25%" align=right>25:<asp:DropDownList id="DropDownList25" runat="server" DataSourceID="dsRange" __designer:wfdid="w138" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>2:<asp:DropDownList id="DropDownList2" runat="server" DataSourceID="dsRange" __designer:wfdid="w139" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem></asp:ListItem>
</asp:DropDownList></TD><TD align=right>10:<asp:DropDownList id="DropDownList10" runat="server" DataSourceID="dsRange" __designer:wfdid="w140" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>18:<asp:DropDownList id="DropDownList18" runat="server" DataSourceID="dsRange" __designer:wfdid="w141" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>26:<asp:DropDownList id="DropDownList26" runat="server" DataSourceID="dsRange" __designer:wfdid="w142" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>3:<asp:DropDownList id="DropDownList3" runat="server" DataSourceID="dsRange" __designer:wfdid="w143" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>11:<asp:DropDownList id="DropDownList11" runat="server" DataSourceID="dsRange" __designer:wfdid="w144" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>19:<asp:DropDownList id="DropDownList19" runat="server" DataSourceID="dsRange" __designer:wfdid="w145" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>27:<asp:DropDownList id="DropDownList27" runat="server" DataSourceID="dsRange" __designer:wfdid="w146" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>4:<asp:DropDownList id="DropDownList4" runat="server" DataSourceID="dsRange" __designer:wfdid="w147" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>12:<asp:DropDownList id="DropDownList12" runat="server" DataSourceID="dsRange" __designer:wfdid="w148" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>20:<asp:DropDownList id="DropDownList20" runat="server" DataSourceID="dsRange" __designer:wfdid="w149" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>28:<asp:DropDownList id="DropDownList28" runat="server" DataSourceID="dsRange" __designer:wfdid="w150" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>5:<asp:DropDownList id="DropDownList5" runat="server" DataSourceID="dsRange" __designer:wfdid="w151" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>13:<asp:DropDownList id="DropDownList13" runat="server" DataSourceID="dsRange" __designer:wfdid="w152" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>21:<asp:DropDownList id="DropDownList21" runat="server" DataSourceID="dsRange" __designer:wfdid="w153" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right><asp:Label id="Label1" runat="server" Text="29:" __designer:wfdid="w154"></asp:Label><asp:DropDownList id="DropDownList29" runat="server" DataSourceID="dsRange" __designer:wfdid="w155" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>6:<asp:DropDownList id="DropDownList6" runat="server" DataSourceID="dsRange" __designer:wfdid="w156" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>14:<asp:DropDownList id="DropDownList14" runat="server" DataSourceID="dsRange" __designer:wfdid="w157" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>22:<asp:DropDownList id="DropDownList22" runat="server" DataSourceID="dsRange" __designer:wfdid="w158" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right><asp:Label id="Label4" runat="server" Text="30:" __designer:wfdid="w159"></asp:Label><asp:DropDownList id="DropDownList30" runat="server" DataSourceID="dsRange" __designer:wfdid="w160" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>7:<asp:DropDownList id="DropDownList7" runat="server" DataSourceID="dsRange" __designer:wfdid="w161" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>15:<asp:DropDownList id="DropDownList15" runat="server" DataSourceID="dsRange" __designer:wfdid="w162" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>23:<asp:DropDownList id="DropDownList23" runat="server" DataSourceID="dsRange" __designer:wfdid="w163" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right><asp:Label id="Label5" runat="server" Text="31:" __designer:wfdid="w164"></asp:Label><asp:DropDownList id="DropDownList31" runat="server" DataSourceID="dsRange" __designer:wfdid="w165" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>8:<asp:DropDownList id="DropDownList8" runat="server" DataSourceID="dsRange" __designer:wfdid="w166" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>16:<asp:DropDownList id="DropDownList16" runat="server" DataSourceID="dsRange" __designer:wfdid="w167" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right>24:<asp:DropDownList id="DropDownList24" runat="server" DataSourceID="dsRange" __designer:wfdid="w168" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD align=right></TD></TR><TR><TD colSpan=4>&nbsp; </TD></TR><TR><TD style="TEXT-ALIGN: left" colSpan=4><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgSimpan" onclick="ImgSimpan_Click" runat="server" CausesValidation="False" __designer:wfdid="w169" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>"></asp:ImageButton> <asp:LinkButton id="lbSimpan" onclick="lbSimpan_Click" runat="server" CausesValidation="False" __designer:wfdid="w170">Simpan</asp:LinkButton> &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgCancel" onclick="ImgCancel_Click" runat="server" CausesValidation="False" __designer:wfdid="w171" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>"></asp:ImageButton> <asp:LinkButton id="lbCancel" onclick="lbCancel_Click" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w172"></asp:LinkButton> &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgReset" onclick="ImgReset_Click" runat="server" CausesValidation="False" __designer:wfdid="w173" ImageUrl="~/images/idelete.gif" AlternateText="<%$ Resources:ImgCancel2 %>"></asp:ImageButton> <asp:LinkButton id="lbReset" onclick="lbReset_Click" runat="server" Text="<%$ Resources:ImgCancel2 %>" CausesValidation="False" __designer:wfdid="w174"></asp:LinkButton></TD></TR></TBODY></TABLE><cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w175" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="ImgReset"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w176" targetcontrolid="ImgReset" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender><cc1:ConfirmButtonExtender id="ConfirmButtonExtender2" runat="server" __designer:wfdid="w177" displaymodalpopupid="ModalPopupExtender2" targetcontrolid="lbReset"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender2" runat="server" __designer:wfdid="w178" targetcontrolid="lbReset" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender><cc1:ConfirmButtonExtender id="ConfirmButtonExtender3" runat="server" __designer:wfdid="w179" displaymodalpopupid="ModalPopupExtender3" targetcontrolid="ImgSimpan"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender3" runat="server" __designer:wfdid="w180" targetcontrolid="ImgSimpan" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasiSave" OkControlID="btnOKSave" CancelControlID="btnCancelSave"></cc1:ModalPopupExtender><cc1:ConfirmButtonExtender id="ConfirmButtonExtender4" runat="server" __designer:wfdid="w181" displaymodalpopupid="ModalPopupExtender4" targetcontrolid="lbSimpan"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender4" runat="server" __designer:wfdid="w182" targetcontrolid="lbSimpan" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasiSave" OkControlID="btnOKSave" CancelControlID="btnCancelSave"></cc1:ModalPopupExtender></TD></TR></TBODY></TABLE><asp:SqlDataSource id="dsRange" runat="server" __designer:wfdid="w183" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT KODE_RANGE, '[' + KODE_RANGE + '] : ' + substring(convert(varchar, JAM_AWAL, 8),0,6)  + ' s/d ' + substring(convert(varchar, JAM_AKHIR, 8),0,6) AS judul FROM taRange"></asp:SqlDataSource><asp:LinkButton id="lnkLookupTriger" runat="server" __designer:wfdid="w215"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" __designer:wfdid="w216" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender> 
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
                        Text="<%$ Resources:lblConfirmReset %>"></asp:Label></td>
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
    <asp:Panel ID="PNLKonfirmasiSave" runat="server" Style="border-right: black 2px solid;
        padding-right: 20px; border-top: black 2px solid; display: none; padding-left: 20px;
        padding-bottom: 20px; border-left: black 2px solid; width: 300px; padding-top: 20px;
        border-bottom: black 2px solid; background-color: white">
        <asp:Label ID="lblConfirmTitleSave" runat="server" Font-Bold="True" Font-Size="Small"
            Text="<%$ Resources:Resource, lblConfirmation %>"></asp:Label>
        <hr />
        <table>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblConfirmSave" runat="server" Font-Bold="True" Font-Size="Small"
                        Text="<%$ Resources:lblConfirmUpdate %>"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="height: 26px">
                    <asp:Button ID="btnOKSave" runat="server" Text="OK" />&nbsp;<asp:Button ID="btnCancelSave"
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
<asp:Label id="lblLookupCariPegawai" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblNama %>" Font-Size="Small"></asp:Label> <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan=2><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" OnDataBound="GvLookupPegawai_DataBound" DataKeyNames="NIP" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True"><Columns>
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
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan=2><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" ImageUrl="~/images/exit4_16.png" AlternateText="<%$ Resources:Resource, lblClose %>"></asp:ImageButton> <asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
    <br />
    <a class="lblStandar" href="change_shift.aspx">Ganti Pola Jadwal</a><br />
    <asp:Label ID="ValidasiTahun1" runat="server" Text="<%$ Resources:ValTahun %>" Visible="False"></asp:Label>
    <asp:Label ID="ValidasiTahun2" runat="server" Text="<%$ Resources:ValEmpty %>" Visible="False"></asp:Label>
    <asp:Label ID="lblMingguan" runat="server" Text="<%$ Resources:Mingguan %>" Visible="False"></asp:Label>
    <asp:Label ID="lblHarian" runat="server" Text="<%$ Resources:Harian %>" Visible="False"></asp:Label>
    <asp:Label ID="lblCannotEmpty" runat="server" Text="<%$ Resources:Resource, lblFieldCannotEmpty %>" Visible="False"></asp:Label>
    <asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>"
        Visible="False" width="259px"></asp:Label>
    <asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label><br />
    
</asp:Content>
