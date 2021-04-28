<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="daily.aspx.cs" Inherits="rtwin.daily" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD style="WIDTH: 100px"><TABLE width=750><TBODY><TR><TD style="WIDTH: 200px" vAlign=top><asp:Label id="lblTglAwal" runat="server" Font-Bold="True" Text="<%$ Resources:lblTanggal %>" Font-Size="Small"></asp:Label></TD><TD style="WIDTH: 550px"><asp:TextBox id="txtFilterItem0" runat="server" width="100px" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem0" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem0_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/1900">*</asp:CompareValidator><cc1:calendarextender id="cexFilterItem0" runat="server" targetcontrolid="txtFilterItem0" popupbuttonid="imgFilterItem0" format="<%$ Resources:Resource, formatTanggal %>" enabled="True" cssclass="cal_Theme1"> </cc1:calendarextender> <cc1:MaskedEditExtender id="mexFilterItem0" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem0"></cc1:MaskedEditExtender></TD></TR></TBODY></TABLE><BR /><DIV id="hide" runat="server"><TABLE style="WIDTH: 1000px" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 200px"><asp:Label id="lblFilter" runat="server" Font-Bold="True" Text="<%$ Resources:lblFilter %>" Font-Size="Small"></asp:Label></TD><TD style="WIDTH: 800px"></TD></TR><TR style="FONT-SIZE: 12pt"><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:cbNIP %>"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD><asp:TextBox id="txtFilterNIP" runat="server" Text='<%# Bind("NIP") %>' width="100px"></asp:TextBox> <asp:LinkButton id="lnkFilterNIP" onclick="lnkFilterNIP_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton>&nbsp;</TD></TR><TR><TD><asp:Label id="lblInstansi" runat="server" Text="<%$ Resources:CbInstansi %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlInstansi" runat="server" AutoPostBack="True">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblUnit" runat="server" Text="<%$ Resources:cbUnit %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlUnit" runat="server" AutoPostBack="True">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblDeputi" runat="server" Text="<%$ Resources:cbDeputi %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlDeputi" runat="server" AutoPostBack="True">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:CbBiro %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlBiro" runat="server" AutoPostBack="True">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:cbBagian %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlBagian" runat="server">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblSubbagian" runat="server" Text="<%$ Resources:cbSubbagian %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlSubbagian" runat="server">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblJabatan" runat="server" Text="<%$ Resources:cbJabatan %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlJabatan" runat="server">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblgolongan" runat="server" Text="<%$ Resources:cbGolongan %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlGolongan" runat="server">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblGrade" runat="server" Text="<%$ Resources:cbGrade %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlGrade" runat="server">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblEselon" runat="server" Text="<%$ Resources:cbEselon %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlEselon" runat="server">
            </asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblStatus" runat="server" Text="<%$ Resources:cbStatus %>"></asp:Label></TD><TD colSpan=1><asp:DropDownList id="ddlStatus" runat="server">
            </asp:DropDownList></TD></TR><TR><TD></TD><TD colSpan=1></TD></TR><TR><TD colSpan=2><DIV id="hideAdmin2" runat="server"><TABLE style="WIDTH: 500px"><TBODY><TR><TD style="WIDTH: 200px"><asp:Label id="lblKriteria" runat="server" Font-Bold="True" Text="<%$ Resources:lblKriteria %>" Font-Size="Small"></asp:Label></TD><TD style="WIDTH: 300px" colSpan=1><asp:Label id="lblJenisIjin" runat="server" Font-Bold="True" Text="<%$ Resources:lblJenisIjin %>" Font-Size="Small"></asp:Label></TD></TR><TR><TD><DIV id="HideScroll1" runat="server"><asp:CheckBoxList id="cblKriteria" runat="server" width="190px" height="200px" CellSpacing="0" CellPadding="0"><asp:ListItem Value="H">Hadir Normal</asp:ListItem>
<asp:ListItem Value="A">A: Alpa/Mangkir</asp:ListItem>
<asp:ListItem Value="BaK">BaK: Belum Ada Keterangan</asp:ListItem>
<asp:ListItem Value="CI">Alasan</asp:ListItem>
<asp:ListItem Value="L">L: Terlambat</asp:ListItem>
<asp:ListItem Value="PC">Pulang Cepat</asp:ListItem>
<asp:ListItem Value="SPL">Lembur</asp:ListItem>
<asp:ListItem Value="A1x">Absen 1x</asp:ListItem>
<asp:ListItem Value="LB">Libur</asp:ListItem>
<asp:ListItem Value="AM">Absen Manual</asp:ListItem>
</asp:CheckBoxList> </DIV></TD><TD colSpan=1><DIV id="hideScroll" runat="server"><DIV style="WIDTH: 300px; HEIGHT: 200px" id="scrollvertical"><asp:CheckBoxList id="cblKodeIjin" runat="server" CellSpacing="0" CellPadding="0" RepeatColumns="1"></asp:CheckBoxList> </DIV></DIV></TD></TR><TR><TD><asp:Button id="btnAllKriteria" onclick="btnAllKriteria_Click" runat="server" Text="<%$ Resources:btnAll %>" CausesValidation="False" width="61px"></asp:Button> <asp:Button id="btnClearKriteria" onclick="btnClearKriteria_Click" runat="server" Text="<%$ Resources:btnClear %>" CausesValidation="False" width="53px"></asp:Button></TD><TD colSpan=1><asp:Button id="btnAllKodeIjin" onclick="btnAllKodeIjin_Click" runat="server" Text="<%$ Resources:btnAll %>" CausesValidation="False" width="59px"></asp:Button> <asp:Button id="btnClearKodeIjin" onclick="btnClearKodeIjin_Click" runat="server" Text="<%$ Resources:btnClear %>" CausesValidation="False" width="55px"></asp:Button></TD></TR><TR><TD><asp:RadioButtonList id="rblOperand" runat="server" Visible="False" RepeatDirection="Horizontal"><asp:ListItem>And</asp:ListItem>
<asp:ListItem Selected="True">Or</asp:ListItem>
</asp:RadioButtonList></TD><TD colSpan=1></TD></TR></TBODY></TABLE></DIV></TD></TR><TR><TD><BR /><asp:Label id="Label1" runat="server" Font-Bold="True" Text="<%$ Resources:lblSort %>" Font-Size="Small"></asp:Label></TD><TD colSpan=1></TD></TR><TR><TD><asp:RadioButtonList id="rblSort" runat="server">
                    <asp:ListItem Value="KODE_GOLONGAN, NIP" Selected="True" Text="<%$ Resources:cbGrade %>"></asp:ListItem>
                    <asp:ListItem Value="NIP" Text="<%$ Resources:cbNIP %>"></asp:ListItem>
                    <asp:ListItem Value="Nama, NIP" Text="<%$ Resources:cbNama %>"></asp:ListItem>
                    <asp:ListItem Value="KODE_UNIT, NIP" Text="<%$ Resources:CbUnit %>"></asp:ListItem>
                    <asp:ListItem Value="KODE_BIRO, NIP" Text="<%$ Resources:CbBiro %>"></asp:ListItem>
</asp:RadioButtonList>&nbsp;</TD><TD colSpan=1></TD></TR><TR><TD colSpan=2><DIV id="hideAdmin2_2" runat="server"><asp:CheckBox id="cbFilter" runat="server" Text="Tampilkan Filter"></asp:CheckBox> <BR /><asp:CheckBox id="cbKriteria" runat="server" Text="Tampilkan Kriteria dan Status Absen"></asp:CheckBox> </DIV></TD></TR></TBODY></TABLE></DIV><BR /><asp:Button id="btnShow" onclick="btnShow_Click" runat="server" Text="<%$ Resources:btnShow %>"></asp:Button><BR />&nbsp;</TD></TR></TBODY></TABLE><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender> 
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:Panel ID="PNL_Lookup" runat="server" Style="border-right: black 2px solid; padding-right: 20px;
        border-top: black 2px solid; display: none; padding-left: 20px; padding-bottom: 20px;
        border-left: black 2px solid; width: 600px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small"></asp:Label> 
<HR />
<asp:Label id="lblLookupCariPegawai" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblNama %>" Font-Size="Small"></asp:Label> <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan=2><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" DataKeyNames="NIP" AutoGenerateColumns="False" AllowPaging="True" OnDataBound="GvLookupPegawai_DataBound" AllowSorting="True"><Columns>
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
    <br />
</asp:Content>

