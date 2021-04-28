<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="punishment.aspx.cs" Inherits="rtwin.change_shift" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><DIV id="hideForm" runat="server"><TABLE style="WIDTH: 100%" id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 border=0 runat="server"><TBODY><TR><TD style="WIDTH: 100%"><BR /><TABLE cellPadding=1 width=750 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="lblTglAwal" runat="server" Text="<%$ Resources:Label1 %>" width="100px"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left><asp:TextBox id="txtFilterItem0" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem0" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem0_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator> <cc1:CalendarExtender id="cexFilterItem0" runat="server" CssClass="cal_Theme1" targetcontrolid="txtFilterItem0" PopupButtonID="imgFilterItem0" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True">
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem0" runat="server" TargetControlID="txtFilterItem0" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w394"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 50px" vAlign=top align=center><asp:Label id="lblTglAkhir" runat="server" Text="<%$ Resources:Label2 %>"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left><asp:TextBox id="txtFilterItem1" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem1" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem1_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valFilterItem1_2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" ControlToCompare="txtFilterItem0">*</asp:CompareValidator> <cc1:CalendarExtender id="cexFilterItem1" runat="server" CssClass="cal_Theme1" targetcontrolid="txtFilterItem1" PopupButtonID="imgFilterItem1" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True">
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem1" runat="server" TargetControlID="txtFilterItem1" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w395"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 100px" vAlign=top><asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:Button></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:Column0 %>" width="80px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN" __designer:wfdid="w83"></asp:Label></TD><TD style="HEIGHT: 13px" colSpan=4><asp:TextBox id="txtFilterItem2" runat="server" Text='<%# Bind("NIP") %>' AutoPostBack="True" width="100px" __designer:wfdid="w216"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False" __designer:wfdid="w217">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem3" runat="server" OnSelectedIndexChanged="ddlFilterItem3_DataBound_SelectedChange" AutoPostBack="True" DataSourceID="dsBiro" __designer:wfdid="w218" DataValueField="KODE_DEPUTI" DataTextField="NAMA_DEPUTI" OnDataBound="ddlFilterItem3_DataBound_SelectedChange"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem4" runat="server" DataSourceID="dsBagian" __designer:wfdid="w219" DataValueField="KODE_BIRO" DataTextField="NAMA_BIRO"></asp:DropDownList></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" vAlign=top rowSpan=2><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgbtnAdd" onclick="ImgBtnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp; <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="GvPunishment" runat="server" DataSourceID="dsPunishment" OnDataBound="GvPunishment_DataBound" OnRowDataBound="GvPunishment_RowDataBound" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="NIP,PIN,TGL_AWAL" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GvPunishment_RowEditing">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:BoundField ReadOnly="True" SortExpression="NIP" HeaderText="NIP">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
</asp:BoundField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column1 %>">
<HeaderStyle Width="140px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA") %>' __designer:wfdid="w153"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_AWAL" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
                                &nbsp;
                            
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TGL_AWAL","{0:d}") %>' __designer:wfdid="w154"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_AKHIR" HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("TGL_AKHIR","{0:d}") %>' __designer:wfdid="w155"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_POTONGAN" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
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
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("TGL_PENETAPAN","{0:d}") %>' __designer:wfdid="w228"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="DOKUMEN_DISIPLIN" HeaderText="<%$ Resources:Column6 %>">
<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("DOKUMEN_DISIPLIN") %>' __designer:wfdid="w231"></asp:Label>
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
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsPunishment" runat="server" SelectCommand="SELECT NIP, NAMA, TGL_AWAL, TGL_AKHIR, KODE_POTONGAN, TGL_PENETAPAN, DOKUMEN_DISIPLIN, PIN FROM q_HukumanDisiplin" ConnectionString="<%$ ConnectionStrings:strCn %>" UpdateCommand="UPDATE taHukumanDisiplin SET TGL_AKHIR = @TGL_AKHIR, KODE_POTONGAN = @KODE_POTONGAN, TGL_PENETAPAN = @TGL_PENETAPAN, DOKUMEN_DISIPLIN = @DOKUMEN_DISIPLIN WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" InsertCommand="INSERT INTO taHukumanDisiplin(NIP, TGL_AWAL, TGL_AKHIR, KODE_POTONGAN, TGL_PENETAPAN, DOKUMEN_DISIPLIN) VALUES (@NIP, @TGL_AWAL, @TGL_AKHIR, @KODE_POTONGAN, @TGL_PENETAPAN, @DOKUMEN_DISIPLIN)" OnDeleted="dsPunishment_Deleted" DeleteCommand="DELETE FROM taHukumanDisiplin WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" OnUpdating="dsPunishmentEdit_Updating" OnUpdated="dsPunishmentEdit_Updated" OnInserting="dsPunishmentEdit_Inserting" OnInserted="dsPunishmentEdit_Inserted"><DeleteParameters>
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
<TABLE style="WIDTH: 500px" cellPadding=1 border=0><TBODY><TR><TD style="WIDTH: 150px; HEIGHT: 16px" vAlign=top>&nbsp;<asp:Label id="lblNip" runat="server" Text="<%$ Resources:Column0 %>" __designer:wfdid="w122"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN" __designer:wfdid="w151"></asp:Label></TD><TD style="WIDTH: 350px; HEIGHT: 16px"><asp:Label id="lblItem0FormView" runat="server" Text='<%# Bind("NIP") %>' __designer:wfdid="w123"></asp:Label><asp:Label id="lblItem0_FormView" runat="server" Text='<%# Bind("PIN") %>' __designer:wfdid="w123"></asp:Label></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblNama" runat="server" Text="<%$ Resources:Column1 %>" __designer:wfdid="w124"></asp:Label></TD><TD style="WIDTH: 350px"><asp:Label id="lblItem1FormView" runat="server" Text='<%# Eval("NAMA") %>' __designer:wfdid="w125"></asp:Label></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblTglMasuk" runat="server" Text="<%$ Resources:Column2 %>" __designer:wfdid="w126"></asp:Label></TD><TD style="WIDTH: 350px"><asp:Label id="lblItem2FormView" runat="server" Text='<%# Bind("TGL_AWAL", "{0:d}") %>' __designer:wfdid="w127"></asp:Label></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblJamMasuk" runat="server" Text="<%$ Resources:Column3 %>" __designer:wfdid="w128"></asp:Label></TD><TD style="WIDTH: 350px"><asp:TextBox id="txtItem3FormView" runat="server" Text='<%# Bind("TGL_AKHIR", "{0:d}") %>' width="100px" MaxLength="10" Columns="10" __designer:wfdid="w129"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem3FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w130"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w131">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem3_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal" __designer:wfdid="w132">*</asp:CompareValidator><asp:CompareValidator id="valItem3_2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare='<%# Eval("TGL_AWAL","{0:d}") %>' Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" __designer:wfdid="w133">*</asp:CompareValidator> <cc1:CalendarExtender id="cexItem3FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem3FormView" PopupButtonID="imgItem3FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" __designer:wfdid="w134"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" TargetControlID="txtItem3FormView" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w135"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="lblJamKeluar" runat="server" Text="<%$ Resources:Column4 %>" __designer:wfdid="w136"></asp:Label></TD><TD style="WIDTH: 350px"><asp:DropDownList id="ddlItem4FormView" runat="server" DataSourceID="dsPola" __designer:wfdid="w137" DataValueField="KODE_POTONGAN" DataTextField="Keterangan" SelectedValue='<%# Bind("KODE_POTONGAN") %>'></asp:DropDownList> </TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="Label3" runat="server" Text="<%$ Resources:Column5 %>" __designer:wfdid="w138"></asp:Label></TD><TD style="WIDTH: 350px"><asp:TextBox id="txtItem5FormView" runat="server" Text='<%# Bind("TGL_PENETAPAN", "{0:d}") %>' width="100px" MaxLength="10" Columns="10" __designer:wfdid="w139"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem5FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w140"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem5FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w141">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem5_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal" __designer:wfdid="w142">*</asp:CompareValidator><cc1:CalendarExtender id="cexItem5FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem5FormView" PopupButtonID="imgItem5FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" __designer:wfdid="w143"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem5FormView" runat="server" TargetControlID="txtItem5FormView" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w144"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px" vAlign=top>&nbsp;<asp:Label id="Label4" runat="server" Text="<%$ Resources:Column6 %>" __designer:wfdid="w145"></asp:Label></TD><TD style="WIDTH: 350px"><asp:TextBox id="txtItem6FormView" runat="server" Text='<%# Bind("DOKUMEN_DISIPLIN") %>' TextMode="MultiLine" MaxLength="100" Columns="30" __designer:wfdid="w146" Rows="3"></asp:TextBox></TD></TR><TR><TD vAlign=top align=left colSpan=2></TD></TR><TR><TD vAlign=top align=left colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgUpdate" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w147" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton> <asp:LinkButton id="lnkUpdate" runat="server" Text="<%$ Resources:ImgUpdate %>" __designer:wfdid="w148" CommandName="Update"></asp:LinkButton> &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w149" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Edit"></asp:ImageButton> <asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w150" CommandName="Cancel_Edit"></asp:LinkButton></TD></TR></TBODY></TABLE>&nbsp; 
</EditItemTemplate>
<InsertItemTemplate>
<TABLE style="WIDTH: 500px" cellPadding=1><TBODY><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNip" runat="server" Text="<%$ Resources:Column0 %>" width="50px" __designer:wfdid="w84"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN" __designer:wfdid="w121"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem0FormView" runat="server" AutoPostBack="True" width="100px" MaxLength="25" __designer:wfdid="w426" OnTextChanged="txtItem0FormView_TextChanged"></asp:TextBox> <asp:LinkButton id="lnkItem0FormView" onclick="lnkItem0FormView_Click" runat="server" CausesValidation="False" __designer:wfdid="w86">Lookup</asp:LinkButton> <asp:RequiredFieldValidator id="valItem0FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem0FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w87">*</asp:RequiredFieldValidator></TD></TR><TR><TD>&nbsp;<asp:Label id="lblNama" runat="server" Text="<%$ Resources:Column1 %>" __designer:wfdid="w88"></asp:Label></TD><TD vAlign=top><asp:Label id="lblItem1FormView" runat="server" __designer:wfdid="w89"></asp:Label></TD></TR><TR><TD>&nbsp;<asp:Label id="lblTglMasuk" runat="server" Text="<%$ Resources:Column2 %>" __designer:wfdid="w90"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem2FormView" runat="server" Text='<%# Bind("TGL_AWAL", "{0:d}") %>' width="100px" MaxLength="10" Columns="10" __designer:wfdid="w91"></asp:TextBox> <asp:ImageButton id="imgItem2FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w92"></asp:ImageButton> <asp:RequiredFieldValidator id="valItem2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w93">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem2_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal" __designer:wfdid="w94">*</asp:CompareValidator><asp:RangeValidator id="CompareValTglAdd" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:tglval %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" SetFocusOnError="True" Type="Date" __designer:wfdid="w95" MinimumValue="1/1/1900" MaximumValue="1/1/9000">*</asp:RangeValidator> <cc1:CalendarExtender id="cexItem2FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem2FormView" PopupButtonID="imgItem2FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" __designer:wfdid="w96">
                                    </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem2FormView" runat="server" TargetControlID="txtItem2FormView" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w97"></cc1:MaskedEditExtender>&nbsp;&nbsp;</TD></TR><TR><TD>&nbsp;<asp:Label id="lblJamMasuk" runat="server" Text="<%$ Resources:Column3 %>" __designer:wfdid="w98"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem3FormView" runat="server" Text='<%# Bind("TGL_AKHIR", "{0:d}") %>' width="100px" MaxLength="10" Columns="10" __designer:wfdid="w99"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem3FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w100"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w101">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem3_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal" __designer:wfdid="w102">*</asp:CompareValidator><asp:CompareValidator id="valItem3_2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" __designer:wfdid="w103" ControlToCompare="txtItem2FormView">*</asp:CompareValidator> <cc1:CalendarExtender id="cexItem3FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem3FormView" PopupButtonID="imgItem3FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" __designer:wfdid="w104"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" TargetControlID="txtItem3FormView" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w105"></cc1:MaskedEditExtender></TD></TR><TR><TD>&nbsp;<asp:Label id="lblJamKeluar" runat="server" Text="<%$ Resources:Column4 %>" __designer:wfdid="w106"></asp:Label></TD><TD vAlign=top><asp:DropDownList id="ddlItem4FormView" runat="server" DataSourceID="dsPola" __designer:wfdid="w107" DataValueField="KODE_POTONGAN" DataTextField="Keterangan" SelectedValue='<%# Bind("KODE_POTONGAN") %>'></asp:DropDownList></TD></TR><TR><TD>&nbsp;<asp:Label id="Label3" runat="server" Text="<%$ Resources:Column5 %>" __designer:wfdid="w108"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem5FormView" runat="server" Text='<%# Bind("TGL_PENETAPAN", "{0:d}") %>' width="100px" MaxLength="10" Columns="10" __designer:wfdid="w109"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem5FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" __designer:wfdid="w110"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem5FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" SetFocusOnError="True" __designer:wfdid="w111">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem5_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem5FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal" __designer:wfdid="w112">*</asp:CompareValidator><cc1:CalendarExtender id="cexItem5FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem5FormView" PopupButtonID="imgItem5FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True" __designer:wfdid="w113"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem5FormView" runat="server" TargetControlID="txtItem5FormView" MaskType="Date" Mask="99/99/9999" __designer:wfdid="w114"></cc1:MaskedEditExtender></TD></TR><TR><TD vAlign=top>&nbsp;<asp:Label id="Label4" runat="server" Text="<%$ Resources:Column6 %>" __designer:wfdid="w115"></asp:Label></TD><TD vAlign=top><asp:TextBox id="txtItem6FormView" runat="server" Text='<%# Bind("DOKUMEN_DISIPLIN") %>' TextMode="MultiLine" MaxLength="100" Columns="30" __designer:wfdid="w116" Rows="3"></asp:TextBox></TD></TR><TR><TD colSpan=2>&nbsp;</TD></TR><TR><TD colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgInsert" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w117" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton> <asp:LinkButton id="lnkInsert" runat="server" Text="<%$ Resources:ImgInsert %>" __designer:wfdid="w118" CommandName="Insert"></asp:LinkButton> &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w119" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton> <asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w120" CommandName="Cancel_Insert"></asp:LinkButton></TD></TR></TBODY></TABLE>&nbsp; 
</InsertItemTemplate>
</asp:FormView> &nbsp;&nbsp; <BR /><BR /><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender></TD></TR><TR></TR></TBODY></TABLE>
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



