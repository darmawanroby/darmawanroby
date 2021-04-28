<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="shift_collective.aspx.cs" Inherits="rtwin.shift_collective" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
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
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <TABLE style="WIDTH: 100%" class="border_table"><TBODY><TR><TD><TABLE><TBODY><TR><TD style="HEIGHT: 24px" colSpan=1><asp:Label id="lblBulan" runat="server" Text="<%$ Resources:lblBulan %>"></asp:Label>&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </TD><TD style="HEIGHT: 24px"><asp:DropDownList id="DropBulan" runat="server" OnSelectedIndexChanged="DropBulan_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList> &nbsp;&nbsp;&nbsp; <asp:Label id="lblTahun" runat="server" Text="<%$ Resources:lblTahun %>"></asp:Label>&nbsp;<asp:DropDownList id="ddlTahun" runat="server" OnSelectedIndexChanged="ddlTahun_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList> </TD></TR><TR><TD><asp:Label id="lblPola" runat="server" Text="<%$ Resources:lblPola %>"></asp:Label></TD><TD><asp:DropDownList id="DropPola" runat="server" OnSelectedIndexChanged="DropPola_SelectedIndexChanged" AutoPostBack="True"><asp:ListItem Value="M">M (Mingguan)</asp:ListItem>
<asp:ListItem Value="N">N (Harian)</asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblGrup" runat="server" Text="<%$ Resources:lblGrup %>"></asp:Label></TD><TD><asp:DropDownList id="DropGroup" runat="server" OnSelectedIndexChanged="DropGroup_SelectedIndexChanged" AutoPostBack="True" DataSourceID="ds_DropKodeGroup" OnDataBound="DropGroup_DataBound" DataValueField="Kode_Group" DataTextField="judul"></asp:DropDownList> </TD></TR></TBODY></TABLE><asp:Button id="btnGenerate" onclick="btnGenerate_Click" runat="server" Text="<%$ Resources:btnGenerate %>" CausesValidation="False"></asp:Button> &nbsp; </TD></TR><TR><TD style="WIDTH: 100px; HEIGHT: 271px" class="backgroundTable"><asp:Label id="lblPolaFormat" runat="server" Visible="False" Text="Label"></asp:Label> <BR /><asp:Label id="lblShiftKFormat" runat="server" Visible="False" Text="Label"></asp:Label><BR /><TABLE class="lblStandar"><TBODY><TR><TD style="WIDTH: 25%" align=right>1:<asp:DropDownList id="DropDownList1" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD style="WIDTH: 25%" align=right>9:<asp:DropDownList id="DropDownList9" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD style="WIDTH: 25%" align=right>17:<asp:DropDownList id="DropDownList17" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD style="WIDTH: 25%" align=right>25:<asp:DropDownList id="DropDownList25" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD></TR><TR><TD align=right>2:<asp:DropDownList id="DropDownList2" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>10:<asp:DropDownList id="DropDownList10" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>18:<asp:DropDownList id="DropDownList18" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>26:<asp:DropDownList id="DropDownList26" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD></TR><TR><TD align=right>3:<asp:DropDownList id="DropDownList3" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>11:<asp:DropDownList id="DropDownList11" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>19:<asp:DropDownList id="DropDownList19" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>27:<asp:DropDownList id="DropDownList27" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD></TR><TR><TD align=right>4:<asp:DropDownList id="DropDownList4" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>12:<asp:DropDownList id="DropDownList12" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>20:<asp:DropDownList id="DropDownList20" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>28:<asp:DropDownList id="DropDownList28" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD></TR><TR><TD align=right>5:<asp:DropDownList id="DropDownList5" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>13:<asp:DropDownList id="DropDownList13" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>21:<asp:DropDownList id="DropDownList21" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right><asp:Label id="Label1" runat="server" Text="29:"></asp:Label><asp:DropDownList id="DropDownList29" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD></TR><TR><TD align=right>6:<asp:DropDownList id="DropDownList6" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>14:<asp:DropDownList id="DropDownList14" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>22:<asp:DropDownList id="DropDownList22" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right><asp:Label id="Label4" runat="server" Text="30:"></asp:Label><asp:DropDownList id="DropDownList30" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD></TR><TR><TD align=right>7:<asp:DropDownList id="DropDownList7" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>15:<asp:DropDownList id="DropDownList15" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>23:<asp:DropDownList id="DropDownList23" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right><asp:Label id="Label5" runat="server" Text="31:"></asp:Label><asp:DropDownList id="DropDownList31" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True"><asp:ListItem></asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD align=right>8:<asp:DropDownList id="DropDownList8" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>16:<asp:DropDownList id="DropDownList16" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right>24:<asp:DropDownList id="DropDownList24" runat="server" DataSourceID="dsRange" DataValueField="KODE_RANGE" DataTextField="judul" AppendDataBoundItems="True">
                                <asp:ListItem> </asp:ListItem>
                            </asp:DropDownList></TD><TD align=right></TD></TR><TR><TD align=left colSpan=4>&nbsp; &nbsp; &nbsp; &nbsp; </TD></TR><TR><TD align=left colSpan=4><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgSimpan" onclick="ImgSimpan_Click" runat="server" CausesValidation="False" Enabled="False" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif"></asp:ImageButton> <asp:LinkButton id="lbSimpan" onclick="lbSimpan_Click" runat="server" Text="<%$ Resources:ImgInsert %>" CausesValidation="False" Enabled="False"></asp:LinkButton>&nbsp; &nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgCancel" onclick="ImgCancel_Click" runat="server" CausesValidation="False" Enabled="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif"></asp:ImageButton> <asp:LinkButton id="lbCancel" onclick="lbCancel_Click" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" Enabled="False"></asp:LinkButton>&nbsp;&nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgReset" onclick="ImgReset_Click" runat="server" CausesValidation="False" Enabled="False" AlternateText="<%$ Resources:ImgCancel2 %>" ImageUrl="~/images/idelete.gif"></asp:ImageButton> <asp:LinkButton id="lbReset" onclick="lbReset_Click" runat="server" Text="<%$ Resources:ImgCancel2 %>" CausesValidation="False" Enabled="False"></asp:LinkButton></TD></TR></TBODY></TABLE><cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w280" targetcontrolid="ImgReset" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w281" targetcontrolid="ImgReset" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender><cc1:ConfirmButtonExtender id="ConfirmButtonExtender2" runat="server" __designer:wfdid="w282" targetcontrolid="lbReset" displaymodalpopupid="ModalPopupExtender2"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender2" runat="server" __designer:wfdid="w283" targetcontrolid="lbReset" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender><cc1:ConfirmButtonExtender id="ConfirmButtonExtender3" runat="server" __designer:wfdid="w289" targetcontrolid="ImgSimpan" displaymodalpopupid="ModalPopupExtender3"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender3" runat="server" __designer:wfdid="w290" targetcontrolid="ImgSimpan" CancelControlID="btnCancelSave" OkControlID="btnOKSave" PopupControlID="PNLKonfirmasiSave" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender><cc1:ConfirmButtonExtender id="ConfirmButtonExtender4" runat="server" __designer:wfdid="w291" targetcontrolid="lbSimpan" displaymodalpopupid="ModalPopupExtender4"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender4" runat="server" __designer:wfdid="w292" targetcontrolid="lbSimpan" CancelControlID="btnCancelSave" OkControlID="btnOKSave" PopupControlID="PNLKonfirmasiSave" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender></TD></TR></TBODY></TABLE><asp:SqlDataSource id="ds_DropKodeGroup" runat="server" SelectCommand="SELECT right(KODE_SHIFT, len(KODE_SHIFT)-1) AS Kode_Group, '[' + right(KODE_SHIFT, len(KODE_SHIFT)-1) + ']' + ' : ' + NAMA_GROUP as judul FROM taPola WHERE (SUBSTRING(KODE_SHIFT, 1, 1) = @KODE_POLA)" ConnectionString="<%$ ConnectionStrings:strCn %>">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropPola" Name="KODE_POLA" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource> <asp:SqlDataSource id="dsRange" runat="server" SelectCommand="SELECT KODE_RANGE, '[' + KODE_RANGE + '] : ' + substring(convert(varchar, JAM_AWAL, 8),0,6)  + ' s/d ' + substring(convert(varchar, JAM_AKHIR, 8),0,6) AS judul FROM taRange" ConnectionString="<%$ ConnectionStrings:strCn %>">
                </asp:SqlDataSource> 
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
                    <asp:Button ID="btnOK" runat="server" Text="OK" CausesValidation="False" />&nbsp;<asp:Button ID="btnCancel"
                        runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" /></td>
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
                    <asp:Button ID="btnOKSave" runat="server" Text="OK" CausesValidation="False" />&nbsp;<asp:Button ID="btnCancelSave"
                        runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" /></td>
            </tr>
        </table>
        <div style="text-align: right">
            &nbsp;</div>
    </asp:Panel>
    <asp:Label ID="ValidasiTahun1" runat="server" Text="<%$ Resources:ValTahun %>" Visible="False"></asp:Label>
    <asp:Label ID="ValidasiTahun2" runat="server" Text="<%$ Resources:ValEmpty %>" Visible="False"></asp:Label>
    <asp:Label ID="lblNoPattern" runat="server" Text="<%$ Resources:lblNoPattern %>"
        Visible="False"></asp:Label>
    <asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label>

</asp:Content>

