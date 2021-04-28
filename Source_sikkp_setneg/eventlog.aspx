<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false"  AutoEventWireup="true" CodeFile="eventlog.aspx.cs" Inherits="rtwin.log" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="Label6" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD style="WIDTH: 100px"><BR /><TABLE cellSpacing=0 cellPadding=0 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="lblTanggal" runat="server" Text="<%$ Resources:lblTgl %>"></asp:Label> </TD><TD style="WIDTH: 150px" vAlign=top align=left><asp:TextBox id="txtFilterItem0" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem0" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem0_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><cc1:calendarextender id="cexFilterItem0" runat="server" cssclass="cal_Theme1" enabled="True" format="<%$ Resources:Resource, formatTanggal %>" popupbuttonid="imgFilterItem0" targetcontrolid="txtFilterItem0"> </cc1:calendarextender> <cc1:MaskedEditExtender id="mexFilterItem0" runat="server" TargetControlID="txtFilterItem0" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w491"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 25px" vAlign=top align=left>&nbsp;<asp:Label id="lblTo" runat="server" Text="<%$ Resources:lblTo %>"></asp:Label></TD><TD style="WIDTH: 150px" vAlign=top align=left><asp:TextBox id="txtFilterItem1" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem1" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem1_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valFilterItem1_2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:confirm2 %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" ControlToCompare="txtFilterItem0">*</asp:CompareValidator><cc1:calendarextender id="cexFilterItem1" runat="server" cssclass="cal_Theme1" enabled="True" format="<%$ Resources:Resource, formatTanggal %>" popupbuttonid="imgFilterItem1" targetcontrolid="txtFilterItem1"> </cc1:calendarextender> <cc1:MaskedEditExtender id="mexFilterItem1" runat="server" TargetControlID="txtFilterItem1" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w492"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 100px" vAlign=top align=right><asp:button id="btnRefresh" tabIndex=4 onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:button></TD></TR><TR><TD vAlign=top align=left><asp:CheckBox id="cbCabang" runat="server" Text="<%$ Resources:lblDirektorat %>"></asp:CheckBox></TD><TD vAlign=top align=left colSpan=4><asp:DropDownList id="dropCabang" runat="server" DataSourceID="dsCabang" DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG"></asp:DropDownList> </TD></TR><TR><TD vAlign=top align=left><asp:CheckBox id="cbUsername" tabIndex=3 runat="server" Text="<%$ Resources:cbUsername %>" width="140px" meta:resourceKey="cbFilter"></asp:CheckBox></TD><TD vAlign=top align=left colSpan=4><asp:DropDownList id="ddlUsername" runat="server" DataSourceID="dsUserList" DataValueField="USERNAME" DataTextField="USERNAME">
                    </asp:DropDownList>&nbsp;</TD></TR><TR><TD vAlign=top align=left><asp:CheckBox id="cbAktivitas" tabIndex=3 runat="server" Text="<%$ Resources:cbAktivitas %>" width="140px" meta:resourceKey="cbFilter"></asp:CheckBox></TD><TD vAlign=top align=left colSpan=4><asp:DropDownList id="ddlAktivitas" runat="server" DataSourceID="dsActionList" DataValueField="KODE_AKTIVITAS" DataTextField="NAMA_AKTIVITAS">
                    </asp:DropDownList>&nbsp;</TD></TR><TR><TD vAlign=top align=left><asp:CheckBox id="cbTarget" tabIndex=3 runat="server" Text="<%$ Resources:cbTarget %>" width="140px" meta:resourceKey="cbFilter"></asp:CheckBox></TD><TD vAlign=top align=left colSpan=4><asp:TextBox id="txtTarget" runat="server" width="100px"></asp:TextBox>&nbsp;</TD></TR></TBODY></TABLE>&nbsp;</TD></TR></TBODY></TABLE><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%"><BR /><asp:GridView id="GvLog" runat="server" DataSourceID="dsLog" OnDataBound="GvLog_DataBound" GridLines="Vertical" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" EmptyDataText="<%$ Resources:lblEmptyData %>" OnRowDataBound="GvLog_RowDataBound"><Columns>
<asp:TemplateField SortExpression="TGL" HeaderText="<%$ Resources:Column0 %>">
<ItemStyle height="17px" horizontalalign="Center"></ItemStyle>

<HeaderStyle width="80px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("TGL", "{0:d}") %>' width="100px"></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="WAKTU" HeaderText="<%$ Resources:Column1 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="60px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("WAKTU", "{0:HH:mm}") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="USERNAME" HeaderText="<%$ Resources:Column2 %>">
<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Bind("USERNAME") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_AKTIVITAS" HeaderText="<%$ Resources:Column3 %>">
<HeaderStyle width="200px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# Bind("NAMA_AKTIVITAS") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TARGET" HeaderText="<%$ Resources:Column4 %>">
<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label5" runat="server" Text='<%# Bind("TARGET") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
                        <asp:ImageButton ID="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandArgument="First" CommandName="Page" />
                        &nbsp;<asp:ImageButton ID="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandArgument="Prev" CommandName="Page" />
                        <asp:Label ID="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label>
                        <asp:TextBox ID="txtHalaman" runat="server" AutoPostBack="True" Columns="3" MaxLength="3"
                            OnTextChanged="txtHalaman_TextChanged"></asp:TextBox>
                        <asp:Label ID="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label>
                        <asp:Label ID="lblJumlahHalaman" runat="server" Text="Label"></asp:Label>
                        &nbsp;<asp:ImageButton ID="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandArgument="Next" CommandName="Page" />
                        <asp:ImageButton ID="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandArgument="Last" CommandName="Page" />
                    
</PagerTemplate>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsLog" runat="server" SelectCommand="SELECT TGL, WAKTU, USERNAME, NAMA_AKTIVITAS, TARGET, KODE_CABANG FROM q_Log WHERE (KODE_APLIKASI = 'RTE') AND (KODE_BAHASA = @KODE_BAHASA)" ConnectionString="<%$ ConnectionStrings:strCn %>"><SelectParameters>
<asp:SessionParameter SessionField="strLang" DefaultValue="id" Name="KODE_BAHASA"></asp:SessionParameter>
</SelectParameters>
</asp:SqlDataSource> </TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsCabang" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_CABANG], [NAMA_CABANG] FROM [taCabang]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsUserList" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT USERNAME FROM q_Users"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsActionList" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_AKTIVITAS, NAMA_AKTIVITAS FROM taAktivitas WHERE (KODE_APLIKASI = 'RTE') AND (KODE_BAHASA = @KODE_BAHASA)">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="id" Name="KODE_BAHASA" SessionField="strLang" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

