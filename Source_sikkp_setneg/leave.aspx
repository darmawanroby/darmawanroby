<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="leave.aspx.cs" Inherits="rtwin.leave" title="Sistem Kehadiran Kerja Pegawai" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <table border="0" cellpadding="0" cellspacing="0" class="border_table" width="100%">
        <tr>
            <td rowspan="2" style="width: 100%;">
                <asp:ScriptManager id="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><BR /><asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgTambah" onclick="btnAdd_Click" runat="server" ImageUrl="~/images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp;<asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="GvIjin" runat="server" DataSourceID="dsijin" OnRowEditing="GvIjin_RowEditing" OnRowDataBound="grdijin_RowDataBound" OnRowCommand="grdijin_RowCommand" OnDataBound="grdijin_DataBound" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="KODE_IJIN">
<FooterStyle VerticalAlign="Top"></FooterStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_IJIN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Eval("KODE_IJIN") %>' __designer:wfdid="w67"></asp:Label>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" __designer:wfdid="w116" Columns="3" MaxLength="3"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" __designer:wfdid="w117" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<HeaderStyle Width="75px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Eval("KODE_IJIN") %>' __designer:wfdid="w1"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_IJIN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("KET_IJIN") %>' __designer:wfdid="w70" Columns="25" MaxLength="25"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" EnableClientScript="True" __designer:wfdid="w71">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" __designer:wfdid="w121" Columns="25" MaxLength="25"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" __designer:wfdid="w122" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("KET_IJIN") %>' __designer:wfdid="w118"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_PERHITUNGAN" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol2Edit" runat="server" __designer:wfdid="w47" SelectedValue='<%# Bind("PERHITUNGAN") %>'><asp:ListItem Value="1">Hari Kalendar</asp:ListItem>
<asp:ListItem Value="2">Hari Kerja</asp:ListItem>
<asp:ListItem Value="3">Paruh Hari</asp:ListItem>
</asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol2Footer" runat="server" __designer:wfdid="w4"><asp:ListItem Selected="True" Value="1">Hari Kalendar</asp:ListItem>
<asp:ListItem Value="2">Hari Kerja</asp:ListItem>
<asp:ListItem Value="3">Paruh Hari</asp:ListItem>
</asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("NAMA_PERHITUNGAN") %>' __designer:wfdid="w123"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_KETENTUAN" HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol3Edit" runat="server" __designer:wfdid="w48" SelectedValue='<%# Bind("KETENTUAN") %>'><asp:ListItem Value="0">-</asp:ListItem>
<asp:ListItem Value="1">Setiap Tahun</asp:ListItem>
<asp:ListItem Value="2">Setelah 6 Tahun</asp:ListItem>
<asp:ListItem Value="3">Setelah 7 Tahun</asp:ListItem>
<asp:ListItem Value="4">1 X Seumur Hidup</asp:ListItem>
<asp:ListItem Value="5">Kebijaksanaan</asp:ListItem>
</asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol3Footer" runat="server" __designer:wfdid="w129"><asp:ListItem Selected="True" Value="0">-</asp:ListItem>
<asp:ListItem Value="1">Setiap Tahun</asp:ListItem>
<asp:ListItem Value="2">Setelah 6 Tahun</asp:ListItem>
<asp:ListItem Value="3">Setelah 7 Tahun</asp:ListItem>
<asp:ListItem Value="4">1 X Seumur Hidup</asp:ListItem>
<asp:ListItem Value="5">Kebijaksanaan</asp:ListItem>
</asp:DropDownList>
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("NAMA_KETENTUAN") %>' __designer:wfdid="w126"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JATAH_IJIN" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
<asp:TextBox id="txtCol4Edit" runat="server" Text='<%# Bind("JATAH_IJIN") %>' __designer:wfdid="w349" MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valCol4Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol4Edit" EnableClientScript="True" __designer:wfdid="w350" SetFocusOnError="True" MinimumValue="0" MaximumValue="100" Type="Integer">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol4Edit" runat="server" __designer:wfdid="w425" AutoComplete="False" Mask="999" MaskType="Number" TargetControlID="txtCol4Edit"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol4Footer" runat="server" __designer:wfdid="w351" MaxLength="3" Columns="3"></asp:TextBox> <asp:RangeValidator id="valCol4Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol4Footer" EnableClientScript="True" __designer:wfdid="w352" SetFocusOnError="True" MinimumValue="0" MaximumValue="100" Type="Integer">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol4Footer" runat="server" __designer:wfdid="w426" AutoComplete="False" Mask="999" MaskType="Number" TargetControlID="txtCol4Footer"></cc1:MaskedEditExtender>
</FooterTemplate>

<HeaderStyle Width="75px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("JATAH_IJIN") %>' __designer:wfdid="w348"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KREDIT" HeaderText="<%$ Resources:Column5 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol5Edit" runat="server" OnSelectedIndexChanged="ddlCol5EditFooter_SelectedIndexChanged" AutoPostBack="True" __designer:wfdid="w313" SelectedValue='<%# Bind("KREDIT") %>'><asp:ListItem Value="0">Manual</asp:ListItem>
<asp:ListItem Value="1">Otomatis</asp:ListItem>
</asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol5Footer" runat="server" OnSelectedIndexChanged="ddlCol5EditFooter_SelectedIndexChanged" AutoPostBack="True" __designer:wfdid="w314"><asp:ListItem Selected="True" Value="0">Manual</asp:ListItem>
<asp:ListItem Value="1">Otomatis</asp:ListItem>
</asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("NAMA_KREDIT") %>' __designer:wfdid="w312"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="BERLAKU" HeaderText="<%$ Resources:Column6 %>"><EditItemTemplate>
<asp:TextBox id="txtCol6Edit" runat="server" Text='<%# Bind("BERLAKU") %>' __designer:wfdid="w3" Columns="3" MaxLength="3"></asp:TextBox> <asp:RangeValidator id="valCol6Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol6Edit" EnableClientScript="True" __designer:wfdid="w4" Type="Integer" MaximumValue="365" MinimumValue="0" SetFocusOnError="True">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol6Edit" runat="server" __designer:wfdid="w5" TargetControlID="txtCol6Edit" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol6Footer" runat="server" __designer:wfdid="w6" Columns="3" MaxLength="3" Enabled="False"></asp:TextBox> <asp:RangeValidator id="valCol6Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol6Footer" EnableClientScript="True" __designer:wfdid="w7" Type="Integer" MaximumValue="365" MinimumValue="0" SetFocusOnError="True">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol6Footer" runat="server" __designer:wfdid="w8" TargetControlID="txtCol6Footer" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender> 
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("BERLAKU") %>' __designer:wfdid="w2"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="DASAR" HeaderText="<%$ Resources:Column7 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol7Edit" runat="server" __designer:wfdid="w54" SelectedValue='<%# Bind("DASAR") %>'><asp:ListItem Selected="True" Value="0">Tgl Masuk Kerja</asp:ListItem>
<asp:ListItem Value="1">Awal Tahun</asp:ListItem>
</asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol7Footer" runat="server" __designer:wfdid="w234" Enabled="False"><asp:ListItem Value="0">Tgl Masuk Kerja</asp:ListItem>
<asp:ListItem Value="1">Awal Tahun</asp:ListItem>
</asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# Bind("NAMA_DASAR") %>' __designer:wfdid="w232"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="PROSES_DI_AWAL" HeaderText="<%$ Resources:Column8 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol8Edit" runat="server" __designer:wfdid="w55" SelectedValue='<%# Bind("PROSES_DI_AWAL") %>'><asp:ListItem Value="1">Ya</asp:ListItem>
<asp:ListItem Value="2">Tidak</asp:ListItem>
</asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol8Footer" runat="server" __designer:wfdid="w231" Enabled="False"><asp:ListItem Value="1">Ya</asp:ListItem>
<asp:ListItem Value="2">Tidak</asp:ListItem>
</asp:DropDownList> 
</FooterTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol8Item" runat="server" Text='<%# Bind("NAMA_PROSES_DI_AWAL") %>' __designer:wfdid="w229"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_TIDAK_HADIR" HeaderText="<%$ Resources:Column9 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol9Edit" runat="server" __designer:wfdid="w56" SelectedValue='<%# Bind("KODE_TIDAK_HADIR") %>'><asp:ListItem Value="0">Tanpa Keterangan</asp:ListItem>
<asp:ListItem Value="1">Ijin/Cuti/Dinas/Sakit</asp:ListItem>
<asp:ListItem Value="2">Terlambat</asp:ListItem>
<asp:ListItem Value="3">Cepat Pulang</asp:ListItem>
<asp:ListItem Value="4">Lambat &amp; Cepat Pulang</asp:ListItem>
<asp:ListItem Value="5">Paruh Hari</asp:ListItem>
<asp:ListItem Value="6">Alpha/Mangkir</asp:ListItem>
</asp:DropDownList> 
</EditItemTemplate>
<FooterTemplate>
<asp:DropDownList id="ddlCol9Footer" runat="server" __designer:wfdid="w448"><asp:ListItem Selected="True" Value="0">Tanpa Keterangan</asp:ListItem>
<asp:ListItem Value="1">Ijin/Cuti/Dinas/Sakit</asp:ListItem>
<asp:ListItem Value="2">Terlambat</asp:ListItem>
<asp:ListItem Value="3">Cepat Pulang</asp:ListItem>
<asp:ListItem Value="4">Lambat &amp; Cepat Pulang</asp:ListItem>
<asp:ListItem Value="5">Paruh Hari</asp:ListItem>
<asp:ListItem Value="6">Alpha/Mangkir</asp:ListItem>
</asp:DropDownList>
</FooterTemplate>

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol9Item" runat="server" Text='<%# Bind("NAMA_KODE_TIDAK_HADIR") %>' __designer:wfdid="w186"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="HITUNG_HARI_KERJA" HeaderText="<%$ Resources:Column10 %>"><EditItemTemplate>
<asp:CheckBox id="chkCol10Edit" runat="server" __designer:wfdid="w57" Checked='<%# Bind("HITUNG_HARI_KERJA") %>'></asp:CheckBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:CheckBox id="chkCol10Footer" runat="server" __designer:wfdid="w191"></asp:CheckBox> 
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:CheckBox id="chkCol10Item" runat="server" __designer:wfdid="w189" Checked='<%# Bind("HITUNG_HARI_KERJA") %>' Enabled="False"></asp:CheckBox> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="HITUNG_JAM_KERJA" HeaderText="<%$ Resources:Column11 %>"><EditItemTemplate>
<asp:CheckBox id="chkCol11Edit" runat="server" __designer:wfdid="w58" Checked='<%# Bind("HITUNG_JAM_KERJA") %>'></asp:CheckBox> 
</EditItemTemplate>
<FooterTemplate>
<asp:CheckBox id="chkCol11Footer" runat="server" __designer:wfdid="w194"></asp:CheckBox> 
</FooterTemplate>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:CheckBox id="chkCol11Item" runat="server" __designer:wfdid="w192" Checked='<%# Bind("HITUNG_JAM_KERJA") %>' Enabled="False"></asp:CheckBox> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="POTONGAN_TKK" HeaderText="<%$ Resources:Column12 %>"><EditItemTemplate>
<asp:TextBox id="txtCol12Edit" runat="server" Text='<%# Bind("POTONGAN_TKK") %>' __designer:wfdid="w10" Columns="3" MaxLength="3"></asp:TextBox> <asp:RangeValidator id="valCol12Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol12Edit" EnableClientScript="True" __designer:wfdid="w11" Type="Integer" MaximumValue="100" MinimumValue="0" SetFocusOnError="True">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol12Edit" runat="server" __designer:wfdid="w14" TargetControlID="txtCol12Edit" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol12Footer" runat="server" __designer:wfdid="w12" Columns="3" MaxLength="3"></asp:TextBox> <asp:RangeValidator id="valCol12Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol12Footer" EnableClientScript="True" __designer:wfdid="w13" Type="Integer" MaximumValue="100" MinimumValue="0" SetFocusOnError="True">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol12Footer" runat="server" __designer:wfdid="w15" TargetControlID="txtCol12Footer" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender>
</FooterTemplate>

<HeaderStyle Width="75px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol12Item" runat="server" Text='<%# Bind("POTONGAN_TKK") %>' __designer:wfdid="w9"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column13 %>"><EditItemTemplate>
&nbsp;<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w62" CommandName="Update" ToolTip="<%$ Resources:ImgUpdate %>"></asp:ImageButton> <asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w63" CommandName="Cancel" ToolTip="<%$ Resources:ImgCancel%>"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:ImageButton ID="imgInsert" runat="server" CommandName="Insert" ImageUrl="~/images/edit.gif" ToolTip="<%$ Resources:ImgInsert %>" />
                    <asp:ImageButton ID="imgCancelInsert" runat="server" ImageUrl="~/images/delete.gif" ToolTip="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Insert" />
                
</FooterTemplate>

<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit" ImageUrl="~/images/iedit.gif" ToolTip="<%$ Resources:ImgEdit %>" />
                                
</ItemTemplate>

<FooterStyle Width="50px"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column14 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" ToolTip="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
            <asp:ImageButton ID="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif"
                CommandArgument="First" CommandName="Page" />
            &nbsp;<asp:ImageButton ID="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif"
                CommandArgument="Prev" CommandName="Page" />
            <asp:Label ID="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label>
            <asp:TextBox ID="txtHalaman" runat="server" AutoPostBack="True" Columns="3" MaxLength="3"
                OnTextChanged="txtHalaman_TextChanged"></asp:TextBox>
            <asp:Label ID="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label>
            <asp:Label ID="lblJumlahHalaman" runat="server" Text="Label"></asp:Label>
            &nbsp;<asp:ImageButton ID="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif"
                CommandArgument="Next" CommandName="Page" />
            <asp:ImageButton ID="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandArgument="Last" CommandName="Page" />
        
</PagerTemplate>

<EditRowStyle VerticalAlign="Top"></EditRowStyle>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsijin" runat="server" OnUpdated="dsijin_Updated" OnInserting="dsijin_Inserting" OnInserted="dsijin_Inserted" OnDeleted="dsijin_Deleted" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taIjin WHERE (KODE_IJIN = @KODE_IJIN)" InsertCommand="INSERT INTO taIjin(KODE_IJIN, KET_IJIN, PERHITUNGAN, KETENTUAN, JATAH_IJIN, KREDIT, BERLAKU, DASAR, PROSES_DI_AWAL, KODE_TIDAK_HADIR, HITUNG_HARI_KERJA, HITUNG_JAM_KERJA, POTONGAN_TKK) VALUES (@KODE_IJIN, @KET_IJIN, @PERHITUNGAN, @KETENTUAN, @JATAH_IJIN, @KREDIT, @BERLAKU, @DASAR, @PROSES_DI_AWAL, @KODE_TIDAK_HADIR, @HITUNG_HARI_KERJA, @HITUNG_JAM_KERJA, @POTONGAN_TKK)" SelectCommand="SELECT KODE_IJIN, KET_IJIN, PERHITUNGAN, KETENTUAN, JATAH_IJIN, KREDIT, BERLAKU, DASAR, PROSES_DI_AWAL, KODE_TIDAK_HADIR, HITUNG_HARI_KERJA, HITUNG_JAM_KERJA, POTONGAN_TKK, CASE WHEN PERHITUNGAN = '1' THEN 'Hari Kalender' ELSE (CASE WHEN PERHITUNGAN = '2' THEN 'Hari kerja' ELSE 'Paruh Hari' END) END AS NAMA_PERHITUNGAN, CASE WHEN KETENTUAN = '0' THEN '-' ELSE (CASE WHEN KETENTUAN = '1' THEN 'Setiap Tahun' ELSE (CASE WHEN KETENTUAN = '2' THEN 'Setelah 6 tahun' ELSE (CASE WHEN KETENTUAN = '3' THEN 'Setelah 7 tahun' ELSE (CASE WHEN KETENTUAN = '4' THEN '1 X Seumur hidup' ELSE 'Kebijaksanaan' END) END) END) END) END AS NAMA_KETENTUAN, CASE WHEN Kredit = '0' THEN 'Manual' ELSE 'Otomatis' END AS NAMA_KREDIT, CASE WHEN Dasar = '0' THEN 'Tgl Masuk Kerja' ELSE 'Awal Tahun' END AS NAMA_DASAR, CASE WHEN PROSES_DI_AWAL = '1' THEN 'Ya' ELSE 'Tidak' END AS NAMA_PROSES_DI_AWAL, CASE WHEN KODE_TIDAK_HADIR = '0' THEN 'Tanpa Keterangan' ELSE (CASE WHEN KODE_TIDAK_HADIR = '1' THEN 'Ijin/Cuti/Dinas/Sakit' ELSE (CASE WHEN KODE_TIDAK_HADIR = '2' THEN 'Terlambat' ELSE (CASE WHEN KODE_TIDAK_HADIR = '3' THEN 'Cepat Pulang' ELSE (CASE WHEN KODE_TIDAK_HADIR = '4' THEN 'Lambat & Cepat Pulang' ELSE (CASE WHEN KODE_TIDAK_HADIR = '5' THEN 'Paruh Hari' ELSE 'Alpha/Mangkir' END) END) END) END) END) END AS NAMA_KODE_TIDAK_HADIR FROM taIjin" UpdateCommand="UPDATE taIjin SET KET_IJIN = @KET_IJIN, PERHITUNGAN = @PERHITUNGAN, KETENTUAN = @KETENTUAN, JATAH_IJIN = @JATAH_IJIN, KREDIT = @KREDIT, BERLAKU = @BERLAKU, DASAR = @DASAR, PROSES_DI_AWAL = @PROSES_DI_AWAL, KODE_TIDAK_HADIR = @KODE_TIDAK_HADIR, HITUNG_HARI_KERJA = @HITUNG_HARI_KERJA, HITUNG_JAM_KERJA = @HITUNG_JAM_KERJA, POTONGAN_TKK = @POTONGAN_TKK WHERE (KODE_IJIN = @KODE_IJIN)"><DeleteParameters>
<asp:Parameter Name="KODE_IJIN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter DefaultValue="" Name="KODE_IJIN"></asp:Parameter>
<asp:Parameter Name="KET_IJIN"></asp:Parameter>
<asp:Parameter Name="PERHITUNGAN"></asp:Parameter>
<asp:Parameter Name="KETENTUAN"></asp:Parameter>
<asp:Parameter Type="Int32" DefaultValue="" Name="JATAH_IJIN"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="" Name="KREDIT"></asp:Parameter>
<asp:Parameter Type="Int32" DefaultValue="" Name="BERLAKU"></asp:Parameter>
<asp:Parameter Type="String" DefaultValue="" Name="DASAR"></asp:Parameter>
<asp:Parameter Name="PROSES_DI_AWAL"></asp:Parameter>
<asp:Parameter Name="KODE_TIDAK_HADIR"></asp:Parameter>
<asp:Parameter Name="HITUNG_HARI_KERJA"></asp:Parameter>
<asp:Parameter Name="HITUNG_JAM_KERJA"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="POTONGAN_TKK"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_IJIN"></asp:Parameter>
<asp:Parameter Name="KET_IJIN"></asp:Parameter>
<asp:Parameter Name="PERHITUNGAN"></asp:Parameter>
<asp:Parameter Name="KETENTUAN"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="JATAH_IJIN"></asp:Parameter>
<asp:Parameter Name="PROSES_DI_AWAL"></asp:Parameter>
<asp:Parameter Name="KODE_TIDAK_HADIR"></asp:Parameter>
<asp:Parameter Name="HITUNG_HARI_KERJA"></asp:Parameter>
<asp:Parameter Name="HITUNG_JAM_KERJA"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="POTONGAN_TKK"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="KREDIT"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="BERLAKU"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="DASAR"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> <asp:FormView id="FvIjin" runat="server" DataSourceID="dsijin" DataKeyNames="KODE_IJIN" EmptyDataText="<%$ Resources:lblEmptyData %>" OnItemCommand="FvIjin_ItemCommand"><InsertItemTemplate>
<TABLE cellSpacing=0 cellPadding=2 width=1325 border=1><TBODY><TR><TD style="WIDTH: 75px" class="HeaderStyle" align=center><asp:Label id="Label1" runat="server" Text="<%$ Resources:Column0 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w315"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w316"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column2 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w317"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label4" runat="server" Text="<%$ Resources:Column3 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w318"></asp:Label></TD><TD style="WIDTH: 75px" class="HeaderStyle" align=center><asp:Label id="Label5" runat="server" Text="<%$ Resources:Column4 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w319"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label6" runat="server" Text="<%$ Resources:Column5 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w320"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label7" runat="server" Text="<%$ Resources:Column6 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w321"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label8" runat="server" Text="<%$ Resources:Column7 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w322"></asp:Label></TD><TD style="WIDTH: 100px" class="HeaderStyle" align=center><asp:Label id="Label9" runat="server" Text="<%$ Resources:Column8 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w323"></asp:Label></TD><TD style="WIDTH: 150px" class="HeaderStyle" align=center><asp:Label id="Label10" runat="server" Text="<%$ Resources:Column9 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w324"></asp:Label></TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label11" runat="server" Text="<%$ Resources:Column10 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w325"></asp:Label> </TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center><asp:Label id="Label12" runat="server" Text="<%$ Resources:Column11 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w326"></asp:Label> </TD><TD style="WIDTH: 75px" class="HeaderStyle" align=center><asp:Label id="Label13" runat="server" Text="<%$ Resources:Column12 %>" forecolor="Yellow" Font-Size="XX-Small" __designer:wfdid="w327"></asp:Label> </TD><TD style="WIDTH: 50px" class="HeaderStyle" align=center></TD></TR><TR><TD class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("KODE_IJIN") %>' __designer:wfdid="w328" MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" EnableClientScript="True" __designer:wfdid="w329" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("KET_IJIN") %>' __designer:wfdid="w330" MaxLength="25" Columns="25"></asp:TextBox><asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" EnableClientScript="True" __designer:wfdid="w331">*</asp:RequiredFieldValidator></TD><TD class="FooterStyle"><asp:DropDownList id="ddlCol2FormView" runat="server" __designer:wfdid="w332" SelectedValue='<%# Bind("PERHITUNGAN") %>'><asp:ListItem Selected="True" Value="1">Hari Kalendar</asp:ListItem>
<asp:ListItem Value="2">Hari Kerja</asp:ListItem>
<asp:ListItem Value="3">Paruh Hari</asp:ListItem>
</asp:DropDownList></TD><TD class="FooterStyle"><asp:DropDownList id="ddlCol3FormView" runat="server" __designer:wfdid="w333" SelectedValue='<%# Bind("KETENTUAN") %>'><asp:ListItem Value="0">-</asp:ListItem>
<asp:ListItem Value="1">Setiap Tahun</asp:ListItem>
<asp:ListItem Value="2">Setelah 6 Tahun</asp:ListItem>
<asp:ListItem Value="3">Setelah 7 Tahun</asp:ListItem>
<asp:ListItem Value="4">1 X Seumur Hidup</asp:ListItem>
<asp:ListItem Value="5">Kebijaksanaan</asp:ListItem>
</asp:DropDownList></TD><TD class="FooterStyle"><asp:TextBox id="txtCol4FormView" runat="server" Text='<%# Bind("JATAH_IJIN") %>' __designer:wfdid="w334" MaxLength="3" Columns="3"></asp:TextBox><asp:RangeValidator id="valCol4FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol4FormView" EnableClientScript="True" __designer:wfdid="w335" SetFocusOnError="True" MinimumValue="0" MaximumValue="100" Type="Integer">*</asp:RangeValidator></TD><TD class="FooterStyle"><asp:DropDownList id="ddlCol5FormView" runat="server" OnSelectedIndexChanged="ddlCol5FormView_SelectedIndexChanged" AutoPostBack="True" __designer:wfdid="w336" SelectedValue='<%# Bind("KREDIT") %>'><asp:ListItem Value="0">Manual</asp:ListItem>
<asp:ListItem Value="1">Otomatis</asp:ListItem>
</asp:DropDownList></TD><TD class="FooterStyle"><asp:TextBox id="txtCol6FormView" runat="server" Text='<%# Bind("BERLAKU") %>' __designer:wfdid="w337" MaxLength="3" Columns="3" Enabled="False"></asp:TextBox> <asp:RangeValidator id="valCol6FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol6FormView" EnableClientScript="True" __designer:wfdid="w338" SetFocusOnError="True" MinimumValue="0" MaximumValue="365" Type="Integer">*</asp:RangeValidator></TD><TD class="FooterStyle"><asp:DropDownList id="ddlCol7FormView" runat="server" __designer:wfdid="w339" SelectedValue='<%# Bind("DASAR") %>' Enabled="False"><asp:ListItem Value="0">Tgl Masuk Kerja</asp:ListItem>
<asp:ListItem Value="1">Awal Tahun</asp:ListItem>
</asp:DropDownList></TD><TD class="FooterStyle"><asp:DropDownList id="ddlCol8FormView" runat="server" __designer:wfdid="w340" SelectedValue='<%# Bind("PROSES_DI_AWAL") %>' Enabled="False"><asp:ListItem Value="1">Ya</asp:ListItem>
<asp:ListItem Value="2">Tidak</asp:ListItem>
</asp:DropDownList></TD><TD class="FooterStyle"><asp:DropDownList id="ddlCol9FormView" runat="server" __designer:wfdid="w341" SelectedValue='<%# Bind("KODE_TIDAK_HADIR") %>'><asp:ListItem Selected="True" Value="0">Tanpa Keterangan</asp:ListItem>
<asp:ListItem Value="1">Ijin/Cuti/Dinas/Sakit</asp:ListItem>
<asp:ListItem Value="2">Terlambat</asp:ListItem>
<asp:ListItem Value="3">Cepat Pulang</asp:ListItem>
<asp:ListItem Value="4">Lambat &amp; Cepat Pulang</asp:ListItem>
<asp:ListItem Value="5">Paruh Hari</asp:ListItem>
<asp:ListItem Value="6">Alpha/Mangkir</asp:ListItem>
</asp:DropDownList></TD><TD class="FooterStyle"><asp:CheckBox id="chkCol10FormView" runat="server" __designer:wfdid="w342" Checked='<%# Bind("HITUNG_HARI_KERJA") %>'></asp:CheckBox></TD><TD class="FooterStyle"><asp:CheckBox id="chkCol11FormView" runat="server" __designer:wfdid="w343" Checked='<%# Bind("HITUNG_JAM_KERJA") %>'></asp:CheckBox></TD><TD class="FooterStyle"><asp:TextBox id="txtCol12FormView" runat="server" Text='<%# Bind("POTONGAN_TKK") %>' __designer:wfdid="w344" MaxLength="3" Columns="3"></asp:TextBox><asp:RangeValidator id="valCol12FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol12FormView" EnableClientScript="True" __designer:wfdid="w345" SetFocusOnError="True" MinimumValue="0" MaximumValue="100" Type="Integer">*</asp:RangeValidator></TD><TD class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" __designer:wfdid="w346" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" __designer:wfdid="w347" CommandName="Cancel"></asp:ImageButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> 
</contenttemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="100" DynamicLayout="False">
                    <progresstemplate>
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
            <td>
                &nbsp; &nbsp;
            </td>
        </tr>
    </table>
            <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
        Visible="False"></asp:Label><asp:Label
                ID="lblNotSaved" runat="server" Text="<%$ Resources:Resource, lblNotSaved %>"
                Visible="False"></asp:Label>
    
</asp:Content>

