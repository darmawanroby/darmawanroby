<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="grade.aspx.cs" Inherits="rtwin.grade" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <BR /><asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" meta:resourceKey="ImgAdd" AlternateText="<%$ Resources:ImgAdd %>" ImageUrl="images/ipost.gif"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <BR /><BR /><asp:GridView id="GvGrade" runat="server" width="300px" DataSourceID="dsGrade" OnRowDataBound="GvGrade_RowDataBound" OnRowCommand="GvGrade_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_GRADE" GridLines="Vertical" OnDataBound="GvGrade_DataBound" OnRowEditing="GvGrade_RowEditing">
<EmptyDataRowStyle Width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_GRADE" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("KODE_GRADE") %>' __designer:wfdid="w138"></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" __designer:wfdid="w139" Columns="3"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" __designer:wfdid="w140" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valCol0_1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol0Footer" __designer:wfdid="w141" SetFocusOnError="True" ValueToCompare="0" Type="Integer" Operator="GreaterThanEqual" EnableClientScript="True">*</asp:CompareValidator>
</FooterTemplate>

<ItemStyle Height="17px"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_GRADE") %>' __designer:wfdid="w26"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NILAI_GRADE" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("NILAI_GRADE") %>' __designer:wfdid="w28" Columns="10"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" EnableClientScript="True" __designer:wfdid="w29" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valCol1_1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol1Edit" EnableClientScript="True" __designer:wfdid="w30" SetFocusOnError="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol1Edit" runat="server" __designer:wfdid="w54" Mask="999999999" MaskType="Number" TargetControlID="txtCol1Edit" AutoComplete="False"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" __designer:wfdid="w31" Columns="10"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" EnableClientScript="True" __designer:wfdid="w32" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valCol1_1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol1Footer" EnableClientScript="True" __designer:wfdid="w33" SetFocusOnError="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol1Footer" runat="server" __designer:wfdid="w55" Mask="999999999" MaskType="Number" TargetControlID="txtCol1Footer" AutoComplete="False"></cc1:MaskedEditExtender>
</FooterTemplate>

<ItemStyle HorizontalAlign="Right"></ItemStyle>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NILAI_GRADE","{0:C}") %>' __designer:wfdid="w27"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" __designer:wfdid="w134" CommandName="Update"></asp:ImageButton><asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w135" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" __designer:wfdid="w136" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w137" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" __designer:wfdid="w133" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender> <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" __designer:wfdid="w41" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" __designer:wfdid="w42" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w43"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" __designer:wfdid="w44" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w45"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w46"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" __designer:wfdid="w47" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" __designer:wfdid="w48" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsGrade" runat="server" OnUpdated="dsGrade_Updated" OnDeleted="dsGrade_Deleted" OnInserted="dsGrade_Inserted" OnInserting="dsGrade_Inserting" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taGrade WHERE (KODE_GRADE = @KODE_GRADE)" InsertCommand="INSERT INTO taGrade(KODE_GRADE, NILAI_GRADE) VALUES (@KODE_GRADE, @NILAI_GRADE)" SelectCommand="SELECT KODE_GRADE, NILAI_GRADE FROM taGrade WHERE KODE_GRADE > 0 ORDER BY KODE_GRADE" UpdateCommand="UPDATE taGrade SET NILAI_GRADE = @NILAI_GRADE WHERE (KODE_GRADE = @KODE_GRADE)"><DeleteParameters>
<asp:Parameter Name="KODE_GRADE"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="NILAI_GRADE"></asp:Parameter>
<asp:Parameter Name="KODE_GRADE"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_GRADE"></asp:Parameter>
<asp:Parameter Name="NILAI_GRADE"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource><asp:FormView id="FvGrade" runat="server" DataSourceID="dsGrade" DataKeyNames="KODE_GRADE" OnItemCommand="FvGrade_ItemCommand" EmptyDataText="<%$ Resources:lblEmptyData %>"><InsertItemTemplate>
<TABLE style="WIDTH: 250px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=2 border=1><TBODY><TR><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w34"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w35"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle"></TD></TR><TR><TD class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("KODE_GRADE") %>' __designer:wfdid="w36" Columns="3"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" __designer:wfdid="w37" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valCol0_1FormView" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" __designer:wfdid="w38" SetFocusOnError="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator></TD><TD class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("NILAI_GRADE") %>' __designer:wfdid="w39" Columns="10"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" __designer:wfdid="w40" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valCol1_1FormView" runat="server" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" __designer:wfdid="w41" SetFocusOnError="True" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol1FormView" runat="server" __designer:wfdid="w56" Mask="999999999" MaskType="Number" TargetControlID="txtCol1FormView" AutoComplete="False"></cc1:MaskedEditExtender></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" __designer:wfdid="w42" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" __designer:wfdid="w43" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> 
</contenttemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="100" DynamicLayout="False">
                    <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server" __designer:wfdid="w9"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgresstable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..." __designer:wfdid="w10"></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign="bottom" align="right"></td></tr></tbody></table></asp:Panel> 
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



