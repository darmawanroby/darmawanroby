<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ceremony.aspx.cs" Inherits="rtwin.ceremony" Title = "Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"%>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><asp:Label id="Label4" runat="server" Text="<%$ Resources:lblTahun %>"></asp:Label>&nbsp; <asp:Button id="btnDown" onclick="btnDown_Click" runat="server" Text="<" height="22px"></asp:Button>&nbsp;<asp:TextBox id="txtTahun" runat="server" AutoPostBack="True" CausesValidation="True" width="40px" OnTextChanged="txtTahun_TextChanged" MaxLength="4" Columns="4"></asp:TextBox>&nbsp;<asp:Button id="btnUp" onclick="btnUp_Click" runat="server" Text=">" height="22px"></asp:Button> <asp:RangeValidator id="RangeValidatorTahun" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="Isi tahun dengan angka antara 2000 sd 3000" ControlToValidate="txtTahun" EnableClientScript="True" SetFocusOnError="True" Type="Integer" MinimumValue="2000" MaximumValue="3000">*</asp:RangeValidator><asp:RequiredFieldValidator id="valTahun" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtTahun" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><BR /><BR /><asp:ImageButton style="VERTICAL-ALIGN: middle" id="btnAdd" onclick="btnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp; <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="GVceremony" runat="server" width="570px" DataSourceID="dsceremony" OnRowUpdating="GridView1_RowUpdating" OnRowEditing="GridView1_RowEditing" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="GridView1_RowCommand" OnDataBound="GVceremony_DataBound" DataKeyNames="TGL_UPACARA" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" EmptyDataText="<%$ Resources:lblEmptyData %>"><Columns>
<asp:TemplateField SortExpression="TGL_UPACARA" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:TextBox id="txtCol0Edit" runat="server" Text='<%# Bind("TGL_UPACARA", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol0Edit" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valCol0Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Edit" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtCol0Edit" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator> <cc1:CalendarExtender id="cexCol0Edit" runat="server" CssClass="cal_Theme1" targetcontrolid="txtCol0Edit" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" PopupButtonID="imgCol0Edit"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexCol0Edit" runat="server" TargetControlID="txtCol0Edit" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender> 
</EditItemTemplate>
<FooterTemplate>
&nbsp;<asp:TextBox id="txtCol0Footer" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol0Footer" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valCol0Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtCol0Footer" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator> <cc1:CalendarExtender id="cexCol0Footer" runat="server" CssClass="cal_Theme1" targetcontrolid="txtCol0Footer" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" PopupButtonID="imgCol0Footer"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexCol0Footer" runat="server" TargetControlID="txtCol0Footer" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender> 
</FooterTemplate>

<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("TGL_UPACARA", "{0:d}") %>'></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_UPACARA" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("KET_UPACARA") %>' MaxLength="30" Columns="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" MaxLength="30" Columns="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle Width="320px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle Width="320px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("KET_UPACARA") %>'></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Left"></FooterStyle>
</asp:TemplateField>
    <asp:TemplateField HeaderText="<%$ Resources:Column4 %>" SortExpression="KODE_RANGE">
        <EditItemTemplate>
            <asp:DropDownList ID="ddlCol2Edit" runat="server" DataSourceID="dsRange" DataTextField="KODE_RANGE2"
                DataValueField="KODE_RANGE" SelectedValue='<%# Bind("KODE_RANGE") %>'>
            </asp:DropDownList>
            &nbsp;
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol2Item" runat="server" Text='<%# Bind("KODE_RANGE") %>'></asp:Label>
        </ItemTemplate>
        <FooterTemplate>
            <asp:DropDownList ID="ddlCol2Footer" runat="server" DataSourceID="dsRange" DataTextField="KODE_RANGE2"
                DataValueField="KODE_RANGE" SelectedValue='<%# Bind("KODE_RANGE") %>'>
            </asp:DropDownList>
        </FooterTemplate>
    </asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" ImageUrl="~/Images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<RowStyle HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
&nbsp; 
</EmptyDataTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsceremony" runat="server" OnUpdated="ds_ceremony_Updated" OnInserting="ds_ceremony_Inserting" OnInserted="ds_ceremony_Inserted" OnDeleted="ds_ceremony_Deleted" UpdateCommand="UPDATE taUpacara SET TGL_UPACARA = @TGL_UPACARA, KET_UPACARA = @KET_UPACARA, KODE_RANGE = @KODE_RANGE WHERE (TGL_UPACARA = @TGL_UPACARA)" SelectCommand="SELECT TGL_UPACARA, KET_UPACARA, KODE_RANGE FROM taUpacara ORDER BY TGL_UPACARA" InsertCommand="INSERT INTO taUpacara(TGL_UPACARA, KET_UPACARA,KODE_RANGE) VALUES (@TGL_UPACARA, @KET_UPACARA,@KODE_RANGE)" DeleteCommand="DELETE FROM taUpacara WHERE (TGL_UPACARA = @TGL_UPACARA)" ConnectionString="<%$ ConnectionStrings:strCn %>"><DeleteParameters>
<asp:SessionParameter SessionField="strKey" Type="DateTime" Name="TGL_UPACARA"></asp:SessionParameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Type="DateTime" Name="TGL_UPACARA"></asp:Parameter>
<asp:Parameter Type="String" Name="KET_UPACARA"></asp:Parameter>
    <asp:Parameter Name="KODE_RANGE" />
</UpdateParameters>
<InsertParameters>
<asp:Parameter Type="DateTime" Name="TGL_UPACARA"></asp:Parameter>
<asp:Parameter Type="String" Name="KET_UPACARA"></asp:Parameter>
    <asp:Parameter Name="KODE_RANGE" />
</InsertParameters>
</asp:SqlDataSource> <asp:FormView id="Fvceremony" runat="server" DataSourceID="dsceremony" DataKeyNames="TGL_UPACARA" EmptyDataText="<%$ Resources:lblEmptyData %>" OnItemCommand="Fvceremony_ItemCommand"><InsertItemTemplate>
<TABLE cellSpacing=0 cellPadding=2 width=520 border=1><TBODY><TR><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 320px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("TGL_UPACARA", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol0FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator> <cc1:CalendarExtender id="CalendarExtender1" runat="server" CssClass="cal_Theme1" targetcontrolid="txtCol0FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" PopupButtonID="imgCol0FormView"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexCol0FormView" runat="server" TargetControlID="txtCol0FormView" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD><TD class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("KET_UPACARA") %>' MaxLength="30" Columns="30"></asp:TextBox><asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> 
</contenttemplate>
            </asp:UpdatePanel>
            <asp:SqlDataSource ID="dsRange" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
                SelectCommand="SELECT [KODE_RANGE],'[' + [KODE_RANGE] + ']' + ' : ' + substring( convert(char(20),[JAM_AWAL],108),1,5) + ' s/d ' + substring(convert(char(20),[JAM_AKHIR],108),1,5) AS KODE_RANGE2 FROM [taRange]">
            </asp:SqlDataSource>
            <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
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

