<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="employee_history.aspx.cs" Inherits="rtwin.employee_history" title="Sistem Kehadiran Kerja Pegawai Sekretariat Negara" Culture="auto:id-ID" UICulture="auto"  %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                        <td class="backgroundTitle" style="width:200px">
                            <img style="vertical-align: middle" height="27" src="images/back_title.gif" alt="" />&nbsp;
                            <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                        </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><TABLE id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 width="100%" runat="server"><TBODY><TR><TD><BR /><TABLE cellPadding=1 width=750 border=0><TBODY>
<TR>
<TD colspan="3" align=left>
    <asp:Label ID="Label20" runat="server" Text="<%$ Resources:lblTahun %>"></asp:Label>
    &nbsp;
    <asp:DropDownList ID="ddlTahun" runat="server">
    </asp:DropDownList>
    &nbsp;<asp:Label ID="Label37" runat="server" Text="<%$ Resources:lblBulan %>" 
        Visible="False"></asp:Label>
    &nbsp;&nbsp;&nbsp;<asp:DropDownList ID="DropBulan" runat="server" Visible="False"></asp:DropDownList>
    &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;</TD>               
</TR>
<tr>
                    <td align="left" colspan="3">
                        <asp:Label ID="lblNIP" runat="server" Text="<%$ Resources:lblNIP %>"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;:&nbsp;
                          <asp:TextBox ID="txtFilterItem0" runat="server" width="100px"></asp:TextBox>&nbsp;&nbsp;
                        <asp:LinkButton ID="lnkFilterItem0" runat="server" CausesValidation="False" 
                            onclick="lnkCol2Footer_Click">Lookup</asp:LinkButton>&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnRefresh" runat="server" onclick="btnRefresh_Click" 
                            Text="<%$ Resources:btnRefresh %>" />
                    </td>
                   
                </tr>
                <TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:CbBiro %>" 
                        Visible="False"></asp:Label></TD><TD><asp:DropDownList id="ddlFilterItem1" 
                            runat="server" OnSelectedIndexChanged="ddlFilterItem1_DataBound_SelectedChange" 
                            AutoPostBack="True" DataSourceID="dsBiro" DataValueField="KODE_BIRO" 
                            DataTextField="NAMA_BIRO" OnDataBound="ddlFilterItem1_DataBound_SelectedChange" 
                            Visible="False"></asp:DropDownList>&nbsp; </TD><TD></TD></TR><TR><TD>
                <asp:Label id="lblBagian" runat="server" Text="<%$ Resources:CbBagian %>" 
                    Visible="False"></asp:Label></TD><TD><asp:DropDownList id="ddlFilterItem2" 
                        runat="server" DataSourceID="dsBagian" DataValueField="KODE_BAGIAN" 
                        DataTextField="NAMA_BAGIAN" Visible="False"></asp:DropDownList> </TD><TD></TD></TR><TR><TD>
                <asp:Label id="lblEnroll" runat="server" Text="<%$ Resources:lblEnroll %>" 
                    Visible="False"></asp:Label></TD><TD><asp:DropDownList id="ddlFilterItem3" 
                        runat="server" Visible="False"><asp:ListItem Value="0"></asp:ListItem>
<asp:ListItem Value="1">Sudah</asp:ListItem>
<asp:ListItem Value="2">Belum</asp:ListItem>
</asp:DropDownList></TD><TD></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR>
            <TD vAlign=top><asp:ImageButton id="ImgbtnAdd" onclick="ImgbtnAdd_Click" 
                    runat="server" ImageUrl="~/Images/ipost.gif" 
                    AlternateText="<%$ Resources:ImgAdd %>" Visible="False"></asp:ImageButton> 
                <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" 
                    Text="<%$ Resources:ImgAdd %>" Visible="False"></asp:LinkButton><BR /><BR />
                <asp:GridView id="GvKaryawan" runat="server" DataSourceID="dsKaryawan" 
                    OnDataBound="GvKaryawan_DataBound" OnRowEditing="GvKaryawan_RowEditing" 
                    OnRowDataBound="GvKaryawan_RowDataBound" DataKeyNames="NIP,BULAN,TAHUN" 
                    AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" 
                    EmptyDataText="<%$ Resources:lblEmptyData %>" 
                    OnRowCommand="GvKaryawan_RowCommand" EnableModelValidation="True">
<PagerSettings Mode="NumericFirstLast"></PagerSettings>
<Columns>
    <asp:TemplateField SortExpression="BULAN" HeaderText="<%$ Resources:lblBulan %>">
        <ItemTemplate>
            <asp:Label ID="Label38" runat="server" Text='<%# BIND("BULAN") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField SortExpression="TAHUN" HeaderText="<%$ Resources:lblTahun %>">
        <ItemTemplate>
            <asp:Label ID="Label40" runat="server" Text='<%# BIND("TAHUN") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField SortExpression="NIP" HeaderText="<%$ Resources:lblNIP %>">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("NIP") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:lblNama %>">
<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField SortExpression="SATUAN_KERJA" HeaderText="<%$ Resources:lblSatker %>">
        <ItemTemplate>
            <asp:Label ID="Label39" runat="server" Text='<%# BIND("NAMA_CABANG") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_JABATAN" HeaderText="<%$ Resources:lblNamaJabatan %>">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("NAMA_JABATAN") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_GOLONGAN" HeaderText="<%$ Resources:lblNamaGolongan %>">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("NAMA_GOLONGAN") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:lblEdit %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" AlternateText="<%$ Resources:ImgEdit %>" ImageUrl="~/images/iedit.gif" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:lblDelete %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" PopupControlID="PNLKonfirmasi" CancelControlID="btnCancel" OkControlID="btnOK" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:ImgDetail %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgView" runat="server" AlternateText="<%$ Resources:ImgDetail %>" ImageUrl="~/images/iview.gif" CommandName="Detail"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnFirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton>&nbsp; <asp:ImageButton id="btnPrev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label>&nbsp;<asp:ImageButton id="btnNext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton>&nbsp;<asp:ImageButton id="btnLast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton>&nbsp; <asp:Label id="lbljml" runat="server"></asp:Label> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsKaryawan" runat="server" SelectCommand=" SELECT NIP,BULAN,TAHUN,KODE_CABANG,KODE_DEPARTEMEN,KODE_JABATAN,KODE_GOLONGAN,KODE_UNIT,KODE_BAGIAN,KODE_SUBBAGIAN,KODE_ESELON,KODE_STATUS_PEGAWAI, KODE_GRADE,LAP_KEUANGAN ,NOREK_BANK,PIN,NAMA,NAMA_CABANG,NAMA_JABATAN,NAMA_GOLONGAN,NAMA_UNIT,NAMA_BAGIAN,NAMA_SUBBAGIAN,NAMA_ESELON,NAMA_STATUS_PEGAWAI 
  FROM q_RiwayatKaryawan  " ConnectionString="<%$ ConnectionStrings:strCn %>" 
                    OnDeleted="dsKaryawan_Deleted" 
                    DeleteCommand="DELETE FROM taKaryawan WHERE (NIP = @NIP)"><DeleteParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
</DeleteParameters>
</asp:SqlDataSource><asp:SqlDataSource id="dsBagian" runat="server" SelectCommand="SELECT KODE_BAGIAN, NAMA_BAGIAN, KODE_CABANG, KODE_BIRO FROM q_Bagian ORDER BY KODE_BAGIAN" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource> 
<asp:FormView id="FvKaryawan" runat="server" DataSourceID="dsKaryawanManajemen" OnDataBound="FvKaryawan_DataBound" DataKeyNames="NIP,BULAN,TAHUN" OnItemCommand="FvKaryawan_ItemCommand"><EditItemTemplate>
<TABLE class="listBorder" cellPadding=1 width=600><TBODY>
<tr>
<td colspan=2 align="left">

    <asp:Label ID="Label47" runat="server" Text="<%$ Resources:lblBulan %>"></asp:Label>&nbsp;&nbsp;
    <asp:Label ID="Label48" runat="server" Text='<%# Eval("BULAN") %>'></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label49" runat="server" Text="<%$ Resources:lblTahun %>"></asp:Label>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Label ID="Label50" runat="server" Text='<%# Eval("TAHUN") %>'></asp:Label>

</td>
</tr>

<TR><TD style="HEIGHT: 18px">
    <asp:TextBox ID="txtBulanEdit" runat="server" ReadOnly="True" 
        Text='<%# BIND("BULAN") %>' Visible="False"></asp:TextBox>
    <asp:TextBox ID="txtTahunEdit" runat="server" ReadOnly="True" 
        Text='<%# BIND("TAHUN") %>' Visible="False"></asp:TextBox>
    <asp:TextBox ID="txtNIPEdit" runat="server" ReadOnly="True" 
        Text='<%# BIND("NIP") %>' Visible="False"></asp:TextBox>
    </TD><TD style="HEIGHT: 18px">
        <asp:Label ID="Label36" runat="server" Visible="False"></asp:Label>
    </TD></TR><TR><TD>&nbsp;<asp:Label id="Label1" runat="server" Text="<%$ Resources:lblNIP %>" width="100px"></asp:Label></TD><TD><asp:Label id="lblNIP" runat="server" Text='<%# Eval("NIP") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label2" runat="server" Text="<%$ Resources:lblPIN %>"></asp:Label></TD><TD><asp:TextBox id="txtPIN" runat="server" Text='<%# Bind("PIN") %>' Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valPIN" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtPIN" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD>&nbsp;<asp:Label id="LabelNama" runat="server" Text="<%$ Resources:lblNama %>"></asp:Label></TD><TD><asp:TextBox id="txtNama" runat="server" Text='<%# Bind("NAMA") %>' Columns="30" MaxLength="50"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valNama" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtNama" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD>&nbsp;<asp:Label id="Label12" runat="server" Text="<%$ Resources:lblUnit %>"></asp:Label></TD><TD><asp:DropDownList id="ddlKodeUnit" runat="server" OnSelectedIndexChanged="ddlKodeUnit_DataBound" AutoPostBack="True" DataSourceID="dsUnit" DataValueField="KODE_UNIT" DataTextField="NAMA_UNIT" OnDataBound="ddlKodeUnit_DataBound"></asp:DropDownList>&nbsp; <asp:HiddenField id="HiddenUnit" runat="server" Value='<%# Eval("KODE_UNIT") %>' OnDataBinding="HiddenUnit_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label14" runat="server" Text="<%$ Resources:lblDeputi %>"></asp:Label></TD><TD><asp:DropDownList id="ddlKodeDeputi" runat="server" OnSelectedIndexChanged="ddlKodeDeputi_DataBound" AutoPostBack="True" DataSourceID="dsDeputi" DataValueField="KODE_DEPUTI" DataTextField="NAMA_DEPUTI" OnDataBound="ddlKodeDeputi_DataBound"></asp:DropDownList><asp:HiddenField id="HiddenDeputi" runat="server" Value='<%# Eval("KODE_DEPUTI") %>' OnDataBinding="HiddenDeputi_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label13" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD><asp:DropDownList id="ddlBiro" runat="server" OnSelectedIndexChanged="ddlBiro_DataBound" AutoPostBack="True" DataSourceID="dsBiroManajemen" DataValueField="KODE_BIRO" DataTextField="NAMA_BIRO" OnDataBound="ddlBiro_DataBound"></asp:DropDownList> <asp:HiddenField id="HiddenBiro" runat="server" Value='<%# Eval("KODE_BIRO") %>' OnDataBinding="HiddenBiro_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label15" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD><asp:DropDownList id="ddlBagian" runat="server" OnSelectedIndexChanged="ddlBagian_DataBound" AutoPostBack="True" DataSourceID="dsBagianManajemen" DataValueField="KODE_BAGIAN" DataTextField="NAMA_BAGIAN" OnDataBound="ddlBagian_DataBound"></asp:DropDownList> <asp:HiddenField id="HiddenBagian" runat="server" Value='<%# Eval("KODE_BAGIAN") %>' OnDataBinding="HiddenBagian_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label18" runat="server" Text="<%$ Resources:lblSubBagian %>"></asp:Label></TD><TD><asp:DropDownList id="ddlSubBagian" runat="server" DataSourceID="dsSubBagian" DataValueField="KODE_SUBBAGIAN" DataTextField="NAMA_SUBBAGIAN"></asp:DropDownList> <asp:HiddenField id="HiddenSubBagian" runat="server" Value='<%# Eval("KODE_SUBBAGIAN") %>' OnDataBinding="HiddenSubBagian_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label17" runat="server" Text="<%$ Resources:lblNamaJabatan %>"></asp:Label></TD><TD><asp:DropDownList id="ddlJabatan" runat="server" DataSourceID="dsJabatan" DataValueField="KODE_JABATAN" DataTextField="NAMA_JABATAN"></asp:DropDownList> <asp:HiddenField id="HiddenJabatan" runat="server" Value='<%# Eval("KODE_JABATAN") %>' OnDataBinding="HiddenJabatan_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label16" runat="server" Text="<%$ Resources:lblNamaGolongan %>"></asp:Label></TD><TD><asp:DropDownList id="ddlGolongan" runat="server" DataSourceID="dsGolongan" DataValueField="KODE_GOLONGAN" DataTextField="NAMA_GOLONGAN"></asp:DropDownList> <asp:HiddenField id="HiddenGolongan" runat="server" Value='<%# Eval("KODE_GOLONGAN") %>' OnDataBinding="HiddenGolongan_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label19" runat="server" Text="Grade"></asp:Label></TD><TD>
    <asp:DropDownList id="ddlGrade" runat="server" DataSourceID="dsGrade" 
        DataValueField="KODE_GRADE" DataTextField="KODE_GRADE"></asp:DropDownList> <asp:HiddenField id="HiddenGrade" runat="server" Value='<%# Eval("KODE_GRADE") %>' OnDataBinding="HiddenGrade_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label3" runat="server" Text="<%$ Resources:lblEselon %>"></asp:Label></TD><TD><asp:DropDownList id="ddlEselon" runat="server" DataSourceID="dsEselon" DataValueField="KODE_ESELON" DataTextField="NAMA_ESELON"></asp:DropDownList> <asp:HiddenField id="HiddenEselon" runat="server" Value='<%# Eval("KODE_ESELON") %>' OnDataBinding="HiddenEselon_DataBinding"></asp:HiddenField></TD></TR><TR><TD>&nbsp;<asp:Label id="Label9" runat="server" Text="<%$ Resources:lblStatusPegawai %>"></asp:Label></TD><TD><asp:DropDownList id="ddlStatusPegawai" runat="server" DataSourceID="dsStatusPegawai" DataValueField="KODE_STATUS_PEGAWAI" DataTextField="NAMA_STATUS_PEGAWAI"></asp:DropDownList> <asp:HiddenField id="HiddenStatusPegawai" runat="server" Value='<%# Eval("KODE_STATUS_PEGAWAI") %>' OnDataBinding="HiddenStatusPegawai_DataBinding"></asp:HiddenField></TD></TR>
    <tr>
        <td>
            &nbsp;<asp:Label ID="Label10" runat="server" 
                Text="<%$ Resources:lblNoRek %>"></asp:Label>
        </td>
        <td>
            <asp:TextBox ID="txtNoRek" runat="server" Columns="30" 
                MaxLength="30" Text='<%# Bind("NOREK_BANK") %>'></asp:TextBox>
        </td>
    </tr>
    <TR><TD>
        &nbsp;
        <asp:Label ID="Label45" runat="server" Text="<%$ Resources:lblKeuangan %>"></asp:Label>
        </TD>
        <td>
            <asp:CheckBox ID="lapKeuEdit" runat="server" 
                Checked='<%# Eval("LAP_KEUANGAN") %>' />
        </td>
    </TR><TR><TD>&nbsp;
        <asp:Label ID="Label46" runat="server" Text="<%$ Resources:lblUangMakan %>"></asp:Label>
        </TD>
        <td>
            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Eval("UM") %>' />
        </td>
    </TR>

    <tr>
        <td colspan="2" style="HEIGHT: 28px" valign="bottom">
            &nbsp;<asp:ImageButton ID="btnEdit" runat="server" 
                AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update" 
                ImageUrl="~/images/edit.gif" onclick="btnEdit_Click" 
                style="VERTICAL-ALIGN: middle" />
            &nbsp;
            <asp:LinkButton ID="lbledit" runat="server" 
                onclick="lbledit_Click" Text="<%$ Resources:ImgUpdate %>"></asp:LinkButton>
            &nbsp;&nbsp;
            <asp:ImageButton ID="btnCancel" runat="server" 
                AlternateText="<%$ Resources:ImgCancel %>" CausesValidation="False" 
                CommandName="Cancel_Edit" ImageUrl="~/images/delete.gif" 
                style="VERTICAL-ALIGN: middle" />
            &nbsp;
            <asp:LinkButton ID="lbCancel" runat="server" 
                CausesValidation="False" CommandName="Cancel_Edit" 
                Text="<%$ Resources:ImgCancel %>"></asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td colspan="2" style="HEIGHT: 27px">
        </td>
    </tr>
    </TBODY></TABLE>
</EditItemTemplate>
<InsertItemTemplate>
<TABLE class="listBorder" cellPadding=1 width=600><TBODY><TR><TD style="HEIGHT: 18px"></TD><TD style="HEIGHT: 18px"></TD></TR><TR><TD>&nbsp;<asp:Label id="Label1" runat="server" Text="<%$ Resources:lblNIP %>" width="100px"></asp:Label></TD><TD><asp:TextBox id="txtNIP" runat="server" Text='<%# Bind("NIP") %>' Columns="25" MaxLength="25"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valNIP" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtNIP" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD>&nbsp;<asp:Label id="Label2" runat="server" Text="<%$ Resources:lblPIN %>"></asp:Label></TD><TD><asp:TextBox id="txtPIN" runat="server" Text='<%# Bind("PIN") %>' Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valPIN" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtPIN" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD>&nbsp;<asp:Label id="LabelNama" runat="server" Text="<%$ Resources:lblNama %>"></asp:Label></TD><TD><asp:TextBox id="txtNama" runat="server" Text='<%# Bind("NAMA") %>' Columns="30" MaxLength="50"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valNama" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtNama" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD>&nbsp;<asp:Label id="Label12" runat="server" Text="<%$ Resources:lblUnit %>"></asp:Label></TD><TD><asp:DropDownList id="ddlKodeUnit" runat="server" OnSelectedIndexChanged="ddlKodeUnit_DataBound" AutoPostBack="True" DataSourceID="dsUnit" DataValueField="KODE_UNIT" DataTextField="NAMA_UNIT" OnDataBound="ddlKodeUnit_DataBound"></asp:DropDownList>&nbsp; </TD></TR><TR><TD>&nbsp;<asp:Label id="Label14" runat="server" Text="<%$ Resources:lblDeputi %>"></asp:Label></TD><TD><asp:DropDownList id="ddlKodeDeputi" runat="server" OnSelectedIndexChanged="ddlKodeDeputi_DataBound" AutoPostBack="True" DataSourceID="dsDeputi" DataValueField="KODE_DEPUTI" DataTextField="NAMA_DEPUTI" OnDataBound="ddlKodeDeputi_DataBound"></asp:DropDownList></TD></TR><TR><TD>&nbsp;<asp:Label id="Label13" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD><asp:DropDownList id="ddlBiro" runat="server" OnSelectedIndexChanged="ddlBiro_DataBound" AutoPostBack="True" DataSourceID="dsBiroManajemen" DataValueField="KODE_BIRO" DataTextField="NAMA_BIRO" OnDataBound="ddlBiro_DataBound"></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label15" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD><asp:DropDownList id="ddlBagian" runat="server" OnSelectedIndexChanged="ddlBagian_DataBound" AutoPostBack="True" DataSourceID="dsBagianManajemen" DataValueField="KODE_BAGIAN" DataTextField="NAMA_BAGIAN" OnDataBound="ddlBagian_DataBound"></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label18" runat="server" Text="<%$ Resources:lblSubBagian %>"></asp:Label></TD><TD><asp:DropDownList id="ddlSubBagian" runat="server" DataSourceID="dsSubBagian" DataValueField="KODE_SUBBAGIAN" DataTextField="NAMA_SUBBAGIAN"></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label17" runat="server" Text="<%$ Resources:lblNamaJabatan %>"></asp:Label></TD><TD><asp:DropDownList id="ddlJabatan" runat="server" DataSourceID="dsJabatan" DataValueField="KODE_JABATAN" DataTextField="NAMA_JABATAN" SelectedValue='<%# Bind("KODE_JABATAN") %>'></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label16" runat="server" Text="<%$ Resources:lblNamaGolongan %>"></asp:Label></TD><TD><asp:DropDownList id="ddlGolongan" runat="server" DataSourceID="dsGolongan" DataValueField="KODE_GOLONGAN" DataTextField="NAMA_GOLONGAN" SelectedValue='<%# Bind("KODE_GOLONGAN") %>'></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label19" runat="server" Text="Grade"></asp:Label></TD><TD><asp:DropDownList id="ddlGrade" runat="server" DataSourceID="dsGrade" DataValueField="KODE_GRADE" DataTextField="NILAI_GRADE" SelectedValue='<%# Bind("KODE_GRADE") %>'></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label3" runat="server" Text="<%$ Resources:lblEselon %>"></asp:Label></TD><TD><asp:DropDownList id="ddlEselon" runat="server" DataSourceID="dsEselon" DataValueField="KODE_ESELON" DataTextField="NAMA_ESELON" SelectedValue='<%# Bind("KODE_ESELON") %>'></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label9" runat="server" Text="<%$ Resources:lblStatusPegawai %>"></asp:Label></TD><TD><asp:DropDownList id="ddlStatusPegawai" runat="server" DataSourceID="dsStatusPegawai" DataValueField="KODE_STATUS_PEGAWAI" DataTextField="NAMA_STATUS_PEGAWAI" SelectedValue='<%# Bind("KODE_STATUS_PEGAWAI") %>'></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label5" runat="server" Text="<%$ Resources:lblTMT %>"></asp:Label></TD><TD><asp:TextBox id="txtTMT" runat="server" Text='<%# Bind("TMT", "{0:d}") %>' width="100px" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgTMT" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RegularExpressionValidator id="valTMT2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtTMT" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator><cc1:CalendarExtender id="cexTMT" runat="server" CssClass="cal_Theme1" targetcontrolid="txtTMT" PopupButtonID="imgTMT" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexTMT" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtTMT"></cc1:MaskedEditExtender></TD></TR><TR><TD>&nbsp;<asp:Label id="Label6" runat="server" Text="<%$ Resources:lblAktif %>" width="100px"></asp:Label></TD><TD><asp:TextBox id="txtAktif" runat="server" Text='<%# Bind("AKTIF", "{0:d}") %>' width="100px" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgAktif" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RegularExpressionValidator id="valAktif2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtAktif" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator><cc1:CalendarExtender id="cexAktif" runat="server" CssClass="cal_Theme1" targetcontrolid="txtAktif" PopupButtonID="imgAktif" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexAktif" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtAktif"></cc1:MaskedEditExtender></TD></TR><TR><TD>&nbsp;<asp:Label id="Label7" runat="server" Text="<%$ Resources:lblTidakAktif %>"></asp:Label></TD><TD><asp:TextBox id="txtNonAktif" runat="server" Text='<%# Bind("NON_AKTIF", "{0:d}") %>' width="100px" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgNonAktif" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RegularExpressionValidator id="valNonAktif2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtNonAktif" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator><cc1:CalendarExtender id="cexNonAktif" runat="server" CssClass="cal_Theme1" targetcontrolid="txtNonAktif" PopupButtonID="imgNonAktif" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexNonAktif" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtNonAktif"></cc1:MaskedEditExtender></TD></TR><TR><TD>&nbsp;<asp:Label id="Label4" runat="server" Text="<%$ Resources:lblTanggalLahir %>"></asp:Label></TD><TD><asp:TextBox id="txtTglLahir" runat="server" Text='<%# Bind("TGL_LAHIR", "{0:d}") %>' width="100px" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgTglLahir" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RegularExpressionValidator id="valTglLahir2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtTglLahir" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator><cc1:CalendarExtender id="cexTglLahir" runat="server" CssClass="cal_Theme1" targetcontrolid="txtTglLahir" PopupButtonID="imgTglLahir" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexTglLahir" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtTglLahir"></cc1:MaskedEditExtender></TD></TR><TR><TD>&nbsp;<asp:Label id="Label8" runat="server" Text="<%$ Resources:lblGroup %>"></asp:Label></TD><TD><asp:DropDownList id="ddlShift" runat="server" DataSourceID="dsShift" DataValueField="KODE_SHIFT" DataTextField="NAMA_GROUP" SelectedValue='<%# Bind("KODE_SHIFT") %>'></asp:DropDownList> </TD></TR><TR><TD>&nbsp;<asp:Label id="Label10" runat="server" Text="<%$ Resources:lblNoRek %>"></asp:Label></TD><TD><asp:TextBox id="txtNoRek" runat="server" Text='<%# Bind("NOREK_BANK") %>' Columns="30" MaxLength="30"></asp:TextBox></TD></TR><TR><TD>&nbsp;<asp:Label id="Label23" runat="server" Text="NPWP"></asp:Label></TD><TD><asp:TextBox id="txtNPWP" runat="server" Text='<%# Bind("NPWP") %>' Columns="20" MaxLength="20"></asp:TextBox></TD></TR><TR><TD>&nbsp;<asp:Label id="Label11" runat="server" Text="<%$ Resources:lblNipBaru %>"></asp:Label></TD><TD><asp:TextBox id="txtNipBaru" runat="server" Text='<%# Bind("NIP_BARU") %>' Columns="25" MaxLength="25"></asp:TextBox></TD></TR><TR><TD>&nbsp;<asp:Label id="Label21" runat="server" Text="<%$ Resources:lblEnroll %>"></asp:Label></TD><TD><asp:Label id="lblENROLL" runat="server" Text='<%# Bind("ENROLL") %>'></asp:Label></TD></TR><TR><TD style="HEIGHT: 28px" vAlign=bottom colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="btnInsert" runat="server" ImageUrl="~/images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton>&nbsp; <asp:LinkButton id="lblInsert" runat="server" Text="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:LinkButton> &nbsp;&nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="btnCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton>&nbsp; <asp:LinkButton id="lbCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Insert"></asp:LinkButton></TD></TR><TR><TD style="HEIGHT: 27px" colSpan=2></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
<ItemTemplate>
<TABLE class="listBorder" cellPadding=1 width=600>
<TBODY>
<TR><TD colspan="2" align="left">&nbsp;
 
    <asp:Label ID="Label41" runat="server" Text="<%$ Resources:lblBulan %>"></asp:Label> : 
   
 
    <asp:Label ID="Label42" runat="server" Text='<%# Bind("BULAN") %>'></asp:Label>
    &nbsp;<asp:Label ID="Label43" runat="server" Text="<%$ Resources:lblTahun %>"></asp:Label>
    &nbsp;<asp:Label ID="Label44" runat="server" Text='<%# Bind("TAHUN") %>'></asp:Label>
   
 
</TD>
</TR>
<TR>
<TD>&nbsp;<asp:Label id="Label1" runat="server" Text="<%$ Resources:lblNIP %>" width="100px"></asp:Label></TD><TD><asp:Label id="lblNIP" runat="server" Text='<%# Eval("NIP") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label2" runat="server" Text="<%$ Resources:lblPIN %>"></asp:Label></TD><TD><asp:Label id="lblPIN" runat="server" Text='<%# Bind("PIN") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="LabelNama" runat="server" Text="<%$ Resources:lblNama %>"></asp:Label></TD><TD><asp:Label id="lblNAMA" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label12" runat="server" Text="<%$ Resources:lblUnit %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_UNIT" runat="server" Text='<%# Bind("NAMA_UNIT") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label14" runat="server" Text="<%$ Resources:lblDeputi %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_DEPUTI" runat="server" Text='<%# Bind("NAMA_DEPUTI") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label13" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_BIRO" runat="server" Text='<%# Bind("NAMA_BIRO") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label15" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_BAGIAN" runat="server" Text='<%# Bind("NAMA_BAGIAN") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label18" runat="server" Text="<%$ Resources:lblSubBagian %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_SUBBAGIAN" runat="server" Text='<%# Bind("NAMA_SUBBAGIAN") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label17" runat="server" Text="<%$ Resources:lblNamaJabatan %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_JABATAN" runat="server" Text='<%# Bind("NAMA_JABATAN") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label16" runat="server" Text="<%$ Resources:lblNamaGolongan %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_GOLONGAN" runat="server" Text='<%# Bind("NAMA_GOLONGAN") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label19" runat="server" Text="Grade"></asp:Label></TD><TD><asp:Label id="lblKODE_GRADE" runat="server" Text='<%# Bind("KODE_GRADE") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label3" runat="server" Text="<%$ Resources:lblEselon %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_ESELON" runat="server" Text='<%# Bind("NAMA_ESELON") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="Label9" runat="server" Text="<%$ Resources:lblStatusPegawai %>"></asp:Label></TD><TD><asp:Label id="lblNAMA_STATUS_PEGAWAI" runat="server" Text='<%# Bind("NAMA_STATUS_PEGAWAI") %>'></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label 
        ID="Label10" runat="server" 
        Text="<%$ Resources:lblNoRek %>"></asp:Label>
    </TD><TD>
        <asp:Label ID="lblNOREK_BANK" runat="server" 
            Text='<%# Bind("NOREK_BANK") %>'></asp:Label>
    </TD></TR><TR><TD>&nbsp;</TD><TD>&nbsp;</TD></TR><TR><TD colspan="2" 
        style="HEIGHT: 28px" valign="bottom">&nbsp;<asp:ImageButton ID="btnEdit" 
        runat="server" AlternateText="<%$ Resources:ImgEdit %>" 
        CommandName="Edit_Detail" ImageUrl="~/images/iedit.gif" 
        style="VERTICAL-ALIGN: middle" />
    &nbsp;
    <asp:LinkButton ID="lbedit" runat="server" 
        CommandName="Edit_Detail" Text="<%$ Resources:ImgEdit %>"></asp:LinkButton>
    &nbsp;&nbsp;
    <asp:ImageButton ID="btnCancel" runat="server" 
        AlternateText="<%$ Resources:ImgCancel %>" CausesValidation="False" 
        CommandName="Cancel_Detail" ImageUrl="~/images/delete.gif" 
        style="VERTICAL-ALIGN: middle" />
    &nbsp;
    <asp:LinkButton ID="lbCancel" runat="server" 
        CausesValidation="False" CommandName="Cancel_Detail" 
        Text="<%$ Resources:ImgCancel %>"></asp:LinkButton>
    </TD></TR><TR><TD style="HEIGHT: 27px" colSpan=2></TD></TR></TBODY></TABLE>
</ItemTemplate>
</asp:FormView><asp:SqlDataSource id="dsKaryawanManajemen" runat="server" 
                    SelectCommand=" SELECT NIP,BULAN,TAHUN,KODE_CABANG,KODE_DEPARTEMEN,KODE_JABATAN,KODE_GOLONGAN,KODE_UNIT,KODE_DEPUTI,KODE_BIRO,KODE_BAGIAN,KODE_SUBBAGIAN,KODE_ESELON,KODE_STATUS_PEGAWAI, KODE_GRADE,LAP_KEUANGAN ,NOREK_BANK,PIN,NAMA,NAMA_CABANG,NAMA_JABATAN,NAMA_GOLONGAN,NAMA_UNIT,NAMA_DEPUTI,NAMA_BIRO,NAMA_BAGIAN,NAMA_SUBBAGIAN,NAMA_ESELON,NAMA_STATUS_PEGAWAI,UM
  FROM q_RiwayatKaryawan" 
                    ConnectionString="<%$ ConnectionStrings:strCn %>" 
                    OnInserted="dsKaryawanManajemen_Inserted" 
                    OnInserting="dsKaryawanManajemen_Inserting" 
                    InsertCommand="INSERT INTO taKaryawan(NIP, PIN, NAMA, KODE_CABANG, KODE_INSTANSI, KODE_UNIT, KODE_DEPUTI, KODE_BIRO, KODE_BAGIAN, KODE_SUBBAGIAN, KODE_JABATAN, KODE_GOLONGAN, KODE_GRADE, KODE_ESELON, KODE_STATUS_PEGAWAI, TMT, AKTIF, NON_AKTIF, TGL_LAHIR, KODE_SHIFT, NOREK_BANK, NIP_BARU, WAKTU_SIMPAN,NPWP) VALUES (@NIP, @PIN, @NAMA, @KODE_CABANG, @KODE_INSTANSI, @KODE_UNIT, @KODE_DEPUTI, @KODE_BIRO, @KODE_BAGIAN, @KODE_SUBBAGIAN, @KODE_JABATAN, @KODE_GOLONGAN, @KODE_GRADE, @KODE_ESELON, @KODE_STATUS_PEGAWAI, @TMT, @AKTIF, @NON_AKTIF, @TGL_LAHIR, @KODE_SHIFT, @NOREK_BANK, @NIP_BARU, @WAKTU_SIMPAN,@NPWP)" 
                    OnUpdated="dsKaryawanManajemen_Updated" 
                    OnUpdating="dsKaryawanManajemen_Updating" 
                    
                    
                    UpdateCommand="UPDATE taKaryawan SET PIN = @PIN, NAMA = @NAMA, KODE_CABANG = @KODE_CABANG, KODE_INSTANSI = @KODE_INSTANSI, KODE_UNIT = @KODE_UNIT, KODE_DEPUTI = @KODE_DEPUTI, KODE_BIRO = @KODE_BIRO, KODE_BAGIAN = @KODE_BAGIAN, KODE_SUBBAGIAN = @KODE_SUBBAGIAN, KODE_JABATAN = @KODE_JABATAN, KODE_GOLONGAN = @KODE_GOLONGAN, KODE_GRADE = @KODE_GRADE, KODE_ESELON = @KODE_ESELON, KODE_STATUS_PEGAWAI = @KODE_STATUS_PEGAWAI/*, TMT = @TMT, AKTIF = @AKTIF, NON_AKTIF = @NON_AKTIF, TGL_LAHIR = @TGL_LAHIR, KODE_SHIFT = @KODE_SHIFT*/, NOREK_BANK = @NOREK_BANK/*, NIP_BARU = @NIP_BARU*/, NPWP = @NPWP WHERE (NIP = @NIP)"><UpdateParameters>
<asp:Parameter Name="PIN"></asp:Parameter>
<asp:Parameter Name="NAMA"></asp:Parameter>
<asp:Parameter Name="KODE_CABANG"></asp:Parameter>
<asp:Parameter Name="KODE_INSTANSI"></asp:Parameter>
<asp:Parameter Name="KODE_UNIT"></asp:Parameter>
<asp:Parameter Name="KODE_DEPUTI"></asp:Parameter>
<asp:Parameter Name="KODE_BIRO"></asp:Parameter>
<asp:Parameter Name="KODE_BAGIAN"></asp:Parameter>
<asp:Parameter Name="KODE_SUBBAGIAN"></asp:Parameter>
<asp:Parameter Name="KODE_JABATAN"></asp:Parameter>
<asp:Parameter Name="KODE_GOLONGAN"></asp:Parameter>
<asp:Parameter Name="KODE_GRADE"></asp:Parameter>
<asp:Parameter Name="KODE_ESELON"></asp:Parameter>
<asp:Parameter Name="KODE_STATUS_PEGAWAI"></asp:Parameter>
<asp:Parameter Name="NOREK_BANK"></asp:Parameter>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="NPWP"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="PIN"></asp:Parameter>
<asp:Parameter Name="NAMA"></asp:Parameter>
<asp:Parameter Name="KODE_CABANG"></asp:Parameter>
<asp:Parameter Name="KODE_INSTANSI"></asp:Parameter>
<asp:Parameter Name="KODE_UNIT"></asp:Parameter>
<asp:Parameter Name="KODE_DEPUTI"></asp:Parameter>
<asp:Parameter Name="KODE_BIRO"></asp:Parameter>
<asp:Parameter Name="KODE_BAGIAN"></asp:Parameter>
<asp:Parameter Name="KODE_SUBBAGIAN"></asp:Parameter>
<asp:Parameter Name="KODE_JABATAN"></asp:Parameter>
<asp:Parameter Name="KODE_GOLONGAN"></asp:Parameter>
<asp:Parameter Name="KODE_GRADE"></asp:Parameter>
<asp:Parameter Name="KODE_ESELON"></asp:Parameter>
<asp:Parameter Name="KODE_STATUS_PEGAWAI"></asp:Parameter>
<asp:Parameter Name="TMT"></asp:Parameter>
<asp:Parameter Name="AKTIF"></asp:Parameter>
<asp:Parameter Name="NON_AKTIF"></asp:Parameter>
<asp:Parameter Name="TGL_LAHIR"></asp:Parameter>
<asp:Parameter Name="KODE_SHIFT"></asp:Parameter>
<asp:Parameter Name="NOREK_BANK"></asp:Parameter>
<asp:Parameter Name="NIP_BARU"></asp:Parameter>
<asp:Parameter Name="WAKTU_SIMPAN"></asp:Parameter>
<asp:Parameter Name="NPWP"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource><asp:SqlDataSource id="dsDeputi" runat="server" SelectCommand="SELECT [KODE_DEPUTI], [NAMA_DEPUTI] FROM [taDeputi]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource><asp:SqlDataSource id="dsBiroManajemen" runat="server" SelectCommand="SELECT [KODE_BIRO], [NAMA_BIRO] FROM [taBiro]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource><asp:SqlDataSource id="dsBagianManajemen" runat="server" SelectCommand="SELECT [KODE_BAGIAN], [NAMA_BAGIAN] FROM [taBagian]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource><asp:SqlDataSource id="dsSubBagian" runat="server" SelectCommand="SELECT [KODE_SUBBAGIAN], [NAMA_SUBBAGIAN] FROM [taSubbagian]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource> <asp:Label id="lblJmlRecord" runat="server" Visible="False"></asp:Label> <BR /></TD></TR></TBODY></TABLE><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" Drag="True" BackgroundCssClass="modalBackground" PopupControlID="PNL_Lookup" targetcontrolid="lnkLookupTriger"></cc1:ModalPopupExtender> 
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 63%; POSITION: absolute; TOP: 41%" id="PNLProgress" 
                runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsBiro" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_BIRO, NAMA_BIRO, KODE_CABANG FROM q_Biro ORDER BY KODE_BIRO">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsUnit" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_UNIT, NAMA_UNIT FROM taUnit ORDER BY KODE_UNIT"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsJabatan" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_JABATAN], [NAMA_JABATAN] FROM [taJabatan]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsGolongan" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_GOLONGAN], [NAMA_GOLONGAN] FROM [taGolongan]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsGrade" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_GRADE], [NILAI_GRADE] FROM [taGrade]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsEselon" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_ESELON], [NAMA_ESELON] FROM [taEselon]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsStatusPegawai" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_STATUS_PEGAWAI], [NAMA_STATUS_PEGAWAI] FROM [taStatusPegawai]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsShift" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_SHIFT, '[' + KODE_SHIFT + '] ' + NAMA_GROUP AS NAMA_GROUP FROM taPola">
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
    <asp:Panel ID="PNL_Lookup" runat="server" Style="border-right: black 2px solid; padding-right: 20px;
        border-top: black 2px solid; display: none; padding-left: 20px; padding-bottom: 20px;
        border-left: black 2px solid; width: 600px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small"></asp:Label> 
<HR />
<asp:Label id="lblLookupCariPegawai" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblNama %>" Font-Size="Small"></asp:Label> <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan=2><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" OnDataBound="GvLookupPegawai_DataBound" DataKeyNames="NIP" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True"><Columns>
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
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan=2><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" ImageUrl="~/images/exit4_16.png" AlternateText="<%$ Resources:Resource, lblClose %>"></asp:ImageButton> <asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
    <br />
    <asp:Button ID="btnEkspor" runat="server" OnClick="btnEkspor_Click" Text="Ekspor Rekening & NPWP (bulan lalu)" /><br />
                <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False" width="330px"></asp:Label><asp:Label ID="lblerrorEdit" runat="server" Text="<%$ Resources:Resource, salahValidatorTanggal %>"
                    Visible="False" width="566px"></asp:Label>
    &nbsp;
</asp:Content>

