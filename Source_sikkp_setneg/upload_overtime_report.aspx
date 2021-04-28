<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="upload_overtime_report.aspx.cs" Inherits="rtwin.upload_report" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" rowSpan=2>
    &nbsp;
</TD></TR><TR></TR><TR><TD style="WIDTH: 100%; HEIGHT: 13px" align=left> </TD></TR><TR><TD style="WIDTH: 100%; HEIGHT: 13px" align=left><BR /><asp:Label id="ExceptionDetails2" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><BR /><asp:Label id="lblTitlePengesahan" runat="server" CssClass="lblTitle" SkinID="lblTitle" Font-Bold="True" Text="<%$ Resources:lblTitlePengesahan %>" forecolor="Black"></asp:Label><BR /><BR /><TABLE><TBODY><TR><TD style="WIDTH: 100px"><asp:Label id="lblFilterSatker" runat="server" Text="<%$ Resources:lblSatuanKerja %>" Visible="False"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="ddlFilterSatker" runat="server" OnSelectedIndexChanged="ddlFilterSatKer_ValueChange" AutoPostBack="True" DataSourceID="dsCabang" OnDataBound="ddlFilterSatKer_ValueChange" DataValueField="USERNAME" DataTextField="USERNAME" Visible="False"></asp:DropDownList> </TD></TR></TBODY></TABLE><BR /><asp:ImageButton id="imgBtnAddSignVal" onclick="imgBtnAddSignVal_Click" runat="server" AlternateText="<%$Resources:ImgAdd %>" ImageUrl="~/images/ipost.gif" Visible="False"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkBtnAddSignVal" onclick="lnkBtnAddSignVal_Click" runat="server" Text="<%$Resources:ImgAdd %>" Visible="False"></asp:LinkButton><BR /><BR /><asp:GridView id="gvLaporanPengesahan" runat="server" DataSourceID="dsLaporanPengesahan" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="KODE_LAPORAN,USERNAME" OnDataBound="gvLaporanPengesahan_DataBound" OnRowCommand="gvLaporanPengesahan_RowCommand" OnRowDataBound="GvLaporan_RowDataBound" EmptyDataText="<%$ Resources:Resource, lblEmptyData %>" Width="1200px">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_LAPORAN" HeaderText="<%$ Resources:Column_0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Eval("KODE_LAPORAN") %>'></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol0Footer" runat="server" DataSourceID="DsReport" DataTextField="NAMA_LAPORAN" DataValueField="KODE_LAPORAN"></asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_LAPORAN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="Nama Laporan" SortExpression="NAMA_LAPORAN">
        <EditItemTemplate>
            <asp:Label ID="Label1Edit" runat="server" Text='<%# Bind("NAMA_LAPORAN") %>'></asp:Label>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="Label1Item" runat="server" Text='<%# Bind("NAMA_LAPORAN") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField SortExpression="USERNAME" HeaderText="<%$ Resources:Column_1 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol1Edit" runat="server" DataSourceID="dsCabang2" DataValueField="USERNAME" DataTextField="USERNAME" SelectedValue='<%# Eval("USERNAME") %>' Enabled="False"></asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol1Footer" runat="server" DataSourceID="dsCabang2" DataValueField="USERNAME" DataTextField="USERNAME"></asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("USERNAME") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD1_HEADER" HeaderText="<%$ Resources:Column_2 %>"><EditItemTemplate>
<asp:TextBox id="txtCol2Edit" runat="server" Text='<%# Bind("TTD1_HEADER") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol2Footer" runat="server" width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TTD1_HEADER") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD1" HeaderText="<%$ Resources:Column_3 %>"><EditItemTemplate>
<asp:TextBox id="txtCol3Edit" runat="server" Text='<%# Bind("TTD1") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol3Footer" runat="server" width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("TTD1") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD2_HEADER" HeaderText="<%$ Resources:Column_4 %>"><EditItemTemplate>
<asp:TextBox id="txtCol4Edit" runat="server" Text='<%# Bind("TTD2_HEADER") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol4Footer" runat="server" width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("TTD2_HEADER") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD2" HeaderText="<%$ Resources:Column_5 %>"><EditItemTemplate>
<asp:TextBox id="txtCol5Edit" runat="server" Text='<%# Bind("TTD2") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol5Footer" runat="server" width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("TTD2") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD3_HEADER" HeaderText="<%$ Resources:Column_6 %>"><EditItemTemplate>
<asp:TextBox id="txtCol6Edit" runat="server" Text='<%# Bind("TTD3_HEADER") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol6Footer" runat="server" width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("TTD3_HEADER") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD3" HeaderText="<%$ Resources:Column_7 %>"><EditItemTemplate>
<asp:TextBox id="txtCol7Edit" runat="server" Text='<%# Bind("TTD3") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol7Footer" runat="server" width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# Bind("TTD3") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column_8 %>"><EditItemTemplate>
<asp:ImageButton id="btnUpdate" runat="server" ImageUrl="~/images/edit.gif" CommandName="Update" ToolTip="<%$ Resources:ImgUpdate %>"></asp:ImageButton>&nbsp;<asp:ImageButton id="ImageButton3" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" CommandName="Cancel" ToolTip="<%$ Resources:ImgDel%>"></asp:ImageButton>
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="btnInsert" runat="server" ImageUrl="~/images/edit.gif" CommandName="Insert" ToolTip="<%$ Resources:ImgInsert %>"></asp:ImageButton>&nbsp;<asp:ImageButton id="btncancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" CommandName="Cancel_Insert" ToolTip="<%$ Resources:ImgCancel %>"></asp:ImageButton>
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="ImageButton1" runat="server" ImageUrl="~/images/iedit.gif" ToolTip="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column_9 %>" Visible="False">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" CommandName="Delete" ToolTip="Delete"></asp:ImageButton><cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnFirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> <asp:ImageButton id="btnPrev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged1"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label>&nbsp;<asp:ImageButton id="btnNext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton>&nbsp;<asp:ImageButton id="btnLast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView><asp:SqlDataSource id="dsLaporanPengesahan" runat="server" SelectCommand="SELECT taLaporanPengesahanLembur.KODE_LAPORAN, taLaporanPengesahanLembur.USERNAME, taLaporanPengesahanLembur.TTD1_HEADER, taLaporanPengesahanLembur.TTD1, taLaporanPengesahanLembur.TTD2_HEADER, taLaporanPengesahanLembur.TTD2, taLaporanPengesahanLembur.TTD3_HEADER, taLaporanPengesahanLembur.TTD3, taLaporan.NAMA_LAPORAN FROM taLaporanPengesahanLembur INNER JOIN taLaporan ON taLaporanPengesahanLembur.KODE_LAPORAN = taLaporan.KODE_LAPORAN WHERE (taLaporanPengesahanLembur.USERNAME = @USERNAME)" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taLaporanPengesahanLembur WHERE (KODE_LAPORAN = @KODE_LAPORAN) AND (USERNAME = @USERNAME)" InsertCommand="INSERT INTO taLaporanPengesahanLembur(KODE_LAPORAN, USERNAME, TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3) VALUES (@KODE_LAPORAN, @USERNAME, @TTD1_HEADER, @TTD1, @TTD2_HEADER, @TTD2, @TTD3_HEADER, @TTD3)" UpdateCommand="UPDATE taLaporanPengesahanLembur SET TTD1_HEADER = @TTD1_HEADER, TTD1 = @TTD1, TTD2_HEADER = @TTD2_HEADER, TTD2 = @TTD2, TTD3_HEADER = @TTD3_HEADER, TTD3 = @TTD3 WHERE (KODE_LAPORAN = @KODE_LAPORAN) AND (USERNAME = @USERNAME)" OnDeleted="dsLaporanPengesahan_Deleted" OnInserted="dsLaporanPengesahan_Inserted" OnInserting="dsLaporanPengesahan_Inserting" OnUpdated="dsLaporanPengesahan_Updated"><DeleteParameters>
<asp:Parameter Name="KODE_LAPORAN"></asp:Parameter>
<asp:Parameter Name="USERNAME"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="TTD1_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD1"></asp:Parameter>
<asp:Parameter Name="TTD2_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD2"></asp:Parameter>
<asp:Parameter Name="TTD3_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD3"></asp:Parameter>
<asp:Parameter Name="KODE_LAPORAN"></asp:Parameter>
<asp:Parameter Name="USERNAME"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_LAPORAN"></asp:Parameter>
<asp:Parameter Name="USERNAME"></asp:Parameter>
<asp:Parameter Name="TTD1_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD1"></asp:Parameter>
<asp:Parameter Name="TTD2_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD2"></asp:Parameter>
<asp:Parameter Name="TTD3_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD3"></asp:Parameter>
</InsertParameters>
    <SelectParameters>
        <asp:SessionParameter Name="USERNAME" SessionField="UserID" />
    </SelectParameters>
</asp:SqlDataSource> <asp:FormView id="FvLaporanPengesahan" runat="server" DataSourceID="dsLaporanPengesahan" DataKeyNames="KODE_LAPORAN,USERNAME" EmptyDataText="<%$ Resources:Resource, lblEmptyData %>" OnItemCommand="FvLaporanPengesahan_ItemCommand"><InsertItemTemplate>
<TABLE style="WIDTH: 1200px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=2 border=1><TBODY><TR><TD style="WIDTH: 100px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column_0 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 100px" class="HeaderStyle" align=center><asp:Label id="Label8" runat="server" Text="<%$ Resources:Column_1 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label10" runat="server" Text="<%$ Resources:Column_2 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label11" runat="server" Text="<%$ Resources:Column_3 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label14" runat="server" Text="<%$ Resources:Column_4 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label15" runat="server" Text="<%$ Resources:Column_5 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label16" runat="server" Text="<%$ Resources:Column_6 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label17" runat="server" Text="<%$ Resources:Column_7 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></TD><TD style="WIDTH: 100px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle">&nbsp;<asp:DropDownList id="ddlCol0FormView" runat="server" DataSourceID="DsReport" DataValueField="KODE_LAPORAN" DataTextField="NAMA_LAPORAN" SelectedValue='<%# Bind("KODE_LAPORAN") %>'></asp:DropDownList></TD><TD class="FooterStyle">&nbsp;<asp:DropDownList id="ddlCol1FormView" runat="server" DataSourceID="dsCabang2" DataValueField="USERNAME" DataTextField="USERNAME" SelectedValue='<%# Bind("USERNAME") %>'></asp:DropDownList></TD><TD class="FooterStyle"><asp:TextBox id="txtCol2FormView" runat="server" Text='<%# Bind("TTD1_HEADER") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol3Edit" runat="server" Text='<%# Bind("TTD1") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol4Edit" runat="server" Text='<%# Bind("TTD2_HEADER") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol5Edit" runat="server" Text='<%# Bind("TTD2") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol6Edit" runat="server" Text='<%# Bind("TTD3_HEADER") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol7Edit" runat="server" Text='<%# Bind("TTD3") %>' width="140px" TextMode="MultiLine" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> 
    <asp:SqlDataSource ID="DsReport" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        DeleteCommand="DELETE FROM taLaporan WHERE (KODE_LAPORAN = @KODE_LAPORAN)" InsertCommand="INSERT INTO taLaporan(KODE_LAPORAN, NAMA_LAPORAN, NAMA_LAPORAN_en, KOLOM, KOLOM_GROUP,KOLOM_FILTER, FILE_LAPORAN, TIPE_LAPORAN, PERIODE_LAPORAN, LAP_ADMIN, LAP_OPERATOR, LAP_KEUANGAN, LAP_USER) VALUES (@KODE_LAPORAN, @NAMA_LAPORAN, @NAMA_LAPORAN_en, @KOLOM, @KOLOM_GROUP,@KOLOM_FILTER, @FILE_LAPORAN, @TIPE_LAPORAN, @PERIODE_LAPORAN, @LAP_ADMIN, @LAP_OPERATOR, @LAP_KEUANGAN, @LAP_USER)"
        SelectCommand="SELECT KODE_LAPORAN, NAMA_LAPORAN FROM taLaporan&#13;&#10;WHERE KODE_LAPORAN IN ('E8','E9','EA','EB')"
        UpdateCommand="UPDATE taLaporan SET NAMA_LAPORAN = @NAMA_LAPORAN, NAMA_LAPORAN_en = @NAMA_LAPORAN_en, KOLOM = @KOLOM, KOLOM_GROUP = @KOLOM_GROUP,KOLOM_FILTER = @KOLOM_FILTER, FILE_LAPORAN = @FILE_LAPORAN, TIPE_LAPORAN = @TIPE_LAPORAN,  PERIODE_LAPORAN = @PERIODE_LAPORAN, LAP_ADMIN = @LAP_ADMIN, LAP_OPERATOR = @LAP_OPERATOR, LAP_KEUANGAN = @LAP_KEUANGAN, LAP_USER = @LAP_USER  WHERE KODE_LAPORAN = @KODE_LAPORAN">
        <DeleteParameters>
            <asp:Parameter Name="KODE_LAPORAN" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="KODE_LAPORAN" />
            <asp:Parameter Name="NAMA_LAPORAN" />
            <asp:Parameter Name="NAMA_LAPORAN_en" />
            <asp:Parameter Name="KOLOM" />
            <asp:Parameter Name="KOLOM_GROUP" />
            <asp:Parameter Name="KOLOM_FILTER" />
            <asp:Parameter Name="FILE_LAPORAN" />
            <asp:Parameter Name="TIPE_LAPORAN" />
            <asp:Parameter Name="PERIODE_LAPORAN" />
            <asp:Parameter Name="LAP_ADMIN" />
            <asp:Parameter Name="LAP_OPERATOR" />
            <asp:Parameter Name="LAP_KEUANGAN" />
            <asp:Parameter Name="LAP_USER" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="KODE_LAPORAN" />
            <asp:Parameter Name="NAMA_LAPORAN" />
            <asp:Parameter Name="NAMA_LAPORAN_en" />
            <asp:Parameter Name="KOLOM" />
            <asp:Parameter Name="KOLOM_GROUP" />
            <asp:Parameter Name="KOLOM_FILTER" />
            <asp:Parameter Name="FILE_LAPORAN" />
            <asp:Parameter Name="TIPE_LAPORAN" />
            <asp:Parameter DefaultValue="" Name="PERIODE_LAPORAN" />
            <asp:Parameter DefaultValue="1" Name="LAP_ADMIN" />
            <asp:Parameter DefaultValue="1" Name="LAP_OPERATOR" />
            <asp:Parameter DefaultValue="1" Name="LAP_KEUANGAN" />
            <asp:Parameter DefaultValue="1" Name="LAP_USER" />
        </InsertParameters>
    </asp:SqlDataSource>
</TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False" Visible="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tbody><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
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
                    <asp:Label ID="Label7" runat="server" Font-Bold="True" Font-Size="Small" Text="<%$ Resources:Resource, lblConfirmDelete %>"></asp:Label></td>
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
    <asp:SqlDataSource ID="dsCabang" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [USERNAME] FROM [taUsers] ORDER BY [USERNAME]">
    </asp:SqlDataSource><asp:SqlDataSource ID="dsCabang2" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT USERNAME FROM taUsers WHERE USERNAME = @USERNAME">
        <SelectParameters>
            <asp:SessionParameter Name="USERNAME" SessionField="UserID" />
        </SelectParameters>
    </asp:SqlDataSource>
            <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
        Visible="False" width="651px"></asp:Label><asp:Label ID="lblFieldCannotEmpty" runat="server"
            Text="<%$ Resources:Resource, lblFieldCannotEmpty %>" Visible="False" width="566px"></asp:Label><asp:Label
                ID="lblNotSaved" runat="server" Text="<%$ Resources:Resource, lblNotSaved %>"
                Visible="False" width="1013px"></asp:Label><asp:Label ID="lblConfirmDelete" runat="server"
                    Text="<%$ Resources:Resource, lblConfirmDelete %>" Visible="False" width="387px"></asp:Label>
</asp:Content>


