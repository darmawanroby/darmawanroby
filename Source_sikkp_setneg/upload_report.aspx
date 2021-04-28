<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="upload_report.aspx.cs" Inherits="rtwin.upload_report" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
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
<asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" rowSpan=2><asp:ImageButton id="ImageButton2" onclick="ImgAdd_Click" runat="server" AlternateText="<%$Resources:ImgAdd %>" ImageUrl="~/images/ipost.gif"></asp:ImageButton> &nbsp;<asp:LinkButton id="LinkButton1" onclick="LinkButton1_Click" runat="server" Text="<%$Resources:ImgAdd %>"></asp:LinkButton> <BR /><BR /><asp:GridView id="GvLaporan" runat="server" DataSourceID="DsReport" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="KODE_LAPORAN" OnDataBound="GvLaporan_DataBound" OnRowCommand="GvLaporan_RowCommand" OnRowDataBound="GvLaporan_RowDataBound" Width="1340px">
<FooterStyle VerticalAlign="Top"></FooterStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_LAPORAN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
                    &nbsp;
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("KODE_LAPORAN") %>'></asp:Label>
                
</EditItemTemplate>
<FooterTemplate>
                    <asp:TextBox ID="txtkode" runat="server" width="50px" MaxLength="3"></asp:TextBox>
              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtkode"
                        ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>"></asp:RequiredFieldValidator>
                
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("KODE_LAPORAN") %>' __designer:wfdid="w1"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_LAPORAN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NAMA_LAPORAN") %>' width="150px" Columns="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox1"
                        CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>"></asp:RequiredFieldValidator>
                
</EditItemTemplate>
<FooterTemplate>
                    <asp:TextBox ID="txtNamaLaporan" runat="server" Text='<%# Bind("NAMA_LAPORAN") %>' width="150px" Columns="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtNamaLaporan"
                        ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" CssClass="fontR" SkinID="fontR"></asp:RequiredFieldValidator>
                
</FooterTemplate>

<HeaderStyle Width="160px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("NAMA_LAPORAN") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_LAPORAN_en" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NAMA_LAPORAN_en") %>' width="150px" Columns="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="TextBox1"
                        CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>"></asp:RequiredFieldValidator>
                
</EditItemTemplate>
<FooterTemplate>
                    <asp:TextBox ID="txtNamaLaporanEn" runat="server" Text='<%# Bind("NAMA_LAPORAN_en") %>' width="150px" Columns="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtNamaLaporanEn"
                        ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" CssClass="fontR" SkinID="fontR"></asp:RequiredFieldValidator>
                
</FooterTemplate>

<HeaderStyle Width="160px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("NAMA_LAPORAN_en") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KOLOM" HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("KOLOM") %>' width="70px" Columns="30"></asp:TextBox>
                
</EditItemTemplate>
<FooterTemplate>
                    <asp:TextBox ID="txtKolom" runat="server" Text='<%# Bind("KOLOM") %>' width="70px" Columns="30"></asp:TextBox>
                
</FooterTemplate>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label4" runat="server" Text='<%# Bind("KOLOM") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KOLOM_GROUP" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
                    <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("KOLOM_GROUP") %>' width="70px" Columns="30"></asp:TextBox>
                
</EditItemTemplate>
<FooterTemplate>
                    <asp:TextBox ID="txtKolomGroup" runat="server" Text='<%# Bind("KOLOM_GROUP") %>' width="70px" Columns="30"></asp:TextBox>
                
</FooterTemplate>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label5" runat="server" Text='<%# Bind("KOLOM_GROUP") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KOLOM_FILTER" HeaderText="<%$ Resources:Column5 %>"><EditItemTemplate>
                    <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("KOLOM_FILTER") %>' width="200px" Columns="30"></asp:TextBox>
                
</EditItemTemplate>
<FooterTemplate>
                    <asp:TextBox ID="txtKolomFilter" runat="server" Text='<%# Bind("KOLOM_FILTER") %>' width="200px" Columns="30"></asp:TextBox>
                
</FooterTemplate>

<HeaderStyle Width="210px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label9" runat="server" Text='<%# Bind("KOLOM_FILTER") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="FILE_LAPORAN" HeaderText="<%$ Resources:Column6 %>"><EditItemTemplate>
                    <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("FILE_LAPORAN") %>' width="110px" Columns="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="TextBox5"
                        CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>"></asp:RequiredFieldValidator>
                
</EditItemTemplate>
<FooterTemplate>
                    <asp:TextBox ID="txtFileLaporan" runat="server" Text='<%# Bind("FILE_LAPORAN") %>' width="110px" Columns="30"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtFileLaporan"
                        ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" CssClass="fontR" SkinID="fontR"></asp:RequiredFieldValidator>
                
</FooterTemplate>

<HeaderStyle Width="120px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label6" runat="server" Text='<%# Bind("FILE_LAPORAN") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TIPE_LAPORAN" HeaderText="<%$ Resources:Column7 %>"><EditItemTemplate>
                    &nbsp;<asp:DropDownList ID="ddlTipeLaporan" runat="server" SelectedValue='<%# Bind("TIPE_LAPORAN") %>'>
                        <asp:ListItem Value="0">Tidak Tampil</asp:ListItem>
                        <asp:ListItem Value="1">Rinci</asp:ListItem>
                        <asp:ListItem Value="2">Rekap</asp:ListItem>
                    </asp:DropDownList>
                
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:DropDownList ID="ddlTipeLaporan" runat="server">
                        <asp:ListItem Value="0">Tidak Tampil</asp:ListItem>
                        <asp:ListItem Value="1">Rinci</asp:ListItem>
                        <asp:ListItem Value="2">Rekap</asp:ListItem>
                    </asp:DropDownList>
                
</FooterTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label12" runat="server" Text='<%# Bind("TIPE") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="PERIODE_LAPORAN" HeaderText="<%$ Resources:Column10 %>"><EditItemTemplate>
                    &nbsp;<asp:DropDownList ID="ddlPeriodeLaporan" runat="server" SelectedValue='<%# Bind("PERIODE_LAPORAN") %>'>
                        <asp:ListItem Value="0">Harian</asp:ListItem>
                        <asp:ListItem Value="1">Bulanan</asp:ListItem>
                        <asp:ListItem Value="2">Tahunan</asp:ListItem>
                    </asp:DropDownList>
                
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:DropDownList ID="ddlPeriodeLaporan" runat="server">
                        <asp:ListItem Value="0">Harian</asp:ListItem>
                        <asp:ListItem Value="1">Bulanan</asp:ListItem>
                        <asp:ListItem Value="2">Tahunan</asp:ListItem>
                    </asp:DropDownList>
                
</FooterTemplate>

<HeaderStyle Width="80px"></HeaderStyle>
<ItemTemplate>
                    <asp:Label ID="Label13" runat="server" Text='<%# Bind("PERIODE") %>'></asp:Label>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LAP_ADMIN" HeaderText="<%$ Resources:Column11 %>"><EditItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapAdm" runat="server" Checked='<%# Bind("LAP_ADMIN") %>'>
                    </asp:CheckBox>
                
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapAdm" runat="server" Checked='<%# Bind("LAP_ADMIN") %>'>
                    </asp:CheckBox>
                
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapAdm" runat="server" Checked='<%# Bind("LAP_ADMIN") %>' Enabled="False">
                    </asp:CheckBox>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LAP_OPERATOR" HeaderText="<%$ Resources:Column12 %>"><EditItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapAdm2" runat="server" Checked='<%# Bind("LAP_OPERATOR") %>'>
                    </asp:CheckBox>
                
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapAdm2" runat="server" Checked='<%# Bind("LAP_OPERATOR") %>'>
                    </asp:CheckBox>
                
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapAdm2" runat="server" Checked='<%# Bind("LAP_OPERATOR") %>' Enabled="False">
                    </asp:CheckBox>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LAP_KEUANGAN" HeaderText="<%$ Resources:Column14 %>"><EditItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapKeu" runat="server" Checked='<%# Bind("LAP_KEUANGAN") %>'>
                    </asp:CheckBox>
                
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapKeu" runat="server" Checked='<%# Bind("LAP_KEUANGAN") %>'>
                    </asp:CheckBox>
                
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapKeu" runat="server" Checked='<%# Bind("LAP_KEUANGAN") %>' Enabled="False">
                    </asp:CheckBox>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LAP_USER" HeaderText="<%$ Resources:Column13 %>"><EditItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapUser" runat="server" Checked='<%# Bind("LAP_USER") %>'>
                    </asp:CheckBox>
                
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapUser" runat="server" Checked='<%# Bind("LAP_USER") %>'>
                    </asp:CheckBox>
                
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
                    &nbsp;<asp:CheckBox ID="cbLapUser" runat="server" Checked='<%# Bind("LAP_USER") %>' Enabled="False">
                    </asp:CheckBox>
                
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column8 %>"><EditItemTemplate>
&nbsp;<asp:ImageButton id="btnUpdate" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w14" CommandName="Update" ToolTip="<%$ Resources:ImgUpdate %>"></asp:ImageButton> <asp:ImageButton id="btncancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w15" CommandName="Cancel" ToolTip="<%$ Resources:ImgDel%>"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
&nbsp;<asp:ImageButton id="btnInsert" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w16" CommandName="Insert" ToolTip="<%$ Resources:ImgInsert %>"></asp:ImageButton> <asp:ImageButton id="btncancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w17" CommandName="Cancel_Insert" ToolTip="<%$ Resources:ImgCancel %>"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="ImageButton1" runat="server" ImageUrl="~/images/iedit.gif" __designer:wfdid="w13" CommandName="Edit" ToolTip="<%$ Resources:ImgEdit %>"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle Width="50px"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column9 %>"><HeaderTemplate>
                    Delete
                
</HeaderTemplate>
<FooterTemplate>
                    &nbsp;
                
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" __designer:wfdid="w4" CommandName="Delete" ToolTip="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w5" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w6" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnFirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First" __designer:wfdid="w11"></asp:ImageButton>&nbsp; <asp:ImageButton id="btnPrev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev" __designer:wfdid="w12"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w13"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged" __designer:wfdid="w14"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w15"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w16"></asp:Label>&nbsp;<asp:ImageButton id="btnNext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next" __designer:wfdid="w17"></asp:ImageButton>&nbsp;<asp:ImageButton id="btnLast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last" __designer:wfdid="w18"></asp:ImageButton> 
</PagerTemplate>

<EditRowStyle VerticalAlign="Top"></EditRowStyle>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="DsReport" runat="server" SelectCommand="SELECT KODE_LAPORAN, NAMA_LAPORAN, NAMA_LAPORAN_en, KOLOM, KOLOM_GROUP,KOLOM_FILTER, FILE_LAPORAN, CASE WHEN TIPE_LAPORAN = '1' THEN 'Rinci' ELSE (CASE WHEN TIPE_LAPORAN = '2' THEN 'Rekap' ELSE 'Tidak Tampil' END) END AS TIPE,TIPE_LAPORAN, CASE WHEN PERIODE_LAPORAN = '1' THEN 'Bulanan' ELSE (CASE WHEN TIPE_LAPORAN = '2' THEN 'Tahunan' ELSE '' END) END AS PERIODE, PERIODE_LAPORAN, LAP_ADMIN, LAP_OPERATOR, LAP_KEUANGAN, LAP_USER FROM taLaporan" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taLaporan WHERE (KODE_LAPORAN = @KODE_LAPORAN)" InsertCommand="INSERT INTO taLaporan(KODE_LAPORAN, NAMA_LAPORAN, NAMA_LAPORAN_en, KOLOM, KOLOM_GROUP,KOLOM_FILTER, FILE_LAPORAN, TIPE_LAPORAN, PERIODE_LAPORAN, LAP_ADMIN, LAP_OPERATOR, LAP_KEUANGAN, LAP_USER) VALUES (@KODE_LAPORAN, @NAMA_LAPORAN, @NAMA_LAPORAN_en, @KOLOM, @KOLOM_GROUP,@KOLOM_FILTER, @FILE_LAPORAN, @TIPE_LAPORAN, @PERIODE_LAPORAN, @LAP_ADMIN, @LAP_OPERATOR, @LAP_KEUANGAN, @LAP_USER)" UpdateCommand="UPDATE taLaporan SET NAMA_LAPORAN = @NAMA_LAPORAN, NAMA_LAPORAN_en = @NAMA_LAPORAN_en, KOLOM = @KOLOM, KOLOM_GROUP = @KOLOM_GROUP,KOLOM_FILTER = @KOLOM_FILTER, FILE_LAPORAN = @FILE_LAPORAN, TIPE_LAPORAN = @TIPE_LAPORAN,  PERIODE_LAPORAN = @PERIODE_LAPORAN, LAP_ADMIN = @LAP_ADMIN, LAP_OPERATOR = @LAP_OPERATOR, LAP_KEUANGAN = @LAP_KEUANGAN, LAP_USER = @LAP_USER  WHERE KODE_LAPORAN = @KODE_LAPORAN" OnDeleted="DsReport_Deleted" OnInserted="DsReport_Inserted" OnInserting="DsReport_Inserting" OnUpdated="DsReport_Updated">
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
    </asp:SqlDataSource> </TD></TR><TR></TR><TR><TD style="WIDTH: 100%; HEIGHT: 13px" align=left><INPUT id="File1" type=file name="File1" runat="server" /> <BR /><INPUT id="Submit1" type=submit value="Upload" runat="server" onserverclick="Submit1_ServerClick" /> </TD></TR><TR><TD style="WIDTH: 100%; HEIGHT: 13px" align=left><BR /><asp:Label id="ExceptionDetails2" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False" __designer:wfdid="w36"></asp:Label><BR /><BR /><asp:Label id="lblTitlePengesahan" runat="server" CssClass="lblTitle" SkinID="lblTitle" Font-Bold="True" Text="<%$ Resources:lblTitlePengesahan %>" forecolor="Black" __designer:wfdid="w154"></asp:Label><BR /><BR /><TABLE><TBODY><TR><TD style="WIDTH: 100px"><asp:Label id="lblFilterSatker" runat="server" Text="<%$ Resources:lblSatuanKerja %>" __designer:wfdid="w2"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="ddlFilterSatker" runat="server" OnSelectedIndexChanged="ddlFilterSatKer_ValueChange" AutoPostBack="True" DataSourceID="dsCabang" OnDataBound="ddlFilterSatKer_ValueChange" __designer:wfdid="w3" DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG"></asp:DropDownList> </TD></TR></TBODY></TABLE><BR /><asp:ImageButton id="imgBtnAddSignVal" onclick="imgBtnAddSignVal_Click" runat="server" AlternateText="<%$Resources:ImgAdd %>" ImageUrl="~/images/ipost.gif" __designer:wfdid="w6"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkBtnAddSignVal" onclick="lnkBtnAddSignVal_Click" runat="server" Text="<%$Resources:ImgAdd %>" __designer:wfdid="w7"></asp:LinkButton><BR /><BR /><asp:GridView id="gvLaporanPengesahan" runat="server" DataSourceID="dsLaporanPengesahan" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="KODE_LAPORAN,KODE_CABANG" OnDataBound="gvLaporanPengesahan_DataBound" OnRowCommand="gvLaporanPengesahan_RowCommand" OnRowDataBound="GvLaporan_RowDataBound" __designer:wfdid="w8" EmptyDataText="<%$ Resources:Resource, lblEmptyData %>" Width="1200px">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_LAPORAN" HeaderText="<%$ Resources:Column_0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Eval("KODE_LAPORAN") %>' __designer:wfdid="w88"></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol0Footer" runat="server" DataSourceID="DsReport" __designer:wfdid="w92" DataTextField="NAMA_LAPORAN" DataValueField="KODE_LAPORAN"></asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_LAPORAN") %>' __designer:wfdid="w39"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_CABANG" HeaderText="<%$ Resources:Column_1 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol1Edit" runat="server" DataSourceID="dsCabang2" __designer:wfdid="w89" DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG" SelectedValue='<%# Eval("KODE_CABANG") %>' Enabled="False"></asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol1Footer" runat="server" DataSourceID="dsCabang2" __designer:wfdid="w75" DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG"></asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA_CABANG") %>' __designer:wfdid="w40"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD1_HEADER" HeaderText="<%$ Resources:Column_2 %>"><EditItemTemplate>
<asp:TextBox id="txtCol2Edit" runat="server" Text='<%# Bind("TTD1_HEADER") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w4" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol2Footer" runat="server" width="140px" TextMode="MultiLine" __designer:wfdid="w5" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TTD1_HEADER") %>' __designer:wfdid="w3"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD1" HeaderText="<%$ Resources:Column_3 %>"><EditItemTemplate>
<asp:TextBox id="txtCol3Edit" runat="server" Text='<%# Bind("TTD1") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w6" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol3Footer" runat="server" width="140px" TextMode="MultiLine" __designer:wfdid="w7" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("TTD1") %>' __designer:wfdid="w46"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD2_HEADER" HeaderText="<%$ Resources:Column_4 %>"><EditItemTemplate>
<asp:TextBox id="txtCol4Edit" runat="server" Text='<%# Bind("TTD2_HEADER") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w8" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol4Footer" runat="server" width="140px" TextMode="MultiLine" __designer:wfdid="w9" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("TTD2_HEADER") %>' __designer:wfdid="w50"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD2" HeaderText="<%$ Resources:Column_5 %>"><EditItemTemplate>
<asp:TextBox id="txtCol5Edit" runat="server" Text='<%# Bind("TTD2") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w10" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol5Footer" runat="server" width="140px" TextMode="MultiLine" __designer:wfdid="w11" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("TTD2") %>' __designer:wfdid="w64"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD3_HEADER" HeaderText="<%$ Resources:Column_6 %>"><EditItemTemplate>
<asp:TextBox id="txtCol6Edit" runat="server" Text='<%# Bind("TTD3_HEADER") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w12" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol6Footer" runat="server" width="140px" TextMode="MultiLine" __designer:wfdid="w13" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("TTD3_HEADER") %>' __designer:wfdid="w67"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TTD3" HeaderText="<%$ Resources:Column_7 %>"><EditItemTemplate>
<asp:TextBox id="txtCol7Edit" runat="server" Text='<%# Bind("TTD3") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w14" MaxLength="20"></asp:TextBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol7Footer" runat="server" width="140px" TextMode="MultiLine" __designer:wfdid="w15" MaxLength="20"></asp:TextBox> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# Bind("TTD3") %>' __designer:wfdid="w70"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column_8 %>"><EditItemTemplate>
<asp:ImageButton id="btnUpdate" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w23" CommandName="Update" ToolTip="<%$ Resources:ImgUpdate %>"></asp:ImageButton>&nbsp;<asp:ImageButton id="ImageButton3" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w24" CommandName="Cancel" ToolTip="<%$ Resources:ImgDel%>"></asp:ImageButton>
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="btnInsert" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w25" CommandName="Insert" ToolTip="<%$ Resources:ImgInsert %>"></asp:ImageButton>&nbsp;<asp:ImageButton id="btncancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w26" CommandName="Cancel_Insert" ToolTip="<%$ Resources:ImgCancel %>"></asp:ImageButton>
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="ImageButton1" runat="server" ImageUrl="~/images/iedit.gif" __designer:wfdid="w16" ToolTip="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column_9 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" __designer:wfdid="w7" CommandName="Delete" ToolTip="Delete"></asp:ImageButton><cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w8" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w9" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnFirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First" __designer:wfdid="w19"></asp:ImageButton> <asp:ImageButton id="btnPrev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev" __designer:wfdid="w20"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w21"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged1" __designer:wfdid="w22"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w23"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w24"></asp:Label>&nbsp;<asp:ImageButton id="btnNext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next" __designer:wfdid="w25"></asp:ImageButton>&nbsp;<asp:ImageButton id="btnLast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last" __designer:wfdid="w26"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView><asp:SqlDataSource id="dsLaporanPengesahan" runat="server" SelectCommand="SELECT taLaporanPengesahan.KODE_LAPORAN, taLaporanPengesahan.KODE_CABANG, taLaporanPengesahan.TTD1_HEADER, taLaporanPengesahan.TTD1, taLaporanPengesahan.TTD2_HEADER, taLaporanPengesahan.TTD2, taLaporanPengesahan.TTD3_HEADER, taLaporanPengesahan.TTD3, taCabang.NAMA_CABANG FROM taLaporanPengesahan INNER JOIN taCabang ON taLaporanPengesahan.KODE_CABANG = taCabang.KODE_CABANG" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taLaporanPengesahan WHERE (KODE_LAPORAN = @KODE_LAPORAN) AND (KODE_CABANG = @KODE_CABANG)" InsertCommand="INSERT INTO taLaporanPengesahan(KODE_LAPORAN, KODE_CABANG, TTD1_HEADER, TTD1, TTD2_HEADER, TTD2, TTD3_HEADER, TTD3) VALUES (@KODE_LAPORAN, @KODE_CABANG, @TTD1_HEADER, @TTD1, @TTD2_HEADER, @TTD2, @TTD3_HEADER, @TTD3)" UpdateCommand="UPDATE taLaporanPengesahan SET TTD1_HEADER = @TTD1_HEADER, TTD1 = @TTD1, TTD2_HEADER = @TTD2_HEADER, TTD2 = @TTD2, TTD3_HEADER = @TTD3_HEADER, TTD3 = @TTD3 WHERE (KODE_LAPORAN = @KODE_LAPORAN) AND (KODE_CABANG = @KODE_CABANG)" OnDeleted="dsLaporanPengesahan_Deleted" OnInserted="dsLaporanPengesahan_Inserted" OnInserting="dsLaporanPengesahan_Inserting" OnUpdated="dsLaporanPengesahan_Updated" __designer:wfdid="w9"><DeleteParameters>
<asp:Parameter Name="KODE_LAPORAN"></asp:Parameter>
<asp:Parameter Name="KODE_CABANG"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="TTD1_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD1"></asp:Parameter>
<asp:Parameter Name="TTD2_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD2"></asp:Parameter>
<asp:Parameter Name="TTD3_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD3"></asp:Parameter>
<asp:Parameter Name="KODE_LAPORAN"></asp:Parameter>
<asp:Parameter Name="KODE_CABANG"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_LAPORAN"></asp:Parameter>
<asp:Parameter Name="KODE_CABANG"></asp:Parameter>
<asp:Parameter Name="TTD1_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD1"></asp:Parameter>
<asp:Parameter Name="TTD2_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD2"></asp:Parameter>
<asp:Parameter Name="TTD3_HEADER"></asp:Parameter>
<asp:Parameter Name="TTD3"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> <asp:FormView id="FvLaporanPengesahan" runat="server" DataSourceID="dsLaporanPengesahan" DataKeyNames="KODE_LAPORAN,KODE_CABANG" __designer:wfdid="w76" EmptyDataText="<%$ Resources:Resource, lblEmptyData %>" OnItemCommand="FvLaporanPengesahan_ItemCommand"><InsertItemTemplate>
<TABLE style="WIDTH: 1200px; BORDER-COLLAPSE: collapse" cellSpacing=0 cellPadding=2 border=1><TBODY><TR><TD style="WIDTH: 100px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column_0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w17"></asp:Label></TD><TD style="WIDTH: 100px" class="HeaderStyle" align=center><asp:Label id="Label8" runat="server" Text="<%$ Resources:Column_1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w18"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label10" runat="server" Text="<%$ Resources:Column_2 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w19"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label11" runat="server" Text="<%$ Resources:Column_3 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w20"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label14" runat="server" Text="<%$ Resources:Column_4 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w21"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label15" runat="server" Text="<%$ Resources:Column_5 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w22"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label16" runat="server" Text="<%$ Resources:Column_6 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w23"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label17" runat="server" Text="<%$ Resources:Column_7 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w24"></asp:Label></TD><TD style="WIDTH: 100px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle">&nbsp;<asp:DropDownList id="ddlCol0FormView" runat="server" DataSourceID="DsReport" __designer:wfdid="w25" DataValueField="KODE_LAPORAN" DataTextField="NAMA_LAPORAN" SelectedValue='<%# Bind("KODE_LAPORAN") %>'></asp:DropDownList></TD><TD class="FooterStyle">&nbsp;<asp:DropDownList id="ddlCol1FormView" runat="server" DataSourceID="dsCabang2" __designer:wfdid="w134" DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG" SelectedValue='<%# Bind("KODE_CABANG") %>'></asp:DropDownList></TD><TD class="FooterStyle"><asp:TextBox id="txtCol2FormView" runat="server" Text='<%# Bind("TTD1_HEADER") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w27" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol3Edit" runat="server" Text='<%# Bind("TTD1") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w28" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol4Edit" runat="server" Text='<%# Bind("TTD2_HEADER") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w29" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol5Edit" runat="server" Text='<%# Bind("TTD2") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w30" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol6Edit" runat="server" Text='<%# Bind("TTD3_HEADER") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w31" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol7Edit" runat="server" Text='<%# Bind("TTD3") %>' width="140px" TextMode="MultiLine" __designer:wfdid="w32" MaxLength="20"></asp:TextBox></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" __designer:wfdid="w33" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" __designer:wfdid="w34" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> </TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False" Visible="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server" __designer:wfdid="w95"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tbody><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..." __designer:wfdid="w96"></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></tbody></table></asp:Panel> 
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
        SelectCommand="SELECT [KODE_CABANG], [NAMA_CABANG] FROM [taCabang] ORDER BY [KODE_CABANG]">
    </asp:SqlDataSource><asp:SqlDataSource ID="dsCabang2" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_CABANG, NAMA_CABANG FROM taCabang WHERE (KODE_CABANG <> '---') ORDER BY KODE_CABANG">
    </asp:SqlDataSource>
            <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
        Visible="False" width="651px"></asp:Label><asp:Label ID="lblFieldCannotEmpty" runat="server"
            Text="<%$ Resources:Resource, lblFieldCannotEmpty %>" Visible="False" width="566px"></asp:Label><asp:Label
                ID="lblNotSaved" runat="server" Text="<%$ Resources:Resource, lblNotSaved %>"
                Visible="False" width="1013px"></asp:Label><asp:Label ID="lblConfirmDelete" runat="server"
                    Text="<%$ Resources:Resource, lblConfirmDelete %>" Visible="False" width="387px"></asp:Label>
</asp:Content>


