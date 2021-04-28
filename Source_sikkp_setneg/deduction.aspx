<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="deduction.aspx.cs" Inherits="rtwin.group" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <BR /><asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" ImageUrl="images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>" meta:resourceKey="ImgAdd"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <BR /><BR /><asp:GridView id="GvPotongan" runat="server" width="650px" DataSourceID="dsPotongan" OnRowEditing="GvPotongan_RowEditing" OnDataBound="GvPotongan_DataBound" GridLines="Vertical" DataKeyNames="KODE_POTONGAN" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowCommand="GvPotongan_RowCommand" OnRowDataBound="GvPotongan_RowDataBound">
<EmptyDataRowStyle Width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_POTONGAN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("KODE_POTONGAN") %>'></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" Columns="3" MaxLength="4"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle Height="17px"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_POTONGAN") %>' __designer:wfdid="w190"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_POTONGAN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("KET_POTONGAN") %>' Columns="50" MaxLength="100"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" Columns="50" MaxLength="100"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>&nbsp; 
</FooterTemplate>

<HeaderStyle Width="350px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("KET_POTONGAN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="PERSEN_POTONGAN" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:TextBox id="txtCol2Edit" runat="server" Text='<%# Bind("PERSEN_POTONGAN") %>' __designer:wfdid="w192" Columns="3"></asp:TextBox> <asp:RangeValidator id="valCol2Edit" runat="server" ErrorMessage="0-100" ControlToValidate="txtCol2Edit" EnableClientScript="True" __designer:wfdid="w193" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol2Edit" runat="server" __designer:wfdid="w268" AutoComplete="False" Mask="999" MaskType="Number" TargetControlID="txtCol2Edit"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol2Footer" runat="server" __designer:wfdid="w194" Columns="3"></asp:TextBox> <asp:RangeValidator id="valCol2Footer" runat="server" ErrorMessage="0-100" ControlToValidate="txtCol2Footer" EnableClientScript="True" __designer:wfdid="w195" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol2Footer" runat="server" __designer:wfdid="w269" AutoComplete="False" Mask="999" MaskType="Number" TargetControlID="txtCol2Footer"></cc1:MaskedEditExtender>
</FooterTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("PERSEN_POTONGAN") %>' __designer:wfdid="w191"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TIPE_POTONGAN" HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
    <asp:DropDownList ID="ddlCol3Edit" runat="server" SelectedValue='<%# Bind("TIPE_POTONGAN") %>'>
        <asp:ListItem Selected="True" Value="1">Peringatan</asp:ListItem>
        <asp:ListItem Value="2">Hukuman</asp:ListItem>
    </asp:DropDownList>
</EditItemTemplate>
<FooterTemplate>
    <asp:DropDownList ID="ddlCol3Footer" runat="server" SelectedValue='<%# Bind("TIPE_POTONGAN") %>'>
        <asp:ListItem Selected="True" Value="1">Peringatan</asp:ListItem>
        <asp:ListItem Value="2">Hukuman</asp:ListItem>
    </asp:DropDownList>
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
    <asp:Label ID="lblCol3Item" runat="server" Text='<%# Bind("JENIS_POTONGAN") %>'></asp:Label>
</ItemTemplate>
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
</asp:GridView> <asp:SqlDataSource id="dsPotongan" runat="server" UpdateCommand="UPDATE taPotongan SET KET_POTONGAN = @KET_POTONGAN, PERSEN_POTONGAN = @PERSEN_POTONGAN, TIPE_POTONGAN = @TIPE_POTONGAN WHERE (KODE_POTONGAN = @KODE_POTONGAN)" SelectCommand="SELECT KODE_POTONGAN, KET_POTONGAN, PERSEN_POTONGAN, CASE WHEN TIPE_POTONGAN='1' THEN 'Peringatan' ELSE 'Hukuman' END AS JENIS_POTONGAN, TIPE_POTONGAN FROM taPotongan ORDER BY KODE_POTONGAN" InsertCommand="INSERT INTO taPotongan(KODE_POTONGAN, KET_POTONGAN, PERSEN_POTONGAN, TIPE_POTONGAN) VALUES (@KODE_POTONGAN, @KET_POTONGAN, @PERSEN_POTONGAN, @TIPE_POTONGAN) " DeleteCommand="DELETE FROM taPotongan  WHERE (KODE_POTONGAN = @KODE_POTONGAN)" ConnectionString="<%$ ConnectionStrings:strCn %>" OnInserting="dsPotongan_Inserting" OnInserted="dsPotongan_Inserted" OnDeleted="dsPotongan_Deleted" OnUpdated="dsPotongan_Updated"><DeleteParameters>
    <asp:Parameter Name="KODE_POTONGAN" />
</DeleteParameters>
<UpdateParameters>
    <asp:Parameter DefaultValue="" Name="KET_POTONGAN" />
    <asp:Parameter DefaultValue="0" Name="PERSEN_POTONGAN" />
    <asp:Parameter DefaultValue="1" Name="TIPE_POTONGAN" />
    <asp:Parameter Name="KODE_POTONGAN" />
</UpdateParameters>
<InsertParameters>
    <asp:Parameter Name="KODE_POTONGAN" />
    <asp:Parameter Name="KET_POTONGAN" />
    <asp:Parameter DefaultValue="0" Name="PERSEN_POTONGAN" />
    <asp:Parameter DefaultValue="1" Name="TIPE_POTONGAN" />
</InsertParameters>
</asp:SqlDataSource><asp:FormView id="FvPotongan" runat="server" DataSourceID="dsPotongan" DataKeyNames="KODE_POTONGAN" EmptyDataText="<%$ Resources:lblEmptyData %>" OnItemCommand="FvPotongan_ItemCommand"><InsertItemTemplate>
<TABLE style="WIDTH: 600px; BORDER-COLLAPSE: collapse" id="table1" cellSpacing=0 cellPadding=2 border=1><TBODY><TR><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w270"></asp:Label></TD><TD style="WIDTH: 300px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w271"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w272"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label5" runat="server" Text="<%$ Resources:Column3 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w273"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("KODE_POTONGAN") %>' __designer:wfdid="w274" Columns="3" MaxLength="4"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" __designer:wfdid="w275" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("KET_POTONGAN") %>' __designer:wfdid="w276" Columns="50" MaxLength="100"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" __designer:wfdid="w277" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle">&nbsp;<asp:TextBox id="txtCol2FormView" runat="server" Text='<%# Bind("PERSEN_POTONGAN") %>' __designer:wfdid="w278" Columns="3"></asp:TextBox> <asp:RangeValidator id="valCol2FormView" runat="server" ErrorMessage="0-100" ControlToValidate="txtCol2FormView" EnableClientScript="True" __designer:wfdid="w279" Type="Integer" SetFocusOnError="True" MinimumValue="100" MaximumValue="0">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol2FormView" runat="server" __designer:wfdid="w283" AutoComplete="False" Mask="999" MaskType="Number" TargetControlID="txtCol2FormView"></cc1:MaskedEditExtender>&nbsp;</TD><TD class="FooterStyle" align=center>&nbsp;<asp:DropDownList id="ddlCol3FormView" runat="server" AutoPostBack="True" __designer:wfdid="w280" SelectedValue='<%# Bind("TIPE_POTONGAN") %>'>
        <asp:ListItem Selected="True" Value="1">Peringatan</asp:ListItem>
        <asp:ListItem Value="2">Hukuman</asp:ListItem>
    </asp:DropDownList>&nbsp;</TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" __designer:wfdid="w281" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w282" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
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



