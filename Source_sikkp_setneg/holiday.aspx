<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="holiday.aspx.cs" Inherits="rtwin.holiday" Title = "Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <table border="0" cellpadding="0" cellspacing="0" class="border_table" width="90%"><tr>
        <td align="left" rowspan="2">
            <asp:ScriptManager id="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel id="UpdatePanel1" runat="server">
                <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><asp:Label id="Label4" runat="server" Text="<%$ Resources:lblTahun %>"></asp:Label>&nbsp; <asp:Button id="btnDown" onclick="btnDown_Click" runat="server" Text="<" height="22px"></asp:Button>&nbsp;<asp:TextBox id="txtTahun" runat="server" AutoPostBack="True" CausesValidation="True" width="40px" OnTextChanged="txtTahun_TextChanged" MaxLength="4" Columns="4"></asp:TextBox>&nbsp;<asp:Button id="btnUp" onclick="btnUp_Click" runat="server" Text=">" height="22px"></asp:Button> <asp:RangeValidator id="RangeValidatorTahun" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="Isi tahun dengan angka antara 2000 sd 3000" ControlToValidate="txtTahun" EnableClientScript="True" SetFocusOnError="True" Type="Integer" MinimumValue="2000" MaximumValue="3000">*</asp:RangeValidator><asp:RequiredFieldValidator id="valTahun" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtTahun" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w297">*</asp:RequiredFieldValidator><BR /><BR /><asp:ImageButton style="VERTICAL-ALIGN: middle" id="btnAdd" onclick="btnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp; <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="GVHoliday" runat="server" width="570px" DataSourceID="dsHoliday" OnRowUpdating="GridView1_RowUpdating" OnRowEditing="GridView1_RowEditing" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" OnDataBound="GVHoliday_DataBound" DataKeyNames="TGL_LIBUR" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" EmptyDataText="<%$ Resources:lblEmptyData %>"><Columns>
<asp:TemplateField SortExpression="TGL_LIBUR" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:TextBox id="txtCol0Edit" runat="server" Text='<%# Bind("TGL_LIBUR", "{0:d}") %>' width="100px" MaxLength="10" Columns="10" __designer:wfdid="w273"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol0Edit" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w274"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valCol0Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Edit" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w275">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtCol0Edit" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w276" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator> <cc1:CalendarExtender id="cexCol0Edit" runat="server" CssClass="cal_Theme1" __designer:wfdid="w277" targetcontrolid="txtCol0Edit" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" PopupButtonID="imgCol0Edit"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexCol0Edit" runat="server" __designer:wfdid="w283" TargetControlID="txtCol0Edit" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender> 
</EditItemTemplate>
<FooterTemplate>
&nbsp;<asp:TextBox id="txtCol0Footer" runat="server" width="100px" MaxLength="10" Columns="10" __designer:wfdid="w278"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol0Footer" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w279"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valCol0Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w280">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtCol0Footer" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w281" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator> <cc1:CalendarExtender id="cexCol0Footer" runat="server" CssClass="cal_Theme1" __designer:wfdid="w282" targetcontrolid="txtCol0Footer" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" PopupButtonID="imgCol0Footer"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexCol0Footer" runat="server" __designer:wfdid="w284" TargetControlID="txtCol0Footer" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender> 
</FooterTemplate>

<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("TGL_LIBUR", "{0:d}") %>' __designer:wfdid="w272"></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_LIBUR" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("KET_LIBUR") %>' MaxLength="30" Columns="30" __designer:wfdid="w370"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" SetFocusOnError="True" __designer:wfdid="w371" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" MaxLength="30" Columns="30" __designer:wfdid="w372"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" SetFocusOnError="True" __designer:wfdid="w373" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle Width="320px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle Width="320px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("KET_LIBUR") %>' __designer:wfdid="w369"></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Left"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" __designer:wfdid="w240" CommandName="Update"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w241" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" __designer:wfdid="w242" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w243" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" __designer:wfdid="w239" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" ImageUrl="~/Images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" __designer:wfdid="w390" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w395" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w396" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" __designer:wfdid="w246" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" __designer:wfdid="w247" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w248"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3" __designer:wfdid="w249"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w250"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w251"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" __designer:wfdid="w252" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" __designer:wfdid="w253" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<RowStyle HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
&nbsp; 
</EmptyDataTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsHoliday" runat="server" OnUpdated="ds_holiday_Updated" OnInserting="ds_holiday_Inserting" OnInserted="ds_holiday_Inserted" OnDeleted="ds_holiday_Deleted" UpdateCommand="UPDATE taLibur SET TGL_LIBUR = @TGL_LIBUR, KET_LIBUR = @KET_LIBUR WHERE (TGL_LIBUR = @TGL_LIBUR)" SelectCommand="SELECT TGL_LIBUR, KET_LIBUR FROM taLibur ORDER BY TGL_LIBUR" InsertCommand="INSERT INTO taLibur(TGL_LIBUR, KET_LIBUR) VALUES (@TGL_LIBUR, @KET_LIBUR)" DeleteCommand="DELETE FROM taLibur WHERE (TGL_LIBUR = @TGL_LIBUR)" ConnectionString="<%$ ConnectionStrings:strCn %>"><DeleteParameters>
<asp:SessionParameter SessionField="strKey" Type="DateTime" Name="TGL_LIBUR"></asp:SessionParameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Type="DateTime" Name="TGL_LIBUR"></asp:Parameter>
<asp:Parameter Type="String" Name="KET_LIBUR"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Type="DateTime" Name="TGL_LIBUR"></asp:Parameter>
<asp:Parameter Type="String" Name="KET_LIBUR"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> <asp:FormView id="FvHoliday" runat="server" DataSourceID="dsHoliday" DataKeyNames="TGL_LIBUR" EmptyDataText="<%$ Resources:lblEmptyData %>" OnItemCommand="FvHoliday_ItemCommand"><InsertItemTemplate>
<TABLE cellSpacing=0 cellPadding=2 width=520 border=1><TBODY><TR><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w285"></asp:Label></TD><TD style="WIDTH: 320px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w286"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("TGL_LIBUR", "{0:d}") %>' width="100px" MaxLength="10" Columns="10" __designer:wfdid="w287"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol0FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w288"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w289">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w290" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator> <cc1:CalendarExtender id="CalendarExtender1" runat="server" CssClass="cal_Theme1" __designer:wfdid="w291" targetcontrolid="txtCol0FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" PopupButtonID="imgCol0FormView"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexCol0FormView" runat="server" __designer:wfdid="w296" TargetControlID="txtCol0FormView" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD><TD class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("KET_LIBUR") %>' MaxLength="30" Columns="30" __designer:wfdid="w292"></asp:TextBox><asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w293">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" __designer:wfdid="w294" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w295" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> 
</contenttemplate>
            </asp:UpdatePanel><asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                DisplayAfter="100" DynamicLayout="False"><progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
            </asp:UpdateProgress><asp:Panel ID="PNLKonfirmasi" runat="server" Style="border-right: black 2px solid;
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
        </td>
    </tr><tr></tr><tr><td align="left"><asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False"></asp:Label><asp:Label ID="lblNotSaved" runat="server" Text="<%$ Resources:Resource, salahValidatorTanggal %>"
                    Visible="False"></asp:Label>&nbsp;
</td></tr><tr><td align="left" style="width:100%">
    &nbsp;</td></tr></table>
    &nbsp;<br />
    &nbsp;<br />
    &nbsp;<br />
    &nbsp;<br />
    &nbsp;<br />
    &nbsp;<br />
    &nbsp;<br />
</asp:Content>

