<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="group.aspx.cs" Inherits="rtwin.group" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <BR /><asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" meta:resourceKey="ImgAdd" AlternateText="<%$ Resources:ImgAdd %>" ImageUrl="images/ipost.gif"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <BR /><BR /><asp:GridView id="GvGolongan" runat="server" width="650px" DataSourceID="dsGolongan" OnRowDataBound="GvGolongan_RowDataBound" OnRowCommand="GvGolongan_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_GOLONGAN" GridLines="Vertical" OnDataBound="GvGolongan_DataBound" OnRowEditing="GvGolongan_RowEditing">
<EmptyDataRowStyle Width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_GOLONGAN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("KODE_GOLONGAN") %>'></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" Columns="3" MaxLength="3"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle Height="17px"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_GOLONGAN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_GOLONGAN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("NAMA_GOLONGAN") %>' Columns="30" MaxLength="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" Columns="30" MaxLength="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>&nbsp; 
</FooterTemplate>

<HeaderStyle Width="300px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA_GOLONGAN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="Tarif Uang Makan" SortExpression="TARIF_MAKAN">
        <EditItemTemplate>
            <asp:Label ID="lblCol1aEdit" runat="server" Text="Rp."></asp:Label>
            <asp:TextBox ID="txtCol1aEdit" runat="server" Columns="10" Text='<%# Bind("TARIF_MAKAN") %>'></asp:TextBox>
            <asp:CompareValidator ID="valCol1aEdit" runat="server" ControlToValidate="txtCol1aEdit"
                EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>"
                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator>
            <cc1:MaskedEditExtender id="mexCol1aEdit" runat="server" AutoComplete="False" TargetControlID="txtCol1aEdit" MaskType="Number" Mask="9999999">
            </cc1:MaskedEditExtender>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:Label ID="lblCol1aFooter" runat="server" Text="Rp."></asp:Label>
            <asp:TextBox ID="txtCol1aFooter" runat="server" Columns="10" Text='<%# Bind("TARIF_MAKAN") %>'></asp:TextBox>
            <asp:CompareValidator ID="valCol1aFooter" runat="server" ControlToValidate="txtCol1aFooter"
                EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>"
                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol1aFooter" runat="server" AutoComplete="False" TargetControlID="txtCol1aFooter" MaskType="Number" Mask="9999999">
                </cc1:MaskedEditExtender>
        </FooterTemplate>
        <ItemStyle HorizontalAlign="Right" />
        <HeaderStyle Width="100px" />
        <ItemTemplate>
            <asp:Label ID="lblCol1aItem" runat="server" Text='<%# Bind("TARIF_MAKAN","{0:C}") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField SortExpression="TARIF_LEMBUR" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:Label id="lblCol2Edit" runat="server" Text="Rp."></asp:Label>&nbsp;<asp:TextBox id="txtCol2Edit" runat="server" Text='<%# Bind("TARIF_LEMBUR") %>' Columns="10"></asp:TextBox> <asp:CompareValidator id="valCol2Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol2Edit" EnableClientScript="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol2Edit" runat="server" AutoComplete="False" TargetControlID="txtCol2Edit" MaskType="Number" Mask="9999999"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:Label id="lblCol2Footer" runat="server" Text="Rp."></asp:Label>&nbsp;<asp:TextBox id="txtCol2Footer" runat="server" Columns="10"></asp:TextBox> <asp:CompareValidator id="valCol2Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol2Footer" EnableClientScript="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol2Footer" runat="server" AutoComplete="False" TargetControlID="txtCol2Footer" MaskType="Number" Mask="9999999"></cc1:MaskedEditExtender>
</FooterTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TARIF_LEMBUR","{0:C}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="Tarif Uang Makan Lembur" SortExpression="TARIF_UANG_MAKAN_LEMBUR">
        <EditItemTemplate>
            <asp:Label ID="lblCol2aEdit" runat="server" Text="Rp."></asp:Label>
            <asp:TextBox ID="txtCol2aEdit" runat="server" Columns="10" Text='<%# Bind("TARIF_UANG_MAKAN_LEMBUR") %>'></asp:TextBox>
            <asp:CompareValidator ID="valCol2aEdit" runat="server" ControlToValidate="txtCol2aEdit"
                EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>"
                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol2aEdit" runat="server" AutoComplete="False" TargetControlID="txtCol2aEdit" MaskType="Number" Mask="9999999">
                </cc1:MaskedEditExtender>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:Label ID="lblCol2aFooter" runat="server" Text="Rp."></asp:Label>
            <asp:TextBox ID="txtCol2aFooter" runat="server" Columns="10" Text='<%# Bind("TARIF_UANG_MAKAN_LEMBUR") %>'></asp:TextBox>
            <asp:CompareValidator ID="valCol2aFooter" runat="server" ControlToValidate="txtCol2aFooter"
                EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>"
                Operator="GreaterThanEqual" SetFocusOnError="True" Type="Integer" ValueToCompare="0">*</asp:CompareValidator><cc1:MaskedEditExtender id="mexCol2aFooter" runat="server" AutoComplete="False" TargetControlID="txtCol2aFooter" MaskType="Number" Mask="9999999">
                </cc1:MaskedEditExtender>
        </FooterTemplate>
        <ItemStyle HorizontalAlign="Right" />
        <HeaderStyle Width="100px" />
        <ItemTemplate>
            <asp:Label ID="lblCol2aItem" runat="server" Text='<%# Bind("TARIF_UANG_MAKAN_LEMBUR","{0:C}") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="<%$ Resources:Column3 %>" SortExpression="PAJAK_GOLONGAN">
        <EditItemTemplate>
            <asp:TextBox ID="txtCol3Edit" runat="server" Text='<%# Bind("PAJAK_GOLONGAN") %>'
                Width="30px"></asp:TextBox>
            <cc1:MaskedEditExtender id="mexCol3Edit" runat="server" AutoComplete="False" TargetControlID="txtCol3Edit" MaskType="Number" Mask="99">
            </cc1:MaskedEditExtender>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:TextBox ID="txtCol3Footer" runat="server" Text='<%# Bind("PAJAK_GOLONGAN") %>'
                Width="30px"></asp:TextBox>
            <cc1:MaskedEditExtender id="mexCol3Footer" runat="server" AutoComplete="False" TargetControlID="txtCol3Footer" MaskType="Number" Mask="99">
            </cc1:MaskedEditExtender>
        </FooterTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol3Item" runat="server" Text='<%# Bind("PAJAK_GOLONGAN", "{0:d}") %>'></asp:Label>
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
</asp:GridView> <asp:SqlDataSource id="dsGolongan" runat="server" OnUpdated="dsGolongan_Updated" OnDeleted="dsGolongan_Deleted" OnInserted="dsGolongan_Inserted" OnInserting="dsGolongan_Inserting" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taGolongan WHERE (KODE_GOLONGAN = @KODE_GOLONGAN)" InsertCommand="INSERT INTO taGolongan(KODE_GOLONGAN, NAMA_GOLONGAN, TARIF_MAKAN, TARIF_LEMBUR, TARIF_UANG_MAKAN_LEMBUR, PAJAK_GOLONGAN) VALUES (@KODE_GOLONGAN, @NAMA_GOLONGAN, @TARIF_MAKAN, @TARIF_LEMBUR, @TARIF_UANG_MAKAN_LEMBUR, @PAJAK_GOLONGAN)" SelectCommand="SELECT KODE_GOLONGAN, NAMA_GOLONGAN, TARIF_MAKAN, TARIF_LEMBUR, TARIF_UANG_MAKAN_LEMBUR, PAJAK_GOLONGAN FROM taGolongan WHERE KODE_GOLONGAN <> '00' ORDER BY KODE_GOLONGAN" UpdateCommand="UPDATE taGolongan SET NAMA_GOLONGAN = @NAMA_GOLONGAN, TARIF_MAKAN = @TARIF_MAKAN, TARIF_LEMBUR = @TARIF_LEMBUR, TARIF_UANG_MAKAN_LEMBUR = @TARIF_UANG_MAKAN_LEMBUR, PAJAK_GOLONGAN = @PAJAK_GOLONGAN WHERE (KODE_GOLONGAN = @KODE_GOLONGAN)"><DeleteParameters>
<asp:Parameter Name="KODE_GOLONGAN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="KODE_GOLONGAN" DefaultValue=""></asp:Parameter>
<asp:Parameter Name="NAMA_GOLONGAN"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="PAJAK_GOLONGAN"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_MAKAN" />
<asp:Parameter DefaultValue="0" Name="TARIF_LEMBUR"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_UANG_MAKAN_LEMBUR" />
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_GOLONGAN"></asp:Parameter>
<asp:Parameter Name="NAMA_GOLONGAN"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="PAJAK_GOLONGAN"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_MAKAN" />
<asp:Parameter DefaultValue="0" Name="TARIF_LEMBUR"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_UANG_MAKAN_LEMBUR" />
</InsertParameters>
</asp:SqlDataSource><asp:FormView id="FvGolongan" runat="server" DataSourceID="dsGolongan" DataKeyNames="KODE_GOLONGAN" OnItemCommand="FvGolongan_ItemCommand" EmptyDataText="<%$ Resources:lblEmptyData %>"><InsertItemTemplate>
<TABLE style="WIDTH: 600px; BORDER-COLLAPSE: collapse" id="table1" cellSpacing=0 cellPadding=2 border=1><TBODY><TR><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 300px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label5" runat="server" Text="<%$ Resources:Column3 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("KODE_GOLONGAN") %>' Columns="3" MaxLength="3"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("NAMA_GOLONGAN") %>' Columns="30" MaxLength="30"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"><asp:Label id="lblCol2Edit" runat="server" Text="Rp."></asp:Label> <asp:TextBox id="txtCol2FormView" runat="server" Text='<%# Bind("TARIF_LEMBUR") %>' Columns="10"></asp:TextBox>&nbsp;<asp:CompareValidator id="valCol2FormView" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol2FormView" EnableClientScript="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0" SetFocusOnError="True">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol2FormView" runat="server" AutoComplete="False" TargetControlID="txtCol2FormView" MaskType="Number" Mask="9999999"></cc1:MaskedEditExtender></TD><TD class="FooterStyle" align=center>&nbsp;&nbsp;<asp:CheckBox id="chkCol3FormView" runat="server" Checked='<%# Bind("PAJAK_GOLONGAN") %>'></asp:CheckBox></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
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



