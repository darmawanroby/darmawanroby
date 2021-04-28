<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="timecard.aspx.cs" Inherits="rtwin.timecard" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:250px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <table border="0" cellpadding="0" cellspacing="0" class="border_table" width="90%">
        <tr>
            <td align="left" style="width: 100%;">
                <asp:ScriptManager id="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" __designer:wfdid="w48"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><BR /><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgBtnAdd" onclick="ImageButton6_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkBtnInsert" onclick="lblTambah_1_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="GVTimeCard" runat="server" DataSourceID="dsTimeCard" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="KODE_RANGE,KODE_ABSEN" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnDataBound="GVTimeCard_DataBound" OnRowCommand="GridView1_RowCommand" OnRowDataBound="GridView1_RowDataBound" OnRowEditing="GVTimeCard_RowEditing" EnableModelValidation="True"><Columns>
<asp:TemplateField SortExpression="KODE_RANGE" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("KODE_RANGE") %>' __designer:wfdid="w100"></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" Text="<%# GetCode() %>" __designer:wfdid="w52" MaxLength="2" Columns="2"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" EnableClientScript="True" __designer:wfdid="w53" SetFocusOnError="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_RANGE") %>' __designer:wfdid="w131"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_AWAL" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("JAM_AWAL", "{0:HH:mm}") %>' __designer:wfdid="w101" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" __designer:wfdid="w102" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol1_1Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol1Edit" __designer:dtid="844424930132107" __designer:wfdid="w103" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol1Edit" runat="server" __designer:wfdid="w104" TargetControlID="txtCol1Edit" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" __designer:wfdid="w130" MaxLength="5" Columns="5"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" EnableClientScript="True" __designer:wfdid="w131" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol1_1Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol1Footer" __designer:dtid="844424930132107" EnableClientScript="True" __designer:wfdid="w132" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol1Edit" runat="server" __designer:wfdid="w133" Mask="99:99" MaskType="Time" TargetControlID="txtCol1Footer"></cc1:MaskedEditExtender>
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("JAM_AWAL", "{0:HH:mm}") %>' __designer:wfdid="w125"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_AKHIR" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:TextBox id="txtCol2Edit" runat="server" Text='<%# Bind("JAM_AKHIR", "{0:HH:mm}") %>' __designer:wfdid="w135" MaxLength="5" Columns="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol2Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol2Edit" EnableClientScript="True" __designer:wfdid="w136" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol2Edit" __designer:dtid="844424930132107" EnableClientScript="True" __designer:wfdid="w137" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol2Edit" runat="server" __designer:wfdid="w141" Mask="99:99" MaskType="Time" TargetControlID="txtCol2Edit"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol2Footer" runat="server" __designer:wfdid="w25" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol2Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol2Footer" __designer:wfdid="w26" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol2Footer" __designer:dtid="844424930132107" __designer:wfdid="w27" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol2Footer" runat="server" __designer:wfdid="w28" TargetControlID="txtCol2Footer" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender> 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("JAM_AKHIR", "{0:HH:mm}") %>' __designer:wfdid="w134"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TOL_MASUK" HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
<asp:TextBox id="txtCol3Edit" runat="server" Text='<%# Bind("TOL_MASUK") %>' __designer:wfdid="w133" MaxLength="2" Columns="2"></asp:TextBox> <asp:RequiredFieldValidator id="valCol3Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol3Edit" __designer:wfdid="w134" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator1" runat="server" ErrorMessage="<%$ Resources:lblWrongInput %>" ControlToValidate="txtCol3Edit" __designer:wfdid="w135" SetFocusOnError="True" EnableClientScript="True" ValueToCompare="0" Type="Integer" Operator="GreaterThanEqual">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol3Edit" runat="server" __designer:wfdid="w136" Mask="99" MaskType="Number" TargetControlID="txtCol3Edit" AutoComplete="False"></cc1:MaskedEditExtender> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol3Footer" runat="server" __designer:wfdid="w137" MaxLength="2" Columns="2"></asp:TextBox> <asp:RequiredFieldValidator id="valCol3Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol3Footer" __designer:wfdid="w138" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator1" runat="server" ErrorMessage="<%$ Resources:lblWrongInput %>" ControlToValidate="txtCol3Footer" __designer:wfdid="w139" SetFocusOnError="True" EnableClientScript="True" ValueToCompare="0" Type="Integer" Operator="GreaterThanEqual">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol3Footer" runat="server" __designer:wfdid="w140" Mask="99" MaskType="Number" TargetControlID="txtCol3Footer" AutoComplete="False"></cc1:MaskedEditExtender> 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("TOL_MASUK") %>' __designer:wfdid="w132"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TOL_PULANG" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
<asp:TextBox id="txtCol4Edit" runat="server" Text='<%# Bind("TOL_PULANG") %>' __designer:wfdid="w151" MaxLength="2" Columns="2"></asp:TextBox> <asp:RequiredFieldValidator id="valCol4Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol4Edit" __designer:wfdid="w152" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator2" runat="server" ErrorMessage="<%$ Resources:lblWrongInput %>" ControlToValidate="txtCol4Edit" __designer:wfdid="w153" SetFocusOnError="True" EnableClientScript="True" ValueToCompare="0" Type="Integer" Operator="GreaterThanEqual">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol4Edit" runat="server" __designer:wfdid="w154" Mask="99" MaskType="Number" TargetControlID="txtCol4Edit" AutoComplete="False"></cc1:MaskedEditExtender> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol4Footer" runat="server" __designer:wfdid="w155" MaxLength="2" Columns="2"></asp:TextBox> <asp:RequiredFieldValidator id="valCol4Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol4Footer" __designer:wfdid="w156" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator2" runat="server" ErrorMessage="<%$ Resources:lblWrongInput %>" ControlToValidate="txtCol4Footer" __designer:wfdid="w157" SetFocusOnError="True" EnableClientScript="True" ValueToCompare="0" Type="Integer" Operator="GreaterThanEqual">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol4Footer" runat="server" __designer:wfdid="w158" Mask="99" MaskType="Number" TargetControlID="txtCol4Footer" AutoComplete="False"></cc1:MaskedEditExtender> 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("TOL_PULANG") %>' __designer:wfdid="w150"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LIMIT_AWAL" HeaderText="<%$ Resources:Column5 %>"><EditItemTemplate>
<asp:TextBox id="txtCol5Edit" runat="server" Text='<%# Bind("LIMIT_AWAL", "{0:HH:mm}") %>' __designer:wfdid="w39" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol5Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol5Edit" __designer:wfdid="w40" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol5Edit" __designer:dtid="844424930132107" __designer:wfdid="w41" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol5Edit" runat="server" __designer:wfdid="w45" TargetControlID="txtCol5Edit" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol5Footer" runat="server" __designer:wfdid="w42" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol5Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol5Footer" __designer:wfdid="w43" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol5Footer" __designer:dtid="844424930132107" __designer:wfdid="w44" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol5Footer" runat="server" __designer:wfdid="w46" TargetControlID="txtCol5Footer" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender>
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("LIMIT_AWAL", "{0:HH:mm}") %>' __designer:wfdid="w38"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LIMIT_AKHIR" HeaderText="<%$ Resources:Column6 %>"><EditItemTemplate>
<asp:TextBox id="txtCol6Edit" runat="server" Text='<%# Bind("LIMIT_AKHIR", "{0:HH:mm}") %>' __designer:wfdid="w48" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol6Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol6Edit" __designer:wfdid="w49" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol6Edit" __designer:dtid="844424930132107" __designer:wfdid="w50" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol6Edit" runat="server" __designer:wfdid="w54" TargetControlID="txtCol6Edit" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol6Footer" runat="server" __designer:wfdid="w51" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol6Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol6Footer" __designer:wfdid="w52" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator6" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol6Footer" __designer:dtid="844424930132107" __designer:wfdid="w53" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol6Footer" runat="server" __designer:wfdid="w55" TargetControlID="txtCol6Footer" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender>
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("LIMIT_AKHIR", "{0:HH:mm}") %>' __designer:wfdid="w47"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_KERJA" HeaderText="<%$ Resources:Column7 %>"><EditItemTemplate>
<asp:TextBox id="txtCol7Edit" runat="server" Text='<%# Bind("JAM_KERJA","{0:HH:mm}") %>' __designer:wfdid="w57" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol7Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol7Edit" __designer:wfdid="w58" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator7" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol7Edit" __designer:dtid="844424930132107" __designer:wfdid="w59" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol7Edit" runat="server" __designer:wfdid="w63" TargetControlID="txtCol7Edit" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol7Footer" runat="server" __designer:wfdid="w60" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valCol7Footer" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol7Footer" __designer:wfdid="w61" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator7" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol7Footer" __designer:dtid="844424930132107" __designer:wfdid="w62" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol7Footer" runat="server" __designer:wfdid="w64" TargetControlID="txtCol7Footer" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender>
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# Bind("JAM_KERJA","{0:HH:mm}") %>' __designer:wfdid="w56"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_ISTIRAHAT" HeaderText="<%$ Resources:Column8 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>
<FooterTemplate>
&nbsp; 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol8Item" runat="server" Text='<%# Bind("JAM_ISTIRAHAT", "{0:HH:mm}") %>' __designer:wfdid="w65"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
                            <asp:TemplateField SortExpression="waktu_fleksi" HeaderText="<%$ Resources:Column13 %>">
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtCol9Edit" runat="server" __designer:wfdid="w39" Columns="5" MaxLength="5" Text='<%# BIND("WAKTU_FLEXI") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <FooterTemplate>
                                    <asp:TextBox ID="txtCol9Footer" runat="server" __designer:wfdid="w42" Columns="5" MaxLength="5"></asp:TextBox>
                                </FooterTemplate>
                                <ItemTemplate>
                                    <asp:Label ID="lblCol9Item" runat="server" __designer:wfdid="w65" Text='<%# Bind("WAKTU_FLEXI") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column9 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" __designer:wfdid="w71" CommandName="Update"></asp:ImageButton> <asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w72" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" __designer:wfdid="w73" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w74" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" __designer:wfdid="w70" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column10 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" __designer:wfdid="w2" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w3" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w4" targetcontrolid="imgDelete" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" CausesValidation="False" ImageUrl="~/images/buttonfirst.gif" __designer:wfdid="w108" CommandName="Page" CommandArgument="First"></asp:ImageButton> <asp:ImageButton id="btnprev" runat="server" CausesValidation="False" ImageUrl="~/images/buttonprev.gif" __designer:wfdid="w109" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w110"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" __designer:wfdid="w111" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w112"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w113"></asp:Label> <asp:ImageButton id="btnnext" runat="server" CausesValidation="False" ImageUrl="~/images/buttonnext.gif" __designer:wfdid="w114" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" CausesValidation="False" ImageUrl="~/images/buttonlast.gif" __designer:wfdid="w115" CommandName="Page" CommandArgument="Last"></asp:ImageButton>
</PagerTemplate>
<EmptyDataTemplate>
&nbsp; 
</EmptyDataTemplate>

<SelectedRowStyle HorizontalAlign="Center"></SelectedRowStyle>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsTimeCard" runat="server" OnUpdating="SqlDataSource1_Insert_Update" UpdateCommand="UPDATE taRange SET JAM_AWAL = @JAM_AWAL, JAM_AKHIR = @JAM_AKHIR, TOL_MASUK = @TOL_MASUK, TOL_PULANG = @TOL_PULANG, LIMIT_AWAL = @LIMIT_AWAL, LIMIT_AKHIR = @LIMIT_AKHIR, JAM_KERJA = @JAM_KERJA, JAM_ISTIRAHAT = @JAM_AKHIR - @JAM_AWAL - @JAM_KERJA,WAKTU_FLEXI = @WAKTU_FLEXI WHERE (KODE_RANGE = @KODE_RANGE) AND (KODE_ABSEN = @KODE_ABSEN)" SelectCommand="SELECT KODE_RANGE, KODE_ABSEN, JAM_AWAL, JAM_AKHIR, TOL_MASUK, TOL_PULANG, LIMIT_AWAL, LIMIT_AKHIR, JAM_KERJA, JAM_ISTIRAHAT,WAKTU_FLEXI  FROM taRange WHERE (KODE_RANGE &lt;&gt; '00') ORDER BY KODE_RANGE" InsertCommand="INSERT INTO taRange(KODE_RANGE, KODE_ABSEN, JAM_AWAL, JAM_AKHIR, TOL_MASUK, TOL_PULANG, LIMIT_AWAL, LIMIT_AKHIR, JAM_KERJA, JAM_ISTIRAHAT,WAKTU_FLEXI) VALUES (@KODE_RANGE, @KODE_ABSEN, @JAM_AWAL, @JAM_AKHIR, @TOL_MASUK, @TOL_PULANG, @LIMIT_AWAL, @LIMIT_AKHIR, @JAM_KERJA, @JAM_AKHIR - @JAM_AWAL - @JAM_KERJA,@WAKTU_FLEXI)" DeleteCommand="DELETE FROM [taRange] WHERE [KODE_RANGE] = @KODE_RANGE AND [KODE_ABSEN] = @KODE_ABSEN" ConnectionString="<%$ ConnectionStrings:strCn %>" OnInserted="SqlDataSource1_Inserted" OnInserting="SqlDataSource1_Insert_Update" OnUpdated="SqlDataSource1_Updated" OnDeleted="SqlDataSource1_Deleted"><DeleteParameters>
<asp:Parameter Type="String" Name="KODE_RANGE"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="1" Name="KODE_ABSEN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Type="DateTime" Name="JAM_AWAL"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="JAM_AKHIR"></asp:Parameter>
<asp:Parameter Type="String" Name="TOL_MASUK"></asp:Parameter>
<asp:Parameter Type="String" Name="TOL_PULANG"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="LIMIT_AWAL"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="LIMIT_AKHIR"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="JAM_KERJA"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="JAM_ISTIRAHAT"></asp:Parameter>
<asp:Parameter Type="String" Name="KODE_RANGE"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="1" Name="KODE_ABSEN"></asp:Parameter>
    <asp:Parameter Name="WAKTU_FLEXI" />
</UpdateParameters>
<InsertParameters>
<asp:Parameter Type="String" DefaultValue="" Name="KODE_RANGE"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="1" Name="KODE_ABSEN"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="JAM_AWAL"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="JAM_AKHIR"></asp:Parameter>
<asp:Parameter Type="String" Name="TOL_MASUK"></asp:Parameter>
<asp:Parameter Type="String" Name="TOL_PULANG"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="LIMIT_AWAL"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="LIMIT_AKHIR"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="JAM_KERJA"></asp:Parameter>
<asp:Parameter Type="DateTime" Name="JAM_ISTIRAHAT"></asp:Parameter>
<asp:Parameter Name="STATUS_RANGE"></asp:Parameter>
    <asp:Parameter Name="WAKTU_FLEXI" />
</InsertParameters>
</asp:SqlDataSource> <asp:FormView id="FvTimeCard" runat="server" DataSourceID="dsTimeCard" __designer:wfdid="w77" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="KODE_RANGE,KODE_ABSEN" OnItemCommand="FvTimeCard_ItemCommand"><InsertItemTemplate>
<TABLE style="BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=2 border=1><TBODY><TR><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w159"></asp:Label></TD><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w160"></asp:Label></TD><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w161"></asp:Label></TD><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label4" runat="server" Text="<%$ Resources:Column3 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w162"></asp:Label></TD><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label5" runat="server" Text="<%$ Resources:Column4 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w163"></asp:Label></TD><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label8" runat="server" Text="<%$ Resources:Column5 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w164"></asp:Label></TD><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label7" runat="server" Text="<%$ Resources:Column6 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w165"></asp:Label></TD><TD style="WIDTH: 80px" class="HeaderStyle" align=center><asp:Label id="Label6" runat="server" Text="<%$ Resources:Column7 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w166"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center>
    Waktu<br /> Flexi</TD>
    <td align="center" class="HeaderStyle" style="WIDTH: 50px"></td>
    </TR><TR><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text="01" __designer:wfdid="w167" MaxLength="2" Columns="2"></asp:TextBox><asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" __designer:wfdid="w168" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></TD><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" __designer:wfdid="w169" MaxLength="5" Columns="5"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" __designer:wfdid="w170" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator1" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol1FormView" __designer:dtid="844424930132107" __designer:wfdid="w171" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><cc1:MaskedEditExtender id="mexCol1FormView" runat="server" __designer:wfdid="w172" Mask="99:99" MaskType="Time" TargetControlID="txtCol1FormView"></cc1:MaskedEditExtender> <cc1:MaskedEditExtender id="mexCol2FormView" runat="server" __designer:wfdid="w173" Mask="99:99" MaskType="Time" TargetControlID="txtCol2FormView"></cc1:MaskedEditExtender> <cc1:MaskedEditExtender id="mexCol3FormView" runat="server" __designer:wfdid="w174" Mask="99" MaskType="Number" TargetControlID="txtCol3FormView" AutoComplete="False"></cc1:MaskedEditExtender> <cc1:MaskedEditExtender id="mexCol4FormView" runat="server" __designer:wfdid="w175" Mask="99" MaskType="Number" TargetControlID="txtCol4FormView" AutoComplete="False"></cc1:MaskedEditExtender> <cc1:MaskedEditExtender id="mexCol5FormView" runat="server" __designer:wfdid="w176" Mask="99:99" MaskType="Time" TargetControlID="txtCol5FormView"></cc1:MaskedEditExtender> <cc1:MaskedEditExtender id="mexCol6FormView" runat="server" __designer:wfdid="w177" Mask="99:99" MaskType="Time" TargetControlID="txtCol6FormView"></cc1:MaskedEditExtender> <cc1:MaskedEditExtender id="mexCol7FormView" runat="server" __designer:wfdid="w178" Mask="99:99" MaskType="Time" TargetControlID="txtCol7FormView"></cc1:MaskedEditExtender></TD><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol2FormView" runat="server" __designer:wfdid="w179" MaxLength="5" Columns="5"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol2FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol2FormView" __designer:wfdid="w180" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol2FormView" __designer:dtid="844424930132107" __designer:wfdid="w181" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> </TD><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol3FormView" runat="server" __designer:wfdid="w182" MaxLength="2" Columns="2"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol3FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol3FormView" __designer:wfdid="w183" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator3" runat="server" ErrorMessage="<%$ Resources:lblWrongInput %>" ControlToValidate="txtCol3FormView" __designer:wfdid="w184" SetFocusOnError="True" EnableClientScript="True" ValueToCompare="0" Type="Integer" Operator="GreaterThanEqual">*</asp:CompareValidator> </TD><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol4FormView" runat="server" __designer:wfdid="w185" MaxLength="2" Columns="2"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol4FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol4FormView" __designer:wfdid="w186" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator4" runat="server" ErrorMessage="<%$ Resources:lblWrongInput %>" ControlToValidate="txtCol4FormView" __designer:wfdid="w187" SetFocusOnError="True" EnableClientScript="True" ValueToCompare="0" Type="Integer" Operator="GreaterThanEqual">*</asp:CompareValidator></TD><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol5FormView" runat="server" __designer:wfdid="w188" MaxLength="5" Columns="5"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol5FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol5FormView" __designer:wfdid="w189" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator3" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol5FormView" __designer:dtid="844424930132107" __designer:wfdid="w190" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator></TD><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol6FormView" runat="server" __designer:wfdid="w191" MaxLength="5" Columns="5"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol6FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol6FormView" __designer:wfdid="w192" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator4" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol6FormView" __designer:dtid="844424930132107" __designer:wfdid="w193" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator></TD><TD style="HEIGHT: 45px" class="FooterStyle"><asp:TextBox id="txtCol7FormView" runat="server" __designer:wfdid="w194" MaxLength="5" Columns="5"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol7FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol7FormView" __designer:wfdid="w195" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="RegularExpressionValidator5" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:salahInput %>" ControlToValidate="txtCol7FormView" __designer:dtid="844424930132107" __designer:wfdid="w196" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator></TD><TD style="HEIGHT: 45px" class="FooterStyle">
        <asp:TextBox ID="txtCol9FormView" runat="server" __designer:wfdid="w194" Columns="5" MaxLength="5"></asp:TextBox>
        <cc1:MaskedEditExtender ID="txtCol9FormView_MaskedEditExtender" runat="server" __designer:wfdid="w178" Mask="99:99" MaskType="Time" TargetControlID="txtCol9FormView">
        </cc1:MaskedEditExtender>
        &nbsp;<asp:RequiredFieldValidator ID="valCol9FormView" runat="server" __designer:wfdid="w195" ControlToValidate="txtCol7FormView" CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" SetFocusOnError="True">*</asp:RequiredFieldValidator>
        <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" __designer:dtid="844424930132107" __designer:wfdid="w196" ControlToValidate="txtCol7FormView" CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:salahInput %>" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator>
        </TD>
        <td class="FooterStyle" style="HEIGHT: 45px">
            <asp:ImageButton ID="imgInsert" runat="server" __designer:wfdid="w197" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert" ImageUrl="~/Images/edit.gif" />
            &nbsp;<asp:ImageButton ID="imgCancelInsert" runat="server" __designer:wfdid="w198" AlternateText="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel" ImageUrl="~/Images/delete.gif" />
        </td>
    </TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> 
</contenttemplate>
                </asp:UpdatePanel><asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="0" DynamicLayout="False"><progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server" __designer:wfdid="w8"><TABLE style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellSpacing=0 cellPadding=0 width=200><TBODY><TR><TD class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..." __designer:wfdid="w9"></asp:Label> </TD></TR><TR><TD style="BACKGROUND-COLOR: #ffffff" align=center><TABLE id="table2" cellSpacing=4 cellPadding=3 border=0><TBODY><TR><TD><IMG id="imgProgress" alt="" src="images/loading.gif" runat="server" /></TD></TR></TBODY></TABLE></TD></TR><TR><TD style="BACKGROUND-COLOR: #ffffff" vAlign=bottom align=right></TD></TR></TBODY></TABLE></asp:Panel> 
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
                <br />
                <a href="timecard_detail.aspx"><asp:Label ID="lblDetail" runat="server" Text="Detail"></asp:Label></a></td>
        </tr>
        </table>
<asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False"></asp:Label><asp:Label ID="lblNotSaved" runat="server" Text="<%$ Resources:Resource, lblNotSaved %>"
                    Visible="False"></asp:Label>
    <asp:Label ID="lblWrongInput" runat="server" Text="<%$ Resources:salahInput %>"
        Visible="False"></asp:Label>
    <asp:Label ID="lblWrongWorkTime" runat="server" Text="<%$ Resources:lblWrongWorkTime %>"
        Visible="False"></asp:Label>
</asp:Content>

