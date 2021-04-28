<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ptkp.aspx.cs" Inherits="rtwin.ptkp" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="backgroundTitle" style="width: 200px">
                <img src="images/back_title.gif" height="27px" style="vertical-align:middle" alt=""/>&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="0" class="border_table" cellspacing="0" width="100%">
        <tr>
            <td align="left" style="width: 90%">
                <asp:ScriptManager id="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <BR /><asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" meta:resourceKey="ImgAdd" AlternateText="<%$ Resources:ImgAdd %>" ImageUrl="images/ipost.gif"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <BR /><BR /><asp:GridView id="GvPTKP" runat="server" width="650px" DataSourceID="dsPTKP" OnRowDataBound="GvPTKP_RowDataBound" OnRowCommand="GvPTKP_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_KAWIN" GridLines="Vertical" OnDataBound="GvPTKP_DataBound" OnRowEditing="GvPTKP_RowEditing">
<EmptyDataRowStyle Width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_KAWIN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("KODE_KAWIN") %>'></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" Columns="4" MaxLength="4"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>
<ItemStyle Height="17px"></ItemStyle>
<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_KAWIN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="BATAS_PTKP" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("BATAS_PTKP") %>' 
        Columns="10" MaxLength="10"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" Columns="10" MaxLength="10"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>&nbsp; 
</FooterTemplate>
<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("BATAS_PTKP") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="<%$ Resources:Column2 %>" SortExpression="KET_KAWIN">
        <EditItemTemplate>
            <asp:TextBox ID="txtCol2Edit" runat="server" Columns="30" 
                Text='<%# Bind("KET_KAWIN") %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="valCol2Edit" runat="server" 
                ControlToValidate="txtCol2Edit" EnableClientScript="True" 
                ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" 
                SetFocusOnError="True">*</asp:RequiredFieldValidator>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:TextBox ID="txtCol2Footer" runat="server" Columns="30" 
                Text='<%# Bind("KET_KAWIN") %>'></asp:TextBox>
            <asp:RequiredFieldValidator ID="valCol2Footer" runat="server" 
                ControlToValidate="txtCol2Footer" EnableClientScript="True" 
                ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" 
                SetFocusOnError="True">*</asp:RequiredFieldValidator>
        </FooterTemplate>
        <ItemStyle HorizontalAlign="Left" />
        <HeaderStyle Width="200px" />
        <ItemTemplate>
            <asp:Label ID="lblCol2Item" runat="server" Text='<%# Bind("KET_KAWIN") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="<%$ Resources:Column3 %>" SortExpression="PTKP">
        <EditItemTemplate>
            <asp:Label ID="lblCol3Edit" runat="server" Text="Rp."></asp:Label>
            <asp:TextBox ID="txtCol3Edit" runat="server" Text='<%# Bind("PTKP") %>'
                Width="100px"></asp:TextBox>
            <asp:CompareValidator ID="valCol3Edit" runat="server" ControlToValidate="txtCol3Edit"
                EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>"
                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol3Edit" runat="server" AutoComplete="False" TargetControlID="txtCol3Edit" MaskType="Number" Mask="99999999">
                </cc1:MaskedEditExtender>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:Label ID="lblCol3Footer" runat="server" Text="Rp."></asp:Label>
            <asp:TextBox ID="txtCol3Footer" runat="server" Text='<%# Bind("PTKP") %>'
                Width="100px"></asp:TextBox>
            <asp:CompareValidator ID="valCol3Footer" runat="server" ControlToValidate="txtCol3Footer"
                EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>"
                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol3Footer" runat="server" AutoComplete="False" TargetControlID="txtCol3Footer" MaskType="Number" Mask="99999999">
                </cc1:MaskedEditExtender>
        </FooterTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol3Item" runat="server" Text='<%# Bind("PTKP","{0:C}") %>'></asp:Label>
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Right" />
    </asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton><asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column5 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender> <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsPTKP" runat="server" OnUpdated="dsPTKP_Updated" OnDeleted="dsPTKP_Deleted" OnInserted="dsPTKP_Inserted" OnInserting="dsPTKP_Inserting" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taPTKP WHERE (KODE_KAWIN = @KODE_KAWIN)" InsertCommand="INSERT INTO taPTKP (KODE_KAWIN, BATAS_PTKP, KET_KAWIN, PTKP) VALUES (@KODE_KAWIN, @BATAS_PTKP, @KET_KAWIN, @PTKP)" SelectCommand="SELECT KODE_KAWIN, BATAS_PTKP, KET_KAWIN, PTKP FROM taPTKP WHERE KODE_KAWIN <> '----' ORDER BY KODE_KAWIN" UpdateCommand="UPDATE taPTKP SET BATAS_PTKP = @BATAS_PTKP, KET_KAWIN = @KET_KAWIN, PTKP = @PTKP WHERE (KODE_KAWIN = @KODE_KAWIN)"><DeleteParameters>
<asp:Parameter Name="KODE_KAWIN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="BATAS_PTKP" DefaultValue=""></asp:Parameter>
<asp:Parameter Name="KET_KAWIN"></asp:Parameter>
<asp:Parameter Name="PTKP"></asp:Parameter>
<asp:Parameter Name="KODE_KAWIN"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_KAWIN" DefaultValue=""></asp:Parameter>
<asp:Parameter Name="BATAS_PTKP"></asp:Parameter>
<asp:Parameter Name="KET_KAWIN"></asp:Parameter>
<asp:Parameter Name="PTKP"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource><asp:FormView id="FvPTKP" runat="server" DataSourceID="dsPTKP" DataKeyNames="KODE_KAWIN" OnItemCommand="FvPTKP_ItemCommand" EmptyDataText="<%$ Resources:lblEmptyData %>"><InsertItemTemplate>
<TABLE style="WIDTH: 600px; BORDER-COLLAPSE: collapse" id="table1" cellSpacing=0 cellPadding=2 border=1><TBODY><TR><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 100px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 200px" class="HeaderStyle" align=center><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 250px" class="HeaderStyle" align=center><asp:Label id="Label5" runat="server" Text="<%$ Resources:Column3 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle">
    <asp:TextBox id="txtCol0FormView" runat="server" 
        Text='<%# Bind("KODE_KAWIN") %>' Columns="4" MaxLength="4"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle">
        <asp:TextBox id="txtCol1FormView" runat="server" 
            Text='<%# Bind("BATAS_PTKP") %>' Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"> 
        <asp:TextBox id="txtCol2FormView" runat="server" 
            Text='<%# Bind("KET_KAWIN") %>' Columns="30" MaxLength="30"></asp:TextBox>
        <asp:RequiredFieldValidator ID="valCol2FormView" runat="server" 
            ControlToValidate="txtCol2FormView" CssClass="fontR" EnableClientScript="True" 
            ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" forecolor="" 
            SetFocusOnError="True">*</asp:RequiredFieldValidator>
        &nbsp;</TD><TD class="FooterStyle">
    <asp:Label id="lblCol3Edit" runat="server" Text="Rp."></asp:Label> <asp:TextBox id="txtCol3FormView" runat="server" Text='<%# Bind("PTKP") %>' Columns="10"></asp:TextBox>&nbsp;<asp:CompareValidator id="valCol3FormView" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol3FormView" EnableClientScript="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator> <cc1:MaskedEditExtender id="MaskedEditExtender1" runat="server" AutoComplete="False" TargetControlID="txtCol3FormView" MaskType="Number" Mask="99999999"></cc1:MaskedEditExtender></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> 
</contenttemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="100" DynamicLayout="False">
                    <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgresstable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign="bottom" align="right"></td></tr></tbody></table></asp:Panel> 
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
                <asp:Label ID="lblError" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False"></asp:Label><br />
                <br />
            </td>
        </tr>
       
    </table>
</asp:Content>



