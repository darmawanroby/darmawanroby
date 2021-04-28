<%@ Page MasterPageFile ="~/MasterPage.master" Language="C#" AutoEventWireup="true" Inherits="rtwin.config" CodeFile="config.aspx.cs" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    
<asp:Content ID="Content2" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                        <td class="backgroundTitle" style="width: 200px">
                            <img style="vertical-align: middle" height="27" src="images/back_title.gif" alt="" />&nbsp;
                            <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                        </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR />
            <asp:Button ID="btnUpdateFlexi" runat="server" OnClick="btnUpdateFlexi_Click" Text="Update Flexi" /><br />
            <BR /><asp:FormView id="FvVariable" runat="server" DataSourceID="dsVariable" DefaultMode="Edit"><EditItemTemplate>
<TABLE width=600><TBODY><TR><TD style="WIDTH: 200px"><asp:Label id="lblTglLaporan" runat="server" Text="<%$ Resources:lblTglLaporan %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtTglLaporan" runat="server" Text='<%# Bind("TGL_LAPORAN") %>' MaxLength="2" Columns="2" Enabled="False"></asp:TextBox> <asp:RangeValidator id="RangeValidator1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtTglLaporan" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="1" MaximumValue="31">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexTglLaporan" runat="server" TargetControlID="txtTglLaporan" MaskType="Number" Mask="99" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label1" runat="server" Visible="False" Text="<%$ Resources:lblTutupPeriode %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item1" runat="server" Visible="False" Text='<%# Bind("TUTUP_PERIODE", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol1Item1" runat="server" Visible="False" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RegularExpressionValidator id="valCol1_1Item1" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtCol1Item1" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator><cc1:CalendarExtender id="cexCol1Item1" runat="server" CssClass="cal_Theme1" PopupButtonID="imgCol1Item1" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>" targetcontrolid="txtCol1Item1"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexCol1Item1" runat="server" TargetControlID="txtCol1Item1" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label2" runat="server" Visible="False" Text="<%$ Resources:lblLimitAwal %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item2" runat="server" Visible="False" Text='<%# Bind("DEF_LIMIT_AWAL", "{0:HH:mm}") %>' MaxLength="5" Columns="5"></asp:TextBox> <asp:RegularExpressionValidator id="valtxtCol1Item2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtCol1Item2" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexCol1Item2" runat="server" TargetControlID="txtCol1Item2" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label3" runat="server" Visible="False" Text="<%$ Resources:lblLimitAkhir %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item3" runat="server" Visible="False" Text='<%# Bind("DEF_LIMIT_AKHIR", "{0:HH:mm}") %>' MaxLength="5" Columns="5"></asp:TextBox> <asp:RegularExpressionValidator id="valtxtCol1Item3" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtCol1Item3" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexCol1Item3" runat="server" TargetControlID="txtCol1Item3" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label4" runat="server" Visible="False" Text="<%$ Resources:lblBatasMasuk %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item4" runat="server" Visible="False" Text='<%# Bind("BATAS_MASUK_ULANG", "{0:HH:mm}") %>' MaxLength="5" Columns="5"></asp:TextBox> <asp:RegularExpressionValidator id="valtxtCol1Item4" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtCol1Item4" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexCol1Item4" runat="server" TargetControlID="txtCol1Item4" MaskType="Time" Mask="99:99"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="lblTarifMakan" runat="server" Text="<%$ Resources:Column5 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:Label id="lblRp" runat="server" Text="Rp."></asp:Label>&nbsp;<asp:TextBox id="txtCol1Item5" runat="server" Text='<%# Bind("TARIF_MAKAN") %>' MaxLength="7" Columns="7"></asp:TextBox>&nbsp;<asp:CompareValidator id="valtxtCol1Item5" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol1Item5" EnableClientScript="True" Type="Integer" ValueToCompare="0" Operator="GreaterThanEqual">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol1Item5" runat="server" TargetControlID="txtCol1Item5" MaskType="Number" Mask="9999999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label5" runat="server" Text="<%$ Resources:Column6 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item6" runat="server" Text='<%# Bind("MAKS_HARI_TERIMA_MAKAN") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item6" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item6" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item6" runat="server" TargetControlID="txtCol1Item6" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label6" runat="server" Text="<%$ Resources:Column7 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item7" runat="server" Text='<%# Bind("POTONGAN_MANGKIR") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item7" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item7" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item7" runat="server" TargetControlID="txtCol1Item7" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label7" runat="server" Text="<%$ Resources:Column8 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item8" runat="server" Text='<%# Bind("POTONGAN_MANGKIR3X") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item8" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item8" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item8" runat="server" TargetControlID="txtCol1Item8" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label8" runat="server" Text="<%$ Resources:Column9 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item9" runat="server" Text='<%# Bind("POTONGAN_MANGKIR4X") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item9" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item9" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item9" runat="server" TargetControlID="txtCol1Item9" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label9" runat="server" Text="<%$ Resources:Column10 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item10" runat="server" Text='<%# Bind("POTONGAN_MANGKIR5X") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item10" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item10" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item10" runat="server" TargetControlID="txtCol1Item10" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR>
    <TR><TD style="WIDTH: 200px"><asp:Label id="Label10" runat="server" Text="<%$ Resources:Column11 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item11" runat="server" Text='<%# Bind("POTONGAN_TERLAMBAT") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item11" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item11" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item11" runat="server" TargetControlID="txtCol1Item11" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label11" runat="server" Text="<%$ Resources:Column12 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item12" runat="server" Text='<%# Bind("POTONGAN_CEPAT_PULANG") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item12" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item12" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item12" runat="server" TargetControlID="txtCol1Item12" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label12" runat="server" Text="<%$ Resources:Column13 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item13" runat="server" Text='<%# Bind("POTONGAN_CUTI") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item13" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item13" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item13" runat="server" TargetControlID="txtCol1Item13" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label13" runat="server" Text="<%$ Resources:Column14 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item14" runat="server" Text='<%# Bind("POTONGAN_LAMBAT_CEPAT_PULANG5X") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item14" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item14" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item14" runat="server" TargetControlID="txtCol1Item14" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label14" runat="server" Text="<%$ Resources:Column15 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item15" runat="server" Text='<%# Bind("POTONGAN_LAMBAT_CEPAT_PULANG6X") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item15" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item15" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item15" runat="server" TargetControlID="txtCol1Item15" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 200px"><asp:Label id="Label15" runat="server" Text="<%$ Resources:Column16 %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtCol1Item16" runat="server" Text='<%# Bind("POTONGAN_LAMBAT_CEPAT_PULANG7X") %>' MaxLength="3" Columns="3"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item16" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item16" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="0" MaximumValue="100">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item16" runat="server" TargetControlID="txtCol1Item16" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR>
    <tr>
        <td style="width: 200px">
            <asp:Label ID="Label17" runat="server" Text="<%$ Resources:Column17 %>"></asp:Label></td>
        <td style="width: 400px">
            <asp:TextBox ID="txtCol1Item17" runat="server" Columns="3" MaxLength="3" Text='<%# Bind("POTONGAN_LAMBAT_CEPAT_PULANG7XX") %>'></asp:TextBox><asp:RangeValidator
                ID="valtxtCol1Item17" runat="server" ControlToValidate="txtCol1Item17" CssClass="fontR"
                EnableClientScript="True" ErrorMessage="<%$ Resources:lblRange %>" MaximumValue="100"
                MinimumValue="0" SetFocusOnError="True" SkinID="fontR" Type="Integer">*</asp:RangeValidator><cc1:MaskedEditExtender id="mexCol1Item17" runat="server" TargetControlID="txtCol1Item17" MaskType="Number" Mask="999" AutoComplete="False">
                </cc1:MaskedEditExtender>
        </td>
    </tr>
    <tr>
        <td style="width: 200px">
            <asp:Label ID="Label18" runat="server" Text="<%$ Resources:Column18 %>"></asp:Label></td>
        <td style="width: 400px">
            <asp:TextBox ID="txtCol1Item18" runat="server" Columns="3" MaxLength="3" Text='<%# Bind("POTONGAN_TDK_UPACARA") %>'></asp:TextBox><asp:RangeValidator
                ID="valtxtCol1Item18" runat="server" ControlToValidate="txtCol1Item18" CssClass="fontR"
                EnableClientScript="True" ErrorMessage="<%$ Resources:lblRange %>" MaximumValue="100"
                MinimumValue="0" SetFocusOnError="True" SkinID="fontR" Type="Integer">*</asp:RangeValidator><cc1:MaskedEditExtender id="mexCol1Item18" runat="server" TargetControlID="txtCol1Item18" MaskType="Number" Mask="999" AutoComplete="False">
                </cc1:MaskedEditExtender>
        </td>
    </tr>
    <TR><TD style="WIDTH: 200px"><asp:Label id="Label16" runat="server" Text="Entry Bersambung"></asp:Label></TD><TD style="WIDTH: 400px"><asp:CheckBox id="chkCol1Item17" runat="server" Checked='<%# Bind("ENTRY_BERSAMBUNG") %>'></asp:CheckBox></TD></TR></TBODY></TABLE><BR /><asp:button id="btnOK" tabIndex=4 runat="server" Text="<%$ Resources:tblUpdate %>" CommandName="Update"></asp:button> 
</EditItemTemplate>
</asp:FormView> <asp:SqlDataSource id="dsVariable" runat="server" OnUpdating="dsVariable_Updating" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT TGL_LAPORAN, TUTUP_PERIODE, DEF_LIMIT_AWAL, DEF_LIMIT_AKHIR, BATAS_MASUK_ULANG, TARIF_MAKAN, MAKS_HARI_TERIMA_MAKAN, POTONGAN_MANGKIR, POTONGAN_MANGKIR3X, POTONGAN_MANGKIR4X, POTONGAN_MANGKIR5X, POTONGAN_TERLAMBAT, POTONGAN_CEPAT_PULANG, POTONGAN_CUTI, POTONGAN_LAMBAT_CEPAT_PULANG5X, POTONGAN_LAMBAT_CEPAT_PULANG6X, POTONGAN_LAMBAT_CEPAT_PULANG7X, POTONGAN_LAMBAT_CEPAT_PULANG7XX, POTONGAN_TDK_UPACARA, ENTRY_BERSAMBUNG FROM taVariabel" UpdateCommand="UPDATE taVariabel SET TGL_LAPORAN = @TGL_LAPORAN, TUTUP_PERIODE = @TUTUP_PERIODE, DEF_LIMIT_AWAL = @DEF_LIMIT_AWAL, DEF_LIMIT_AKHIR = @DEF_LIMIT_AKHIR, BATAS_MASUK_ULANG = @BATAS_MASUK_ULANG, TARIF_MAKAN = @TARIF_MAKAN, MAKS_HARI_TERIMA_MAKAN = @MAKS_HARI_TERIMA_MAKAN, POTONGAN_MANGKIR = @POTONGAN_MANGKIR, POTONGAN_MANGKIR3X = @POTONGAN_MANGKIR3X, POTONGAN_MANGKIR4X = @POTONGAN_MANGKIR4X, POTONGAN_MANGKIR5X = @POTONGAN_MANGKIR5X, POTONGAN_TERLAMBAT = @POTONGAN_TERLAMBAT, POTONGAN_CEPAT_PULANG = @POTONGAN_CEPAT_PULANG, POTONGAN_CUTI = @POTONGAN_CUTI, POTONGAN_LAMBAT_CEPAT_PULANG5X = @POTONGAN_LAMBAT_CEPAT_PULANG5X, POTONGAN_LAMBAT_CEPAT_PULANG6X = @POTONGAN_LAMBAT_CEPAT_PULANG6X, POTONGAN_LAMBAT_CEPAT_PULANG7X = @POTONGAN_LAMBAT_CEPAT_PULANG7X, POTONGAN_LAMBAT_CEPAT_PULANG7XX = @POTONGAN_LAMBAT_CEPAT_PULANG7XX, POTONGAN_TDK_UPACARA = @POTONGAN_TDK_UPACARA, ENTRY_BERSAMBUNG = @ENTRY_BERSAMBUNG" OnUpdated="dsVariable_Updated"><UpdateParameters>
<asp:Parameter Name="TGL_LAPORAN"></asp:Parameter>
<asp:Parameter Name="TUTUP_PERIODE"></asp:Parameter>
<asp:Parameter Name="DEF_LIMIT_AWAL"></asp:Parameter>
<asp:Parameter Name="DEF_LIMIT_AKHIR"></asp:Parameter>
<asp:Parameter Name="BATAS_MASUK_ULANG"></asp:Parameter>
<asp:Parameter Name="TARIF_MAKAN"></asp:Parameter>
<asp:Parameter Name="MAKS_HARI_TERIMA_MAKAN"></asp:Parameter>
<asp:Parameter Name="POTONGAN_MANGKIR"></asp:Parameter>
<asp:Parameter Name="POTONGAN_MANGKIR3X"></asp:Parameter>
<asp:Parameter Name="POTONGAN_MANGKIR4X"></asp:Parameter>
<asp:Parameter Name="POTONGAN_MANGKIR5X"></asp:Parameter>
<asp:Parameter Name="POTONGAN_TERLAMBAT"></asp:Parameter>
<asp:Parameter Name="POTONGAN_CEPAT_PULANG"></asp:Parameter>
<asp:Parameter Name="POTONGAN_CUTI"></asp:Parameter>
<asp:Parameter Name="POTONGAN_LAMBAT_CEPAT_PULANG5X"></asp:Parameter>
<asp:Parameter Name="POTONGAN_LAMBAT_CEPAT_PULANG6X"></asp:Parameter>
<asp:Parameter Name="POTONGAN_LAMBAT_CEPAT_PULANG7X"></asp:Parameter>
    <asp:Parameter Name="POTONGAN_LAMBAT_CEPAT_PULANG7XX" />
    <asp:Parameter Name="POTONGAN_TDK_UPACARA" />
<asp:Parameter Name="ENTRY_BERSAMBUNG"></asp:Parameter>
</UpdateParameters>
</asp:SqlDataSource><BR /><asp:Label id="Label7" runat="server" Font-Bold="True" Text="Pengaturan Entry menggunakan PIN untuk setiap Satuan Kerja"></asp:Label><BR /><BR /><asp:GridView id="GVCabang" runat="server" width="570px" DataSourceID="dsCabang" DataKeyNames="KODE_CABANG" OnRowDataBound="GVCabang_RowDataBound" OnDataBound="GVCabang_DataBound" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"><Columns>
<asp:TemplateField SortExpression="KODE_CABANG" HeaderText="KODE"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Eval("KODE_CABANG") %>'></asp:Label> 
</EditItemTemplate>

<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Eval("KODE_CABANG") %>'></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_CABANG" HeaderText="NAMA SATUAN KERJA"><EditItemTemplate>
<asp:Label id="lblCol1Edit" runat="server" Text='<%# Eval("NAMA_CABANG") %>'></asp:Label>
</EditItemTemplate>

<ItemStyle Width="320px" HorizontalAlign="Left"></ItemStyle>

<HeaderStyle Width="320px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Eval("NAMA_CABANG") %>'></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Left"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="ENTRY PIN"><EditItemTemplate>
<asp:CheckBox id="chkCol2Edit" runat="server" Checked='<%# Bind("ENTRY_PIN") %>'></asp:CheckBox> 
</EditItemTemplate>

<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:CheckBox id="chkCol2Item" runat="server" Enabled="False" Checked='<%# Eval("ENTRY_PIN") %>'></asp:CheckBox> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="UBAH"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" CommandName="Update" AlternateText="Ubah"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" CommandName="Cancel" AlternateText="Batal"></asp:ImageButton>
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" CommandName="Edit" AlternateText="Ubah"></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<RowStyle HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
&nbsp; 
</EmptyDataTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsCabang" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [KODE_CABANG], [NAMA_CABANG], [ENTRY_PIN] FROM [taCabang] WHERE KODE_CABANG <> '---'" UpdateCommand="UPDATE taCabang SET ENTRY_PIN = @ENTRY_PIN WHERE (KODE_CABANG = @KODE_CABANG)"></asp:SqlDataSource> 
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td style="WIDTH: 39px"><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign="bottom" align="right"></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:Label ID="lblRange" runat="server" Text="<%$ Resources:lblRange %>"
        Visible="False"></asp:Label><br />
    <asp:Label ID="lblConfigUpdated" runat="server" Text="<%$ Resources:lblConfigUpdated %>" Visible="False"></asp:Label><asp:Label ID="lblConfigNotUpdated" runat="server" Text="<%$ Resources:lblConfigNotUpdated %>" Visible="False"></asp:Label><br />
</asp:Content>
			