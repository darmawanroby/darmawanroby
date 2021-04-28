<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="subdivision.aspx.cs" Inherits="rtwin.subdivision" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <br /><table style="WIDTH: 750px"><tbody><tr><td style="WIDTH: 200px"><asp:Label id="Label5" runat="server" Text="<%$ Resources:lblFilterItem0 %>" __designer:wfdid="w1"></asp:Label></td><td style="WIDTH: 550px" colspan="2"><asp:DropDownList id="ddlItem0Filter" runat="server" OnSelectedIndexChanged="ddlItem0Filter_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsInstansi" __designer:wfdid="w30" OnDataBound="ddlItem0Filter_SelectedIndexChanged" DataTextField="NAMA_INSTANSI" DataValueField="KODE_INSTANSI"></asp:DropDownList></td></tr><tr><td><asp:Label id="Label6" runat="server" Text="<%$ Resources:lblFilterItem1 %>" __designer:wfdid="w26"></asp:Label></td><td colspan="2"><asp:DropDownList id="ddlItem1Filter" runat="server" OnSelectedIndexChanged="ddlItem1Filter_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsUnitFilter" __designer:wfdid="w2" OnDataBound="ddlItem1Filter_SelectedIndexChanged" DataTextField="NAMA_UNIT" DataValueField="KODE_UNIT"></asp:DropDownList></td></tr><tr><td><asp:Label id="Label4" runat="server" Text="<%$ Resources:lblFilterItem2 %>" __designer:wfdid="w1"></asp:Label></td><td colspan="2"><asp:DropDownList id="ddlItem2Filter" runat="server" OnSelectedIndexChanged="ddlItem2Filter_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsDeputiFilter" __designer:wfdid="w2" OnDataBound="ddlItem2Filter_SelectedIndexChanged" DataTextField="NAMA_DEPUTI" DataValueField="KODE_DEPUTI"></asp:DropDownList> </td></tr><tr><td><asp:Label id="Label7" runat="server" Text="<%$ Resources:lblFilterItem3 %>" __designer:wfdid="w27"></asp:Label></td><td colspan="2"><asp:DropDownList id="ddlItem3Filter" runat="server" OnSelectedIndexChanged="ddlItem3Filter_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsBiroFilter" __designer:wfdid="w28" OnDataBound="ddlItem3Filter_SelectedIndexChanged" DataTextField="NAMA_BIRO" DataValueField="KODE_BIRO"></asp:DropDownList></td></tr><tr><td><asp:Label id="Label8" runat="server" Text="<%$ Resources:lblFilterItem4 %>" __designer:wfdid="w53"></asp:Label></td><td colspan="2"><asp:DropDownList id="ddlItem4Filter" runat="server" OnSelectedIndexChanged="ddlFilterItemChange" AutoPostBack="True" DataSourceID="dsDivisionFilter" __designer:wfdid="w54" OnDataBound="ddlFilterItemChange" DataTextField="NAMA_BAGIAN" DataValueField="KODE_BAGIAN"></asp:DropDownList> </td></tr></tbody></table><br /><asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" meta:resourceKey="ImgAdd" AlternateText="<%$ Resources:ImgAdd %>" ImageUrl="images/ipost.gif"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <br /><br /><asp:GridView id="GvSubBagian" runat="server" width="650px" DataSourceID="dsSubDivision" OnDataBound="GvSubBagian_DataBound" OnRowDataBound="GvSubBagian_RowDataBound" OnRowCommand="GvSubBagian_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_SUBBAGIAN" GridLines="Vertical" OnRowEditing="GvSubBagian_RowEditing">
<EmptyDataRowStyle width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_SUBBAGIAN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("KODE_SUBBAGIAN") %>' __designer:wfdid="w237"></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" __designer:wfdid="w59" MaxLength="7" Columns="7"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" __designer:wfdid="w60" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle height="17px"></ItemStyle>

<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_SUBBAGIAN") %>' __designer:wfdid="w56"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_SUBBAGIAN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("NAMA_SUBBAGIAN") %>' __designer:wfdid="w267" MaxLength="110" Columns="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" __designer:wfdid="w63" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" __designer:wfdid="w64" MaxLength="110" Columns="30"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" __designer:wfdid="w65" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>&nbsp; 
</FooterTemplate>

<HeaderStyle width="300px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA_SUBBAGIAN") %>' __designer:wfdid="w266"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_BAGIAN" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol2Edit" runat="server" DataSourceID="dsDivision" __designer:wfdid="w278" DataValueField="KODE_BAGIAN" DataTextField="NAMA_BAGIAN" SelectedValue='<%# Bind("KODE_BAGIAN") %>'></asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol2Footer" runat="server" DataSourceID="dsDivision" __designer:wfdid="w279" DataValueField="KODE_BAGIAN" DataTextField="NAMA_BAGIAN"></asp:DropDownList> 
</FooterTemplate>

<HeaderStyle width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("NAMA_BAGIAN") %>' __designer:wfdid="w277"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" __designer:wfdid="w134" CommandName="Update"></asp:ImageButton><asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w135" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" __designer:wfdid="w136" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" __designer:wfdid="w137" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" __designer:wfdid="w133" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle horizontalalign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column4 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender> <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" __designer:wfdid="w32" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" __designer:wfdid="w33" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w34"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" __designer:wfdid="w35" Columns="3" MaxLength="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w36"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w37"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" __designer:wfdid="w38" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" __designer:wfdid="w39" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow"></HeaderStyle>
</asp:GridView><asp:SqlDataSource id="dsSubDivision" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT KODE_SUBBAGIAN, NAMA_SUBBAGIAN, KODE_BAGIAN, NAMA_BAGIAN, KODE_BIRO, KODE_DEPUTI, KODE_UNIT, KODE_INSTANSI, KODE_CABANG FROM q_Subbagian ORDER BY KODE_SUBBAGIAN" OnUpdated="dsSubBagian_Updated" OnDeleted="dsSubBagian_Deleted" OnInserted="dsSubBagian_Inserted" OnInserting="dsSubBagian_Inserting" DeleteCommand="DELETE FROM taSubbagian WHERE (KODE_SUBBAGIAN = @KODE_SUBBAGIAN)" InsertCommand="INSERT INTO taSubbagian(KODE_SUBBAGIAN, NAMA_SUBBAGIAN, KODE_BAGIAN) VALUES (@KODE_SUBBAGIAN, @NAMA_SUBBAGIAN, @KODE_BAGIAN)" UpdateCommand="UPDATE taSubbagian SET NAMA_SUBBAGIAN = @NAMA_SUBBAGIAN, KODE_BAGIAN = @KODE_BAGIAN WHERE (KODE_SUBBAGIAN = @KODE_SUBBAGIAN)"><UpdateParameters>
<asp:Parameter Name="NAMA_SUBBAGIAN"></asp:Parameter>
<asp:Parameter Name="KODE_BAGIAN"></asp:Parameter>
<asp:Parameter Name="KODE_SUBBAGIAN"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_SUBBAGIAN"></asp:Parameter>
<asp:Parameter Name="NAMA_SUBBAGIAN"></asp:Parameter>
<asp:Parameter Name="KODE_BAGIAN"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> <asp:SqlDataSource id="dsDivisionFilter" runat="server" __designer:wfdid="w55" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [KODE_BAGIAN], [NAMA_BAGIAN] FROM [taBagian]"></asp:SqlDataSource> <asp:SqlDataSource id="dsBiroFilter" runat="server" __designer:wfdid="w29" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [KODE_BIRO], [NAMA_BIRO] FROM [taBiro]"></asp:SqlDataSource> <asp:SqlDataSource id="dsDeputiFilter" runat="server" __designer:wfdid="w3" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [KODE_DEPUTI], [NAMA_DEPUTI] FROM [taDeputi]"></asp:SqlDataSource><asp:SqlDataSource id="dsUnitFilter" runat="server" __designer:wfdid="w3" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [KODE_UNIT], [NAMA_UNIT] FROM [taUnit]"></asp:SqlDataSource><asp:FormView id="FvSubBagian" runat="server" DataSourceID="dsSubDivision" DataKeyNames="KODE_SUBBAGIAN" OnItemCommand="FvSubBagian_ItemCommand" EmptyDataText="<%$ Resources:lblEmptyData %>"><InsertItemTemplate>
<table style="WIDTH: 600px; BORDER-COLLAPSE: collapse" cellspacing="0" cellpadding="2" border="1"><tbody><tr><td style="WIDTH: 100px" class="HeaderStyle" align="center"><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w69"></asp:Label></td><td style="WIDTH: 300px" class="HeaderStyle" align="center"><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w70"></asp:Label></td><td style="WIDTH: 150px" class="HeaderStyle" align="center"><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w71"></asp:Label></td><td style="WIDTH: 50px" class="HeaderStyle"></td></tr><tr><td class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("KODE_SUBBAGIAN") %>' __designer:wfdid="w17" MaxLength="7" Columns="7"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" __designer:wfdid="w73" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></td><td class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("NAMA_SUBBAGIAN") %>' __designer:wfdid="w19" MaxLength="110" Columns="30"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" __designer:wfdid="w75" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></td><td class="FooterStyle"><asp:DropDownList id="ddlCol2FormView" runat="server" DataSourceID="dsDivision" __designer:wfdid="w337" DataValueField="KODE_BAGIAN" DataTextField="NAMA_BAGIAN" SelectedValue='<%# Bind("KODE_BAGIAN") %>'></asp:DropDownList></td><td class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" __designer:wfdid="w77" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" __designer:wfdid="w78" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel"></asp:ImageButton></td></tr></tbody></table>
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
                                    Text="<%$ Resources:Resource, lblConfirmDelete %>"></asp:Label>
                            </td>
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
                <asp:SqlDataSource ID="dsDivision" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
                    SelectCommand="SELECT KODE_BAGIAN, NAMA_BAGIAN FROM taBagian where kode_bagian <> '00000' ORDER BY KODE_BAGIAN">
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="dsInstansi" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
                    SelectCommand="SELECT [KODE_INSTANSI], [NAMA_INSTANSI] FROM [taInstansi] ORDER BY [KODE_INSTANSI]">
                </asp:SqlDataSource>
                <asp:Label ID="lblError" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False"></asp:Label><br />
                <br />
            </td>
        </tr>
       
    </table>
</asp:Content>



