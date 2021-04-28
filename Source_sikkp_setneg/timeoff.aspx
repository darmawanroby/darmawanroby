<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="timeoff.aspx.cs" Inherits="rtwin.timeoff" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR"></asp:ValidationSummary> <asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><DIV id="hideForm" runat="server"><TABLE style="WIDTH: 100%" id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 border=0 runat="server"><TBODY><TR><TD style="WIDTH: 100%"><BR /><TABLE cellPadding=1 width=750 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="lblTglAwal" runat="server" Text="<%$ Resources:lblFrom %>" width="100px"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left><asp:TextBox id="txtFilterItem0" runat="server" width="100px" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem0" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem0" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem0_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/1900">*</asp:CompareValidator> <cc1:CalendarExtender id="cexFilterItem0" runat="server" CssClass="cal_Theme1" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>" PopupButtonID="imgFilterItem0" targetcontrolid="txtFilterItem0">
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem0" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem0"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 50px" vAlign=top align=center><asp:Label id="lblTglAkhir" runat="server" Text="<%$ Resources:lblTo %>"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left><asp:TextBox id="txtFilterItem1" runat="server" width="100px" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem1" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem1" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem1_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/1900">*</asp:CompareValidator><asp:CompareValidator id="valFilterItem1_2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" meta:resourceKey="CompareValTglAkhir" Operator="GreaterThanEqual" Type="Date" ControlToCompare="txtFilterItem0">*</asp:CompareValidator> <cc1:CalendarExtender id="cexFilterItem1" runat="server" CssClass="cal_Theme1" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>" PopupButtonID="imgFilterItem1" targetcontrolid="txtFilterItem1">
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem1" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem1"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 100px" vAlign=top><asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:Button></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:Column0 %>" width="80px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="HEIGHT: 13px" colSpan=4><asp:TextBox id="txtFilterItem2" runat="server" AutoPostBack="True" width="100px"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem3" runat="server" OnSelectedIndexChanged="ddlFilterItem3_DataBound_SelectedChange" AutoPostBack="True" DataSourceID="dsBiro" OnDataBound="ddlFilterItem3_DataBound_SelectedChange" DataTextField="NAMA_DEPUTI" DataValueField="KODE_DEPUTI"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem4" runat="server" DataSourceID="dsBagian" DataTextField="NAMA_BIRO" DataValueField="KODE_BIRO"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblStatusAlasan" runat="server" Text="<%$ Resources:lblStatusAlasan %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem5" runat="server"><asp:ListItem Value="-"></asp:ListItem>
<asp:ListItem Value="1">Disetujui</asp:ListItem>
<asp:ListItem Value="0">Belum Disetujui</asp:ListItem>
</asp:DropDownList>
                &nbsp; &nbsp;&nbsp;
                <asp:CheckBox ID="chkDuplikasi" runat="server" Text="Cek Duplikasi dengan ijin harian" /></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" vAlign=top rowSpan=2><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgbtnAdd" onclick="ImgBtnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp; <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="GvAlasan" runat="server" DataSourceID="dsAlasan" OnDataBound="GvAlasan_DataBound" OnRowCommand="GvAlasan_RowCommand" OnRowEditing="GvAlasan_RowEditing" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NIP,PIN,TGL_IJIN" EmptyDataText="<%$ Resources:lblEmptyData %>" OnRowDataBound="GvAlasan_RowDataBound">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:BoundField ReadOnly="True" SortExpression="NIP" HeaderText="NIP">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
</asp:BoundField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column1 %>">
<HeaderStyle Width="140px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_IJIN" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TGL_IJIN","{0:d}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_AWAL_IJIN" HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("JAM_AWAL_IJIN","{0:HH:mm}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_AKHIR_IJIN" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("JAM_AKHIR_IJIN","{0:HH:mm}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_IJIN" HeaderText="<%$ Resources:Column5 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("KET_IJIN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="ALASAN_IJIN" HeaderText="<%$ Resources:Column6 %>"><ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("ALASAN_IJIN") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_IJIN_DINAS" HeaderText="<%$ Resources:Column7 %>"><ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# BIND("KET_IJIN_DINAS") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="STATUS_IJIN" HeaderText="<%$ Resources:Column8 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
<ItemTemplate>
<asp:CheckBox id="chkSelect" runat="server" Checked='<%# BIND("STATUS_IJIN") %>'></asp:CheckBox> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column9 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column10 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" PopupControlID="PNLKonfirmasi" CancelControlID="btnCancel" OkControlID="btnOK" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView><asp:SqlDataSource id="dsAlasan" runat="server" SelectCommand="SELECT q_IjinJam.NIP, q_IjinJam.NAMA, q_IjinJam.TGL_IJIN, q_IjinJam.JAM_AWAL_IJIN, q_IjinJam.JAM_AKHIR_IJIN, q_IjinJam.KODE_IJIN, q_IjinJam.KET_IJIN, q_IjinJam.ALASAN_IJIN, q_IjinJam.IJIN_DINAS, q_IjinJam.STATUS_IJIN, CASE WHEN IJIN_DINAS = 1 THEN 'Ya' ELSE 'Tidak' END AS KET_IJIN_DINAS, PIN FROM q_IjinJam" ConnectionString="<%$ ConnectionStrings:strCn %>" OnInserted="dsAlasanEdit_Inserted" OnInserting="dsAlasanEdit_Inserting" OnUpdated="dsAlasanEdit_Updated" OnUpdating="dsAlasanEdit_Updating" DeleteCommand="DELETE FROM taIjinJam WHERE (NIP = @NIP) AND (TGL_IJIN = @TGL_IJIN)" OnDeleted="dsAlasan_Deleted" InsertCommand="INSERT INTO taIjinJam(NIP, TGL_IJIN, JAM_AWAL_IJIN, JAM_AKHIR_IJIN, KODE_IJIN, ALASAN_IJIN, IJIN_DINAS, STATUS_IJIN) VALUES (@NIP, @TGL_IJIN, @JAM_AWAL_IJIN, @JAM_AKHIR_IJIN, @KODE_IJIN, @ALASAN_IJIN, @IJIN_DINAS, @STATUS_IJIN)" UpdateCommand="UPDATE taIjinJam SET JAM_AWAL_IJIN = @JAM_AWAL_IJIN, JAM_AKHIR_IJIN = @JAM_AKHIR_IJIN, KODE_IJIN = @KODE_IJIN, ALASAN_IJIN = @ALASAN_IJIN, IJIN_DINAS = @IJIN_DINAS, STATUS_IJIN = @STATUS_IJIN WHERE (NIP = @NIP) AND (TGL_IJIN = @TGL_IJIN)"><DeleteParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_IJIN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="JAM_AWAL_IJIN"></asp:Parameter>
<asp:Parameter Name="JAM_AKHIR_IJIN"></asp:Parameter>
<asp:Parameter Name="KODE_IJIN"></asp:Parameter>
<asp:Parameter Name="ALASAN_IJIN"></asp:Parameter>
<asp:Parameter Name="IJIN_DINAS"></asp:Parameter>
<asp:Parameter Name="STATUS_IJIN"></asp:Parameter>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_IJIN"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter DefaultValue="" Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_IJIN"></asp:Parameter>
<asp:Parameter Name="JAM_AWAL_IJIN"></asp:Parameter>
<asp:Parameter Name="JAM_AKHIR_IJIN"></asp:Parameter>
<asp:Parameter Name="KODE_IJIN"></asp:Parameter>
<asp:Parameter Name="ALASAN_IJIN"></asp:Parameter>
<asp:Parameter Name="IJIN_DINAS"></asp:Parameter>
<asp:Parameter Name="STATUS_IJIN"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource><asp:SqlDataSource id="dsBagian" runat="server" SelectCommand="SELECT KODE_BIRO, NAMA_BIRO, KODE_CABANG, KODE_DEPUTI FROM q_BIRO ORDER BY KODE_BIRO" ConnectionString="<%$ ConnectionStrings:strCn %>">
                </asp:SqlDataSource> <asp:FormView id="FvAlasan" runat="server" CssClass="FormView" DataSourceID="dsAlasan" OnDataBound="FvAlasan_DataBound" DataKeyNames="NIP,PIN,TGL_IJIN" OnItemCommand="FvAlasan_ItemCommand"><EditItemTemplate>
<TABLE style="WIDTH: 500px" cellPadding=1><TBODY><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNip" runat="server" Text="<%$ Resources:Column0 %>"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem0FormView" runat="server" Text='<%# Bind("NIP") %>'></asp:Label><asp:Label id="lblItem0_FormView" runat="server" Text='<%# Bind("PIN") %>'></asp:Label></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNama" runat="server" Text="<%$ Resources:Column1 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem1FormView" runat="server" Text='<%# Eval("NAMA") %>'></asp:Label></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblTglMasuk" runat="server" Text="<%$ Resources:Column2 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem2FormView" runat="server" Text='<%# Bind("TGL_IJIN", "{0:d}") %>'></asp:Label>&nbsp;&nbsp;</TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblKetIjin" runat="server" Text="<%$ Resources:Column5 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:DropDownList id="ddlItem5FormView" runat="server" OnSelectedIndexChanged="ddlItem5FormView_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsIjin" OnDataBound="ddlItem5FormView_SelectedIndexChanged" DataTextField="KET_IJIN" DataValueField="KODE_IJIN" SelectedValue='<%# BIND("KODE_IJIN") %>'></asp:DropDownList></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblJamMasuk" runat="server" Text="<%$ Resources:Column3 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem3FormView" runat="server" Text='<%# Bind("JAM_AWAL_IJIN","{0:HH:mm}") %>' EnableViewState="False" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valItem3_1FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtItem3FormView" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" Mask="99:99" MaskType="Time" TargetControlID="txtItem3FormView"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblJamKeluar" runat="server" Text="<%$ Resources:Column4 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem4FormView" runat="server" Text='<%# Bind("JAM_AKHIR_IJIN","{0:HH:mm}") %>' EnableViewState="False" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valItem4FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem4FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valItem4_1FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtItem4FormView" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <asp:CheckBox id="cbGantiHari" runat="server" Text="<%$ Resources:cbGantiHari %>"></asp:CheckBox> <cc1:MaskedEditExtender id="mexItem4FormView" runat="server" Mask="99:99" MaskType="Time" TargetControlID="txtItem4FormView"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblAlasanIjin" runat="server" Text="<%$ Resources:Column6 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem6FormView" runat="server" Text='<%# Bind("ALASAN_IJIN") %>' Columns="25" MaxLength="25"></asp:TextBox></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblIjinDinas" runat="server" Text="<%$ Resources:Column7 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:CheckBox id="chkItem7FormView" runat="server" Checked='<%# Bind("IJIN_DINAS") %>'></asp:CheckBox></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblStatusIjin" runat="server" Text="<%$ Resources:Column8 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:CheckBox id="chkItem8FormView" runat="server" Text="<%$ Resources:lblDisetujui %>" Checked='<%# Bind("STATUS_IJIN") %>'></asp:CheckBox></TD></TR><TR><TD colSpan=2>&nbsp;</TD></TR><TR><TD colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgUpdate" runat="server" ImageUrl="~/images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkUpdate" runat="server" Text="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:LinkButton>&nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Edit"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Edit"></asp:LinkButton></TD></TR></TBODY></TABLE>&nbsp;&nbsp; 
</EditItemTemplate>
<InsertItemTemplate>
<TABLE style="WIDTH: 500px" cellPadding=1><TBODY><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNip" runat="server" Text="<%$ Resources:Column0 %>" width="50px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem0FormView" runat="server" AutoPostBack="True" width="100px" MaxLength="25" OnTextChanged="txtItem0FormView_TextChanged"></asp:TextBox> <asp:LinkButton id="lnkItem0FormView" onclick="lnkItem0FormView_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton> <asp:RequiredFieldValidator id="valItem0FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem0FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNama" runat="server" Text="<%$ Resources:Column1 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem1FormView" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblTglMasuk" runat="server" Text="<%$ Resources:Column2 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem2FormView" runat="server" Text='<%# Bind("TGL_IJIN", "{0:d}") %>' width="100px" Columns="10" MaxLength="10"></asp:TextBox> <asp:ImageButton id="imgItem2FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valItem2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem2FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem2_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/1900">*</asp:CompareValidator><asp:RangeValidator id="CompareValTglAdd" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:tglval %>" ControlToValidate="txtItem2FormView" SetFocusOnError="True" EnableClientScript="True" Type="Date" MinimumValue="1/1/1900" MaximumValue="1/1/9000">*</asp:RangeValidator> <cc1:CalendarExtender id="cexItem2FormView" runat="server" CssClass="cal_Theme1" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>" PopupButtonID="imgItem2FormView" targetcontrolid="txtItem2FormView">
                                    </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem2FormView" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtItem2FormView"></cc1:MaskedEditExtender> </TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblKetIjin" runat="server" Text="<%$ Resources:Column5 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:DropDownList id="ddlItem5FormView" runat="server" OnSelectedIndexChanged="ddlItem5FormView_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsIjin" OnDataBound="ddlItem5FormView_SelectedIndexChanged" DataTextField="KET_IJIN" DataValueField="KODE_IJIN" SelectedValue='<%# BIND("KODE_IJIN") %>'></asp:DropDownList></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblJamMasuk" runat="server" Text="<%$ Resources:Column3 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem3FormView" runat="server" EnableViewState="False" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valItem3_1FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtItem3FormView" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" Mask="99:99" MaskType="Time" TargetControlID="txtItem3FormView"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblJamKeluar" runat="server" Text="<%$ Resources:Column4 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem4FormView" runat="server" EnableViewState="False" Columns="5" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="valItem4FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem4FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valItem4_1FormView" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtItem4FormView" SetFocusOnError="True" EnableClientScript="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <asp:CheckBox id="cbGantiHari" runat="server" Text="<%$ Resources:cbGantiHari %>"></asp:CheckBox> <cc1:MaskedEditExtender id="mexItem4FormView" runat="server" Mask="99:99" MaskType="Time" TargetControlID="txtItem4FormView"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblAlasanIjin" runat="server" Text="<%$ Resources:Column6 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem6FormView" runat="server" Text='<%# Bind("ALASAN_IJIN") %>' Columns="25" MaxLength="25"></asp:TextBox></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblIjinDinas" runat="server" Text="<%$ Resources:Column7 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:CheckBox id="chkItem7FormView" runat="server" Checked='<%# Bind("IJIN_DINAS") %>'></asp:CheckBox></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblStatusIjin" runat="server" Text="<%$ Resources:Column8 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:CheckBox id="chkItem8FormView" runat="server" Text="<%$ Resources:lblDisetujui %>" Checked='<%# Bind("STATUS_IJIN") %>'></asp:CheckBox></TD></TR><TR><TD colSpan=2>&nbsp;</TD></TR><TR><TD colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgInsert" runat="server" ImageUrl="~/images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton> <asp:LinkButton id="lnkInsert" runat="server" Text="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:LinkButton> &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton> <asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Insert"></asp:LinkButton></TD></TR></TBODY></TABLE>&nbsp; 
</InsertItemTemplate>
</asp:FormView><BR /><asp:Button id="btnSimpan" onclick="btnSimpan_Click" runat="server" CssClass="lblStandar" Text="<%$ Resources:ImgUpdate %>"></asp:Button>&nbsp;<asp:CheckBox id="chkCheckOrClearAll" runat="server" Text="<%$ Resources:Resource, chkCheckOrClearAll %>" AutoPostBack="True" OnCheckedChanged="chkCheckOrClearAll_CheckedChanged"></asp:CheckBox>&nbsp;&nbsp; <BR /><BR /><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="PNL_Lookup"></cc1:ModalPopupExtender></TD></TR><TR></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tbody><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsBiro" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_DEPUTI, NAMA_DEPUTI, KODE_CABANG FROM q_DEPUTI ORDER BY KODE_DEPUTI">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsIjin" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_IJIN, '[' + KODE_IJIN + '] ' + KET_IJIN AS KET_IJIN FROM taIjin WHERE (KODE_TIDAK_HADIR >= '2') AND (KODE_TIDAK_HADIR <= '5') ORDER BY KODE_IJIN">
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
                    Visible="False" width="259px"></asp:Label><asp:Label ID="lblJamSalah2" runat="server" Text="<%$ Resources:lblJamSalah %>"
                    Visible="False" width="320px"></asp:Label><asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label>
   
</asp:Content>



