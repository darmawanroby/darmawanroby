<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="institutions.aspx.cs" Inherits="rtwin.institutions" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>

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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <br /><asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" meta:resourceKey="ImgAdd" AlternateText="<%$ Resources:ImgAdd %>" ImageUrl="images/ipost.gif"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <br /><br /><asp:GridView id="GvInstitutions" runat="server" width="450px" DataSourceID="dsInstansi" OnRowDataBound="GvInstitutions_RowDataBound" OnRowCommand="GvInstitutions_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_INSTANSI" GridLines="Vertical" OnDataBound="GvInstitutions_DataBound" OnRowEditing="GvInstitutions_RowEditing">
<EmptyDataRowStyle width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_INSTANSI" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("KODE_INSTANSI") %>'></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" Columns="1" MaxLength="1"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle height="17px"></ItemStyle>

<HeaderStyle width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_INSTANSI") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_INSTANSI" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("NAMA_INSTANSI") %>' Columns="20" MaxLength="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" Columns="20" MaxLength="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>&nbsp; 
</FooterTemplate>

<HeaderStyle width="300px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA_INSTANSI") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" AlternateText="<%$ Resources:ImgUpdate %>" ImageUrl="~/Images/edit.gif" CommandName="Update"></asp:ImageButton><asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" AlternateText="<%$ Resources:ImgEdit %>" ImageUrl="~/Images/iedit.gif" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle horizontalalign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column3 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender> <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsInstansi" runat="server" OnUpdated="dsCabang_Updated" OnDeleted="dsCabang_Deleted" OnInserted="dsCabang_Inserted" OnInserting="dsCabang_Inserting" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taInstansi WHERE (KODE_INSTANSI = @KODE_INSTANSI)" InsertCommand="INSERT INTO taInstansi(KODE_INSTANSI, NAMA_INSTANSI) VALUES (@KODE_INSTANSI, @NAMA_INSTANSI)" SelectCommand="SELECT KODE_INSTANSI, NAMA_INSTANSI FROM taInstansi &#13;&#10;WHERE KODE_INSTANSI <> '-'&#13;&#10;ORDER BY KODE_INSTANSI" UpdateCommand="UPDATE taInstansi SET NAMA_INSTANSI = @NAMA_INSTANSI WHERE (KODE_INSTANSI = @KODE_INSTANSI)"><DeleteParameters>
<asp:Parameter Name="KODE_INSTANSI"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="NAMA_INSTANSI"></asp:Parameter>
<asp:Parameter Name="KODE_INSTANSI"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_INSTANSI"></asp:Parameter>
<asp:Parameter Name="NAMA_INSTANSI"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource><asp:FormView id="FvInstitutions" runat="server" DataSourceID="dsInstansi" DataKeyNames="KODE_INSTANSI" EmptyDataText="<%$ Resources:lblEmptyData %>" OnItemCommand="FvInstitutions_ItemCommand"><InsertItemTemplate>
<table style="WIDTH: 400px; BORDER-COLLAPSE: collapse" cellspacing="0" cellpadding="2" border="1"><tbody><tr><td style="WIDTH: 50px" class="HeaderStyle" align="center"><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></td><td style="WIDTH: 300px" class="HeaderStyle" align="center"><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></td><td style="WIDTH: 50px" class="HeaderStyle"></td></tr><tr><td class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("KODE_INSTANSI") %>' Columns="1" MaxLength="1"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></td><td class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("NAMA_INSTANSI") %>' Columns="20" MaxLength="30"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></td><td class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel"></asp:ImageButton></td></tr></tbody></table>
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



