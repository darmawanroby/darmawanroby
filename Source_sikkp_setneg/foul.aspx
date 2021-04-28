<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="foul.aspx.cs" Inherits="rtwin.foul" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><DIV id="hideForm" runat="server"><TABLE style="WIDTH: 100%" id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 border=0 runat="server"><TBODY><TR><TD style="WIDTH: 100%"><BR /><TABLE cellPadding=1 width=750 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="lblTglAwal" runat="server" Text="<%$ Resources:Label1 %>" width="100px"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left>
    <asp:DropDownList ID="ddlTahun" runat="server">
    </asp:DropDownList></TD><TD style="WIDTH: 50px" vAlign=top align=center></TD><TD style="WIDTH: 200px" vAlign=top align=left>
                            &nbsp; &nbsp;
                        </TD><TD style="WIDTH: 100px" vAlign=top><asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:Button></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:Column0 %>" width="80px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="HEIGHT: 13px" colSpan=4><asp:TextBox id="txtFilterItem2" runat="server" Text='<%# Bind("NIP") %>' AutoPostBack="True" width="100px"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem3" runat="server" OnSelectedIndexChanged="ddlFilterItem3_DataBound_SelectedChange" AutoPostBack="True" DataSourceID="dsBiro" DataValueField="KODE_DEPUTI" DataTextField="NAMA_DEPUTI" OnDataBound="ddlFilterItem3_DataBound_SelectedChange"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem4" runat="server" DataSourceID="dsBagian" DataValueField="KODE_BIRO" DataTextField="NAMA_BIRO"></asp:DropDownList></TD></TR>
    <tr>
        <td>
            <asp:Label ID="lblJmlMangkir" runat="server" Text="<%$ Resources:lblJmlMangkir %>"></asp:Label></td>
        <td colspan="4">
            <asp:CheckBox ID="cbFilterItem5" runat="server" />
            <asp:DropDownList id="ddlFilterItem5" runat="server" DataSourceID="dsPotongan" DataValueField="KODE_POTONGAN" DataTextField="RANGE_MANGKIR">
        </asp:DropDownList><asp:SqlDataSource ID="dsPotongan" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
            SelectCommand="SELECT KODE_POTONGAN, CAST(BATAS_MIN_MANGKIR AS VARCHAR(2))+ CASE WHEN BATAS_MIN_MANGKIR = BATAS_MAX_MANGKIR THEN '' ELSE ' - ' + CAST(BATAS_MAX_MANGKIR AS VARCHAR(2)) END AS RANGE_MANGKIR&#13;&#10;FROM taPotongan&#13;&#10;WHERE NOT BATAS_MIN_MANGKIR IS NULL">
        </asp:SqlDataSource>
        </td>
    </tr>
</TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" vAlign=top rowSpan=2><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgbtnAdd" onclick="ImgBtnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp; <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton>&nbsp;
    <asp:HyperLink ID="hlEdit" runat="server" NavigateUrl="~/punishment.aspx">Edit</asp:HyperLink><BR /><BR /><asp:GridView id="GvPunishment" runat="server" DataSourceID="dsPunishment" OnDataBound="GvPunishment_DataBound" OnRowDataBound="GvPunishment_RowDataBound" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="PIN,NIP,TGL_AWAL,KODE_POTONGAN" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GvPunishment_RowEditing" OnRowCommand="GvPunishment_RowCommand">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
    <asp:TemplateField HeaderText="NIP" SortExpression="NIP">
        <EditItemTemplate>
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </EditItemTemplate>
        <HeaderStyle HorizontalAlign="Center" Width="100px" />
        <ItemTemplate>
            <asp:LinkButton ID="lnkCol0Item" runat="server" CommandName="Show" Text='<%# Eval("PIN") %>'></asp:LinkButton>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column1 %>">
<HeaderStyle Width="140px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JML_MANGKIR" HeaderText="<%$ Resources:Column2a %>"><EditItemTemplate>
                                &nbsp;
                            
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("JML_MANGKIR") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_POTONGAN_REKOMENDASI" HeaderText="<%$ Resources:Column3a %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("KODE_POTONGAN_REKOMENDASI") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_POTONGAN" HeaderText="<%$ Resources:Column4a %>"><EditItemTemplate>
                                &nbsp;
                            
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("KODE_POTONGAN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_PENETAPAN" HeaderText="<%$ Resources:Column5 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("TGL_PENETAPAN","{0:d}") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="DOKUMEN_DISIPLIN" HeaderText="<%$ Resources:Column6 %>">
<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("DOKUMEN_DISIPLIN") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="TGL_AWAL">
        <EditItemTemplate>
            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TGL_AWAL") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol7Item" runat="server" Text='<%# Bind("TGL_AWAL") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
    <asp:TemplateField HeaderText="LAMA_POTONGAN">
        <EditItemTemplate>
            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("LAMA_POTONGAN") %>'></asp:TextBox>
        </EditItemTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol11Item" runat="server" Text='<%# Bind("LAMA_POTONGAN") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column7 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column8 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:ImgSisip %>">
                            <HeaderStyle Width="50px" HorizontalAlign="Center"/>
                            <ItemTemplate>
                                <asp:ImageButton ID="imgSisip" runat="server" CausesValidation="False" CommandName="TambahPelanggaran"
                                    ImageUrl="~/images/sisip.png" AlternateText="<%$ Resources:ImgSisip %>" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
 </Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsPunishment" runat="server" SelectCommand="SELECT NIP, NAMA, JML_MANGKIR, KODE_POTONGAN, KODE_POTONGAN_REKOMENDASI, TGL_AWAL, TGL_AKHIR, TGL_PENETAPAN, DOKUMEN_DISIPLIN, LAMA_POTONGAN, PIN FROM q_Pelanggaran" ConnectionString="<%$ ConnectionStrings:strCn %>" UpdateCommand="UPDATE taHukumanDisiplin SET TGL_AKHIR = @TGL_AKHIR, KODE_POTONGAN = @KODE_POTONGAN, TGL_PENETAPAN = @TGL_PENETAPAN, DOKUMEN_DISIPLIN = @DOKUMEN_DISIPLIN WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" InsertCommand="INSERT INTO taHukumanDisiplin(NIP, TGL_AWAL, TGL_AKHIR, KODE_POTONGAN, TGL_PENETAPAN, DOKUMEN_DISIPLIN) VALUES (@NIP, @TGL_AWAL, @TGL_AKHIR, @KODE_POTONGAN, @TGL_PENETAPAN, @DOKUMEN_DISIPLIN)" OnDeleted="dsPunishment_Deleted" DeleteCommand="DELETE FROM taHukumanDisiplin WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" OnUpdating="dsPunishmentEdit_Updating" OnUpdated="dsPunishmentEdit_Updated" OnInserting="dsPunishmentEdit_Inserting" OnInserted="dsPunishmentEdit_Inserted"><DeleteParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_AWAL"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="TGL_AKHIR"></asp:Parameter>
<asp:Parameter Name="KODE_POTONGAN"></asp:Parameter>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_AWAL"></asp:Parameter>
<asp:Parameter Name="TGL_PENETAPAN"></asp:Parameter>
<asp:Parameter Name="DOKUMEN_DISIPLIN"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter DefaultValue="" Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_AWAL"></asp:Parameter>
<asp:Parameter Name="TGL_AKHIR"></asp:Parameter>
<asp:Parameter Name="KODE_POTONGAN"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource><asp:SqlDataSource id="dsBagian" runat="server" SelectCommand="SELECT KODE_BIRO, NAMA_BIRO, KODE_CABANG, KODE_DEPUTI FROM q_BIRO ORDER BY KODE_BIRO" ConnectionString="<%$ ConnectionStrings:strCn %>">
                </asp:SqlDataSource> <asp:FormView id="FvPunishment" runat="server" CssClass="FormView" DataSourceID="dsPunishment" OnDataBound="FvPunishment_DataBound" DataKeyNames="NIP,PIN,TGL_AWAL" OnItemCommand="FvPunishment_ItemCommand"><EditItemTemplate>
<TABLE style="WIDTH: 500px" cellPadding=1 border=0><TBODY><TR><TD style="WIDTH: 150px; HEIGHT: 16px" vAlign=top>&nbsp;<asp:Label id="lblNip" runat="server" Text="<%$ Resources:Column0 %>"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="WIDTH: 350px; HEIGHT: 16px"><asp:Label id="lblItem0FormView" runat="server" Text='<%# Bind("NIP") %>'></asp:Label><asp:Label id="lblItem0_FormView" runat="server" Text='<%# Bind("PIN") %>'></asp:Label></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblNama" runat="server" Text="<%$ Resources:Column1 %>"></asp:Label></TD><TD style="WIDTH: 350px"><asp:Label id="lblItem1FormView" runat="server" Text='<%# Eval("NAMA") %>'></asp:Label></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblTglMasuk" runat="server" Text="<%$ Resources:Column2 %>"></asp:Label></TD><TD style="WIDTH: 350px"><asp:Label id="lblItem2FormView" runat="server" Text='<%# Bind("TGL_AWAL", "{0:d}") %>'></asp:Label></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblJamMasuk" runat="server" Text="<%$ Resources:Column3 %>"></asp:Label></TD><TD style="WIDTH: 350px"><asp:TextBox id="txtItem3FormView" runat="server" Text='<%# Bind("TGL_AKHIR", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem3FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem3_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valItem3_2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare='<%# Eval("TGL_AWAL","{0:d}") %>' Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir">*</asp:CompareValidator> <cc1:CalendarExtender id="cexItem3FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem3FormView" PopupButtonID="imgItem3FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" TargetControlID="txtItem3FormView" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblJamKeluar" runat="server" Text="<%$ Resources:Column4 %>"></asp:Label></TD><TD style="WIDTH: 350px"><asp:DropDownList id="ddlItem4FormView" runat="server" DataSourceID="dsPola" DataValueField="KODE_POTONGAN" DataTextField="Keterangan" SelectedValue='<%# Bind("KODE_POTONGAN") %>'></asp:DropDownList> </TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="Label3" runat="server" Text="<%$ Resources:Column5 %>"></asp:Label></TD><TD style="WIDTH: 350px"><asp:TextBox id="txtItem5FormView" runat="server" Text='<%# Bind("TGL_PENETAPAN", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem5FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem5FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem5_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><cc1:CalendarExtender id="cexItem5FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem5FormView" PopupButtonID="imgItem5FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem5FormView" runat="server" TargetControlID="txtItem5FormView" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="Label4" runat="server" Text="<%$ Resources:Column6 %>"></asp:Label></TD><TD style="WIDTH: 350px"><asp:TextBox id="txtItem6FormView" runat="server" Text='<%# Bind("DOKUMEN_DISIPLIN") %>' TextMode="MultiLine" MaxLength="100" Columns="30" Rows="3"></asp:TextBox></TD></TR><TR><TD vAlign=top align=left colSpan=2></TD></TR><TR><TD vAlign=top align=left colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgUpdate" runat="server" ImageUrl="~/images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton> <asp:LinkButton id="lnkUpdate" runat="server" Text="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:LinkButton> &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Edit"></asp:ImageButton> <asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Edit"></asp:LinkButton></TD></TR></TBODY></TABLE>&nbsp; 
</EditItemTemplate>
<InsertItemTemplate>
<TABLE style="WIDTH: 500px" cellPadding=1><TBODY><TR><TD style="WIDTH: 150px"><asp:Label id="lblNip" runat="server" Text="<%$ Resources:Column0 %>" width="50px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem0FormView" runat="server" AutoPostBack="True" width="100px" MaxLength="25" OnTextChanged="txtItem0FormView_TextChanged"></asp:TextBox> <asp:LinkButton id="lnkItem0FormView" onclick="lnkItem0FormView_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton> <asp:RequiredFieldValidator id="valItem0FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem0FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD><asp:Label id="lblNama" runat="server" Text="<%$ Resources:Column1 %>"></asp:Label></TD><TD vAlign=top><asp:Label id="lblItem1FormView" runat="server"></asp:Label></TD></TR><TR><TD><asp:Label id="lblTglMasuk" runat="server" Text="<%$ Resources:Column2 %>"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem2FormView" runat="server" Text='<%# Bind("TGL_AWAL", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox> <asp:ImageButton id="imgItem2FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valItem2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem2_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:RangeValidator id="CompareValTglAdd" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:tglval %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" SetFocusOnError="True" Type="Date" MinimumValue="1/1/1900" MaximumValue="1/1/9000">*</asp:RangeValidator> <cc1:CalendarExtender id="cexItem2FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem2FormView" PopupButtonID="imgItem2FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True">
                                    </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem2FormView" runat="server" TargetControlID="txtItem2FormView" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="lblJamMasuk" runat="server" Text="<%$ Resources:Column3 %>"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem3FormView" runat="server" Text='<%# Bind("TGL_AKHIR", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>
                                        <asp:ImageButton id="imgItem3FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>
                                        <asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem3_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valItem3_2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" ControlToCompare="txtItem2FormView">*</asp:CompareValidator> <cc1:CalendarExtender id="cexItem3FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem3FormView" PopupButtonID="imgItem3FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" TargetControlID="txtItem3FormView" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="lblJamKeluar" runat="server" Text="<%$ Resources:Column4 %>"></asp:Label></TD><TD vAlign=top><asp:DropDownList id="ddlItem4FormView" runat="server" DataSourceID="dsPola" DataValueField="KODE_POTONGAN" DataTextField="Keterangan" SelectedValue='<%# Bind("KODE_POTONGAN") %>'></asp:DropDownList></TD></TR><TR><TD><asp:Label id="Label3" runat="server" Text="<%$ Resources:Column5 %>"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem5FormView" runat="server" Text='<%# Bind("TGL_PENETAPAN", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>
                                        <asp:ImageButton id="imgItem5FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>
                                        <asp:RequiredFieldValidator id="valItem5FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem5_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><cc1:CalendarExtender id="cexItem5FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem5FormView" PopupButtonID="imgItem5FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem5FormView" runat="server" TargetControlID="txtItem5FormView" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR><TD vAlign=top><asp:Label id="Label4" runat="server" Text="<%$ Resources:Column6 %>"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem6FormView" runat="server" Text='<%# Bind("DOKUMEN_DISIPLIN") %>' TextMode="MultiLine" MaxLength="100" Columns="30" Rows="3"></asp:TextBox></TD></TR><TR><TD colSpan=2></TD></TR><TR><TD colSpan=2><asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgInsert" runat="server" ImageUrl="~/images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton> <asp:LinkButton id="lnkInsert" runat="server" Text="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:LinkButton> <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton> <asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Insert"></asp:LinkButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> &nbsp;&nbsp; &nbsp;
    <BR />
    <asp:Label ID="lblTitleRincianMangkir" runat="server" Font-Bold="True" Text="Rincian Tanggal Tidak Hadir"
        Visible="False"></asp:Label><asp:GridView ID="gvMangkir" runat="server" AutoGenerateColumns="False"
            DataSourceID="dsMangkir" Visible="False" Width="109px">
            <Columns>
                <asp:TemplateField HeaderText="Tgl.Tidak Hadir" SortExpression="TGL_MASUK">
                    <ItemStyle HorizontalAlign="Center" />
                    <HeaderStyle Width="100px" />
                    <ItemTemplate>
                        <asp:Label ID="lblCol0Item" runat="server" Text='<%# Bind("TGL_MASUK", "{0:d}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <HeaderStyle ForeColor="Yellow" HorizontalAlign="Center" />
        </asp:GridView>
    <asp:SqlDataSource ID="dsMangkir" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [TGL_MASUK] FROM [q_AbsenHarianDetil]"></asp:SqlDataSource>
    <br />
    <asp:Label ID="lblTitleAkumulasiMangkir" runat="server" Font-Bold="True" Text="Konversi Akumulasi Terlambat & Cepat Pulang menjadi Mangkir"
        Visible="False"></asp:Label>
    <br />
    <asp:GridView ID="gvAkumulasiMangkir" runat="server" AutoGenerateColumns="False"
            DataSourceID="dsAkumulasiMangkir" Visible="False" Width="109px">
        <Columns>
            <asp:TemplateField HeaderText="Akumulasi Lambat &amp; Cepat Pulang" SortExpression="JML_JAM_LAMBAT_CPTPLG">
                <ItemStyle HorizontalAlign="Center" />
                <HeaderStyle Width="100px" />
                <ItemTemplate>
                    <asp:Label ID="lblCol0Item" runat="server" Text='<%# Bind("JML_JAM_LAMBAT_CPTPLG") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Konversi Mangkir" SortExpression="KONVERSI_MANGKIR">
                <ItemTemplate>
                    <asp:Label ID="lblCol1Item" runat="server" Text='<%# Bind("KONVERSI_MANGKIR") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <HeaderStyle ForeColor="Yellow" HorizontalAlign="Center" />
    </asp:GridView>
    <asp:SqlDataSource ID="dsAkumulasiMangkir" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [JML_JAM_LAMBAT_CPTPLG],[KONVERSI_MANGKIR] FROM [q_LambatCepatPulang]">
    </asp:SqlDataSource>
    <BR /><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender>
    <a href="foul2.aspx">Akumulasi Terlambat &amp; Cepat Pulang</a></TD></TR><TR></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsBiro" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_DEPUTI, NAMA_DEPUTI, KODE_CABANG FROM q_DEPUTI ORDER BY KODE_DEPUTI">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsPola" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_POTONGAN, '[' + KODE_POTONGAN + '] : ' + KET_POTONGAN AS Keterangan FROM taPotongan">
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
                <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False" width="330px"></asp:Label><asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>"
                    Visible="False" width="259px"></asp:Label><asp:Label ID="lblWrongDate" runat="server" Text="<%$ Resources:Resource, lblWrongDate %>"
                    Visible="False" width="320px"></asp:Label><asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label>
   
</asp:Content>



