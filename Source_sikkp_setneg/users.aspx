<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" Inherits="rtwin.users" CodeFile="users.aspx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <table style="text-align:left">
        <tr>
            <td class="backgroundTitle" style="width:200px">
                <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
            </td>
        </tr>
    </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary> <asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD style="WIDTH: 100px"><BR /><TABLE cellSpacing=0 width=500 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="Label4" runat="server" Text="<%$ Resources:lblCabang %>"></asp:Label> </TD><TD style="WIDTH: 100px" vAlign=top align=left><asp:DropDownList id="ddlFilterItem0" runat="server" DataSourceID="dsCabang" DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG" OnDataBound="btnRefresh_Click"></asp:DropDownList> <asp:SqlDataSource id="dsCabang" runat="server" SelectCommand="SELECT [KODE_CABANG], [NAMA_CABANG] FROM [taCabang] ORDER BY [KODE_CABANG]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource> </TD><TD style="WIDTH: 200px" vAlign=top align=right><asp:button id="btnRefresh" tabIndex=4 onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:button> </TD></TR><TR><TD vAlign=top align=left><asp:Label id="Label7" runat="server" Text="<%$ Resources:lblNama %>"></asp:Label> </TD><TD vAlign=top align=left colSpan=2><asp:TextBox id="txtFilterItem1" runat="server"></asp:TextBox> </TD></TR><TR><TD vAlign=top align=left><asp:CheckBox id="cbLevel" runat="server" Text="<%$ Resources:Column1 %>"></asp:CheckBox> </TD><TD vAlign=top align=left colSpan=2><asp:DropDownList id="ddlFilterItem2" runat="server" DataSourceID="dsLevel" DataValueField="KODE_LEVEL" DataTextField="NAMA_LEVEL"></asp:DropDownList> </TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="90%" border=0><TBODY><TR><TD style="WIDTH: 100%" align=left rowSpan=2><asp:imagebutton style="VERTICAL-ALIGN: middle" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" ImageUrl="images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:imagebutton>&nbsp; <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <BR /><BR /><asp:GridView id="GvUsers" runat="server" DataSourceID="dsUsers" OnDataBound="GvUsers_DataBound" OnRowDataBound="GvUsers_RowDataBound" DataKeyNames="USERNAME" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowCommand="GvUsers_RowCommand">
<FooterStyle VerticalAlign="Top"></FooterStyle>
<Columns>
<asp:TemplateField SortExpression="USERNAME" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
                                                <asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("USERNAME") %>'></asp:Label> 
                                            
</EditItemTemplate>
<FooterTemplate>
                                                <asp:TextBox id="txtCol0Footer" runat="server" Columns="15" MaxLength="20"></asp:TextBox> 
                                                <asp:RequiredFieldValidator id="valCol0Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
                                            
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("USERNAME") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_LEVEL" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
                                                <asp:DropDownList id="ddlCol1Edit" runat="server" DataSourceID="dsLevel" DataTextField="NAMA_LEVEL" DataValueField="KODE_LEVEL" SelectedValue='<%# Bind("KODE_LEVEL") %>'></asp:DropDownList>&nbsp; 
                                            
</EditItemTemplate>
<FooterTemplate>
                                                <asp:DropDownList id="ddlCol1Footer" runat="server" DataSourceID="dsLevel" DataValueField="KODE_LEVEL" DataTextField="NAMA_LEVEL"></asp:DropDownList> 
                                            
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
                                                <asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA_LEVEL") %>'></asp:Label> 
                                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NIP" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:TextBox id="txtCol2Edit" runat="server" Text='<%# Bind("NIP") %>' AutoPostBack="True" width="100px" OnTextChanged="txtCol2Edit_TextChanged"></asp:TextBox>&nbsp; <asp:LinkButton id="lnkCol2Edit" onclick="lnkCol2Edit_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton> <BR /><asp:RequiredFieldValidator id="valCol2Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol2Edit" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol2Footer" runat="server" AutoPostBack="True" width="100px" OnTextChanged="txtCol2Footer_TextChanged"></asp:TextBox>&nbsp; <asp:LinkButton id="lnkCol2Footer" onclick="lnkCol2Footer_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton> <BR /><asp:RequiredFieldValidator id="valCol2Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol2Footer" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<HeaderStyle Width="200px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("NIP") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
<asp:Label id="lblCol3Edit" runat="server" Text='<%# Eval("NAMA") %>'></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:Label id="lblCol3Footer" runat="server"></asp:Label> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_CABANG" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
<asp:Label id="lblCol4Edit" runat="server" Text='<%# Bind("NAMA_CABANG") %>'></asp:Label> 
</EditItemTemplate>

<HeaderStyle Width="200px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("NAMA_CABANG") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Edit %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton>&nbsp; <asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Insert"></asp:ImageButton> <asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Del %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" ImageUrl="~/Images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender> <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" PopupControlID="PNLKonfirmasi" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Rights %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:LinkButton id="Item2" runat="server" CausesValidation="False" CommandName="Select" ToolTip="<%$ Resources:Rights %>">
                                        <asp:Image runat="server" ID="ImdDep" AlternateText="<%$ Resources:ImgDep %>" ImageUrl="images/icon_fav.gif"></asp:Image>
                                    </asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:ResetPass %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="btnReset" runat="server" ImageUrl="~/images/kunci2.gif" CommandName="Reset"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender2" runat="server" targetcontrolid="btnReset" displaymodalpopupid="ModalPopupExtender2"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender2" runat="server" PopupControlID="PNLKonfirmasi" targetcontrolid="btnReset" backgroundcssclass="modalBackground" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender> 
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

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsUsers" runat="server" SelectCommand="SELECT USERNAME, KODE_LEVEL, NAMA_LEVEL, NIP, NAMA, KODE_CABANG, NAMA_CABANG FROM q_Users" ConnectionString="<%$ ConnectionStrings:strCn %>" OnUpdated="dsUsers_Updated" OnInserting="dsUsers_Inserting" OnInserted="dsUsers_Inserted" UpdateCommand="UPDATE taUsers SET KODE_LEVEL = @KODE_LEVEL, NIP = @NIP WHERE (USERNAME = @USERNAME)" InsertCommand="INSERT INTO taUsers(USERNAME,PASSW, KODE_LEVEL, NIP) VALUES (@USERNAME, @PASSW, @KODE_LEVEL, @NIP)" DeleteCommand="DELETE FROM taUsers WHERE (USERNAME = @USERNAME)">
                    <DeleteParameters>
                        <asp:Parameter Name="USERNAME"></asp:Parameter>
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="KODE_LEVEL"></asp:Parameter>
                        <asp:Parameter Name="NIP"></asp:Parameter>
                        <asp:Parameter Name="USERNAME"></asp:Parameter>
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="USERNAME"></asp:Parameter>
                        <asp:Parameter Name="KODE_LEVEL"></asp:Parameter>
                        <asp:Parameter Name="NIP"></asp:Parameter>
                        <asp:Parameter Name="PASSW"></asp:Parameter>
                    </InsertParameters>
                </asp:SqlDataSource> <asp:FormView id="FvUsers" runat="server" DataSourceID="dsUsers" DataKeyNames="USERNAME" EmptyDataText="<%$ Resources:lblEmptyData %>" OnItemCommand="FvUsers_ItemCommand">
                    <InsertItemTemplate>
                        <table style="WIDTH: 700px; BORDER-COLLAPSE: collapse" cellspacing="0" cellpadding="2" border="1">
                            <tbody>
                                <tr>
                                    <td style="WIDTH: 150px" class="HeaderStyle" align="center">
                                        <asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label>
                                    </td>
                                    <td style="WIDTH: 150px" class="HeaderStyle" align="center">
                                        <asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label>
                                    </td>
                                    <td style="WIDTH: 200px" class="HeaderStyle" align="center">
                                        <asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label>
                                    </td>
                                    <td style="WIDTH: 150px" class="HeaderStyle" align="center">
                                        <asp:Label id="Label5" runat="server" Text="<%$ Resources:Column3 %>"></asp:Label>
                                    </td>
                                    <td style="WIDTH: 50px" class="HeaderStyle">
                                    </td>
                                </tr>
                                <tr>
                                    <td class="FooterStyle">
                                        <asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("USERNAME") %>' Columns="15" MaxLength="20"></asp:TextBox> 
                                        <asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td class="FooterStyle">&nbsp;
                                        <asp:DropDownList id="ddlCol1FormView" runat="server" DataSourceID="dsLevel" DataValueField="KODE_LEVEL" DataTextField="NAMA_LEVEL" SelectedValue='<%# Bind("KODE_LEVEL") %>'></asp:DropDownList>
                                    </td>
                                    <td class="FooterStyle">
                                        <asp:TextBox id="txtCol2FormView" runat="server" Text='<%# Bind("NIP") %>' AutoPostBack="True" width="100px" OnTextChanged="txtCol2FormView_TextChanged"></asp:TextBox>&nbsp;
                                        <asp:LinkButton id="lnkCol2FormView" onclick="lnkCol2FormView_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton>&nbsp; 
                                        <asp:RequiredFieldValidator id="valCol2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol2FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                    </td>
                                    <td class="FooterStyle">
                                        <asp:Label id="lblCol3FormView" runat="server"></asp:Label>
                                    </td>
                                    <td class="FooterStyle">
                                        <asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Insert"></asp:ImageButton>&nbsp;
                                        <asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel"></asp:ImageButton>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </InsertItemTemplate>
                </asp:FormView> <asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton> <cc1:ModalPopupExtender id="LookupMPE" runat="server" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="PNL_Lookup" targetcontrolid="lnkLookupTriger"></cc1:ModalPopupExtender> </TD></TR><TR></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsLevel" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_LEVEL], [NAMA_LEVEL] FROM [taUserLevel] WHERE KODE_LEVEL >= @KODE_LEVEL ORDER BY KODE_LEVEL">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="1" Name="KODE_LEVEL" SessionField="GradeID" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel ID="PNLKonfirmasi" runat="server" Style="border-right: black 2px solid;
        padding-right: 20px; border-top: black 2px solid; display: none; padding-left: 20px;
        padding-bottom: 20px; border-left: black 2px solid; width: 300px; padding-top: 20px;
        border-bottom: black 2px solid; background-color: white">
        <asp:Label ID="lblConfirmTitle" runat="server" Font-Bold="True" Font-Size="Small"
            Text="<%$ Resources:Resource, lblConfirmation %>"></asp:Label>
        <hr />
        <table>
            <tr>
                <td colspan="2">
                    <asp:Label ID="lblConfirm" runat="server" Font-Bold="True" Font-Size="Small" Text="<%$ Resources:confirm %>"></asp:Label>
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
            <asp:LinkButton ID="lblGantiPassword" runat="server" Text="<%$ Resources:ChangePass %>" OnClick="lblGantiPassword_Click"></asp:LinkButton>
    <br />
    <br />
    <asp:Button ID="btnGenerateUsers" runat="server" OnClick="btnGenerateUsers_Click"
        Text="Generate Users" /><br />
    <asp:Panel ID="PNL_Lookup" runat="server" Style="border-right: black 2px solid; padding-right: 20px;
        border-top: black 2px solid; display: none; padding-left: 20px; padding-bottom: 20px;
        border-left: black 2px solid; width: 300px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white; width:600px">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small"></asp:Label> 
<HR />
<asp:Label id="lblLookupCariPegawai" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblNama %>" Font-Size="Small"></asp:Label> <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan="2"><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" OnDataBound="GvLookupPegawai_DataBound" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NIP"><Columns>
<asp:TemplateField SortExpression="NIP" HeaderText="NIP"><EditItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("NIP") %>'></asp:Label>
                                                
</EditItemTemplate>

<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("NIP") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="PIN" SortExpression="PIN" HeaderText="PIN">
<HeaderStyle width="100px"></HeaderStyle>
</asp:BoundField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Resource, lblNama %>"><EditItemTemplate>
<asp:TextBox id="TextBox1" runat="server" Text='<%# Bind("NAMA") %>'></asp:TextBox> 
</EditItemTemplate>

<HeaderStyle width="300px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label2" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Resource, lblPilih %>" ShowHeader="False">
<HeaderStyle width="70px"></HeaderStyle>
<ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" Text="<%$ Resources:Resource, lblPilih %>" CausesValidation="False" CommandName="Select"></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" CausesValidation="False" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" CausesValidation="False" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalamanLookup_TextChanged" Columns="3" MaxLength="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" CausesValidation="False" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" CausesValidation="False" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan="2"><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" AlternateText="<%$ Resources:Resource, lblClose %>" ImageUrl="~/images/exit4_16.png"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
    <asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>" Visible="False"></asp:Label>
                    <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                        Visible="False"></asp:Label><asp:Label ID="lblNotSaved" runat="server"
                            Text="<%$ Resources:Resource, lblNotSaved %>" Visible="False" width="704px"></asp:Label><br />
</asp:Content>
			