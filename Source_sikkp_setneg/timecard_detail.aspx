<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="timecard_detail.aspx.cs" Inherits="rtwin.timecard_detail" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
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
            <td align="left" rowspan="2" style="width: 100%">
                <asp:ScriptManager id="ScriptManager1" runat="server">
                </asp:ScriptManager><asp:UpdatePanel id="UpdatePanel1" runat="server"><contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><br /><br /><asp:Label id="lblTitle2" runat="server" Font-Bold="True" Text="<%$ Resources:lblPengguna %>"></asp:Label><br /><br /><table><tbody><tr><td><asp:Label id="Label5" runat="server" Text="<%$ Resources:Column0 %>"></asp:Label></td><td><asp:DropDownList id="ddlItem0Filter" runat="server" OnSelectedIndexChanged="ddlItem0Filter_DataBound" AutoPostBack="True" DataSourceID="dsRange" AppendDataBoundItems="True" DataValueField="KODE_RANGE" DataTextField="KODE_RANGE" OnDataBound="ddlItem0Filter_DataBound"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></td></tr><tr><td><asp:Label id="Label6" runat="server" Text="<%$ Resources:Column1 %>"></asp:Label></td><td><asp:DropDownList id="ddlItem1Filter" runat="server" OnSelectedIndexChanged="ddlItem0Filter_DataBound" AutoPostBack="True" DataSourceID="dsCabang" AppendDataBoundItems="True" DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG" OnDataBound="ddlItem0Filter_DataBound"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></td></tr></tbody></table><br /><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><br /><br /><asp:GridView id="GvTimeCardDetail" runat="server" DataSourceID="dsRangeDetail" OnDataBound="GridView1_DataBound" DataKeyNames="KODE_RANGE,KODE_DEPARTEMEN" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" OnRowCommand="GridView1_RowCommand1" OnRowDataBound="GridView1_RowDataBound1" OnRowEditing="GridView1_RowEditing" EmptyDataText="<%$ Resources:lblEmptyData %>" OnRowUpdating="GvTimeCardDetail_RowUpdating">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_RANGE" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol0Edit" runat="server" DataSourceID="dsRange" __designer:wfdid="w407" DataTextField="KODE_RANGE" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("KODE_RANGE") %>'></asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol0Footer" runat="server" DataSourceID="dsRange" __designer:wfdid="w408" DataTextField="KODE_RANGE" DataValueField="KODE_RANGE">
                                </asp:DropDownList> 
</FooterTemplate>

<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_RANGE") %>' __designer:wfdid="w412"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_DEPARTEMEN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol1Edit" runat="server" DataSourceID="dsCabang" __designer:wfdid="w410" DataTextField="NAMA_CABANG" DataValueField="KODE_CABANG" SelectedValue='<%# Bind("KODE_DEPARTEMEN") %>'></asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol1Footer" runat="server" DataSourceID="dsCabang" __designer:wfdid="w411" DataTextField="NAMA_CABANG" DataValueField="KODE_CABANG">
                                </asp:DropDownList> 
</FooterTemplate>

<HeaderStyle width="200px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA_DEPARTEMEN") %>' __designer:wfdid="w409"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_RANGE" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:TextBox id="txtCol2Edit" runat="server" Text='<%# Bind("KET_RANGE") %>' width="90%" TextMode="MultiLine" __designer:wfdid="w399" MaxLength="200" Rows="3"></asp:TextBox><br /><asp:RegularExpressionValidator id="valCol2Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="Max 200 Char" ControlToValidate="txtCol2Edit" __designer:wfdid="w400" SetFocusOnError="True" ValidationExpression="^[\s\S]{0,200}$" EnableClientScript="True">*</asp:RegularExpressionValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol2Footer" runat="server" width="90%" TextMode="MultiLine" __designer:wfdid="w401" MaxLength="200" Rows="3"></asp:TextBox><br /><asp:RegularExpressionValidator id="valCol2Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="Max 200 Char" ControlToValidate="txtCol2Footer" __designer:wfdid="w402" SetFocusOnError="True" ValidationExpression="^[\s\S]{0,200}$" EnableClientScript="True">*</asp:RegularExpressionValidator> 
</FooterTemplate>

<HeaderStyle width="350px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("KET_RANGE") %>' __designer:wfdid="w398"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" AlternateText="<%$ Resources:ImgUpdate %>" ImageUrl="~/Images/edit.gif" __designer:wfdid="w286" CommandName="Update"></asp:ImageButton> <asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" __designer:wfdid="w287" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" __designer:wfdid="w288" CommandName="Insert"></asp:ImageButton> <asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" __designer:wfdid="w289" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" AlternateText="<%$ Resources:ImgEdit %>" ImageUrl="~/Images/iedit.gif" __designer:wfdid="w285" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column4 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" ImageUrl="~/Images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" CommandName="Delete" __designer:wfdid="w161"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w162" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w163" targetcontrolid="imgDelete" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_DEPARTEMEN">
<HeaderStyle width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("KODE_DEPARTEMEN") %>' __designer:wfdid="w56"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnFirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First" __designer:wfdid="w114"></asp:ImageButton>&nbsp; <asp:ImageButton id="btnPrev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev" __designer:wfdid="w115"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w116"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" OnTextChanged="txtHalaman_TextChanged1" Columns="3" __designer:wfdid="w117"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w118"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w119"></asp:Label> <asp:ImageButton id="btnNext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next" __designer:wfdid="w120"></asp:ImageButton> <asp:ImageButton id="btnLast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last" __designer:wfdid="w121"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsRangeDetail" runat="server" SelectCommand="SELECT KODE_RANGE, KODE_DEPARTEMEN, KET_RANGE, CASE WHEN KODE_DEPARTEMEN = '---' THEN 'GLOBAL' ELSE NAMA_DEPARTEMEN END AS NAMA_DEPARTEMEN FROM q_RangeDetail ORDER BY KODE_RANGE" ConnectionString="<%$ ConnectionStrings:strCn %>" UpdateCommand="update taRangeDetail set KODE_RANGE = @KODE_RANGE, KODE_DEPARTEMEN=@KODE_DEPARTEMEN, KET_RANGE=@KET_RANGE WHERE KODE_RANGE=@KODE_RANGE_AWAL AND KODE_DEPARTEMEN=@KODE_DEPARTEMEN_AWAL" InsertCommand="insert into taRangeDetail (KODE_RANGE,KODE_DEPARTEMEN,KET_RANGE) values (@KODE_RANGE,@KODE_DEPARTEMEN,@KET_RANGE)" DeleteCommand="delete from taRangeDetail Where KODE_RANGE =@KODE_RANGE AND KODE_DEPARTEMEN=@KODE_DEPARTEMEN" OnDeleted="dsRangeDetail_Deleted" OnInserted="dsRangeDetail_Inserted" OnInserting="dsRangeDetail_Inserting" OnUpdated="dsRangeDetail_Updated"><DeleteParameters>
<asp:Parameter Name="KODE_RANGE"></asp:Parameter>
<asp:Parameter Name="KODE_DEPARTEMEN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="KODE_RANGE"></asp:Parameter>
<asp:Parameter Name="KODE_DEPARTEMEN"></asp:Parameter>
<asp:Parameter Name="KET_RANGE"></asp:Parameter>
<asp:SessionParameter SessionField="sesKodeRangeAwal" Name="KODE_RANGE_AWAL"></asp:SessionParameter>
<asp:SessionParameter SessionField="sesKodeDepartemenAwal" Name="KODE_DEPARTEMEN_AWAL"></asp:SessionParameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_RANGE"></asp:Parameter>
<asp:Parameter Name="KODE_DEPARTEMEN"></asp:Parameter>
<asp:Parameter Name="KET_RANGE"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource>&nbsp; <asp:FormView id="FvTimeCardDetail" runat="server" DataSourceID="dsRangeDetail" DataKeyNames="KODE_RANGE,KODE_DEPARTEMEN" EmptyDataText="<%$ Resources:lblEmptyData %>" __designer:wfdid="w77" OnItemCommand="FvTimeCardDetail_ItemCommand"><InsertItemTemplate>
<table style="BORDER-COLLAPSE: collapse" cellspacing=0 cellpadding=2 width=800 border=1><tbody><tr><td style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w122"></asp:Label></td><td style="WIDTH: 350px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w123"></asp:Label></td><td style="WIDTH: 350px" class="HeaderStyle" align=center><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w124"></asp:Label></td><td style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label7" runat="server" Text="<%$ Resources:Column3 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w125"></asp:Label></td></tr><tr><td class="FooterStyle"><asp:DropDownList id="ddlCol0FormView" runat="server" DataSourceID="dsRange" SelectedValue='<%# Bind("KODE_RANGE") %>' DataValueField="KODE_RANGE" DataTextField="KODE_RANGE" __designer:wfdid="w126"></asp:DropDownList></td><td class="FooterStyle"><asp:DropDownList id="ddlCol1FormView" runat="server" DataSourceID="dsCabang" SelectedValue='<%# Bind("KODE_DEPARTEMEN") %>' DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG" __designer:wfdid="w127"></asp:DropDownList></td><td class="FooterStyle"><asp:TextBox id="txtCol2FormView" runat="server" Text='<%# Bind("KET_RANGE") %>' width="90%" TextMode="MultiLine" Rows="3" MaxLength="200" __designer:wfdid="w128"></asp:TextBox><asp:RegularExpressionValidator id="valCol2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="Max 200 Char" ControlToValidate="txtCol2FormView" ValidationExpression="^[\s\S]{0,200}$" SetFocusOnError="True" __designer:wfdid="w129" EnableClientScript="True">*</asp:RegularExpressionValidator></td><td class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert" __designer:wfdid="w130"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel" __designer:wfdid="w131"></asp:ImageButton></td></tr></tbody></table>
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
        </tr>
        <tr>
        </tr>
        <tr>
            <td align="left">
                <asp:SqlDataSource ID="dsRange" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
                    SelectCommand="SELECT [KODE_RANGE] FROM [taRange]"></asp:SqlDataSource>
                <asp:SqlDataSource ID="dsCabang" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
                    SelectCommand="SELECT KODE_CABANG, CASE WHEN KODE_CABANG = '---' THEN 'GLOBAL' ELSE NAMA_CABANG END AS NAMA_CABANG FROM taCabang">
                </asp:SqlDataSource>
            <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False"></asp:Label>&nbsp;
                </td>
        </tr>
    </table>
</asp:Content>

