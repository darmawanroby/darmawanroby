<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="dayoff.aspx.cs" Inherits="rtwin.dayoff" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><DIV id="hideForm" runat="server"><TABLE style="WIDTH: 100%" id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 border=0 runat="server"><TBODY><TR><TD style="WIDTH: 100%"><BR /><TABLE cellPadding=1 width=750 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="lblTglAwal" runat="server" Text="<%$ Resources:lblFrom %>" width="100px"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left><asp:TextBox id="txtFilterItem0" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem0" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem0_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem0" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator> <cc1:CalendarExtender id="cexFilterItem0" runat="server" CssClass="cal_Theme1" targetcontrolid="txtFilterItem0" PopupButtonID="imgFilterItem0" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True">
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem0" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem0"></cc1:MaskedEditExtender> </TD><TD style="WIDTH: 50px" vAlign=top align=center><asp:Label id="lblTglAkhir" runat="server" Text="<%$ Resources:lblTo %>"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left><asp:TextBox id="txtFilterItem1" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem1" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem1_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valFilterItem1_2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" ControlToCompare="txtFilterItem0">*</asp:CompareValidator> <cc1:CalendarExtender id="cexFilterItem1" runat="server" CssClass="cal_Theme1" targetcontrolid="txtFilterItem1" PopupButtonID="imgFilterItem1" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True">
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem1" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem1"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 100px" vAlign=top><asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:Button></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:Column0 %>" width="80px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD colSpan=4><asp:TextBox id="txtFilterItem2" runat="server" AutoPostBack="True" width="100px"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem3" runat="server" OnSelectedIndexChanged="ddlFilterItem3_DataBound_SelectedChange" AutoPostBack="True" DataSourceID="dsBiro" DataValueField="KODE_DEPUTI" DataTextField="NAMA_DEPUTI" OnDataBound="ddlFilterItem3_DataBound_SelectedChange"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem4" runat="server" DataSourceID="dsBagian" DataValueField="KODE_BIRO" DataTextField="NAMA_BIRO"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblStatusAlasan" runat="server" Text="<%$ Resources:lblStatusAlasan %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem5" runat="server"><asp:ListItem Value="-"></asp:ListItem>
<asp:ListItem Value="1">Disetujui</asp:ListItem>
<asp:ListItem Value="0">Belum Disetujui</asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD><asp:CheckBox id="cbFilterItem6" runat="server" Text="<%$ Resources:cbJenisIjin %>"></asp:CheckBox></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem6" runat="server" DataSourceID="dsIjin" DataValueField="KODE_IJIN" DataTextField="KET_IJIN"></asp:DropDownList></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR>
            <TD style="WIDTH: 100%" vAlign=top><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImgbtnAdd" onclick="ImgBtnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp; <asp:LinkButton id="lblTambah" onclick="lblTambah_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="GvAlasan" runat="server" DataSourceID="dsAlasan" OnDataBound="GvAlasan_DataBound" OnRowDataBound="GvAlasan_RowDataBound" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="NIP,PIN,TGL_AWAL" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GvAlasan_RowEditing" OnRowCommand="GvAlasan_RowCommand">
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
<asp:TemplateField SortExpression="TGL_AWAL" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TGL_AWAL","{0:d}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_AKHIR" HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("TGL_AKHIR","{0:d}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_IJIN" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("KODE_IJIN") %>'></asp:Label> 
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
<asp:TemplateField SortExpression="JML_HARI" HeaderText="<%$ Resources:Column6 %>"><ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("JML_HARI") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="BUKTI_IJIN" HeaderText="<%$ Resources:Column7 %>"><ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# Bind("BUKTI_IJIN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_STATUS" Visible="False" HeaderText="<%$ Resources:Column8 %>"><ItemTemplate>
<asp:Label id="lblCol8Item" runat="server" Text='<%# Bind("KET_STATUS") %>'></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="STATUS_IJIN" HeaderText="<%$ Resources:Column9 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>
<ItemTemplate>
<asp:CheckBox id="chkSelect" runat="server" Checked='<%# BIND("STATUS_IJIN") %>'></asp:CheckBox> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column10 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column11 %>">
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
</asp:GridView><asp:SqlDataSource id="dsAlasan" runat="server" SelectCommand="SELECT NIP, NAMA, TGL_AWAL, TGL_AKHIR, KODE_IJIN, KET_IJIN, JML_HARI, TGL_JATAH, BUKTI_IJIN, KET_STATUS, STATUS_IJIN, PERHITUNGAN, LAMA_IJIN, PIN, TGL_BERSALIN FROM q_IjinHari" ConnectionString="<%$ ConnectionStrings:strCn %>" UpdateCommand="UPDATE taIjinHari SET TGL_AKHIR = @TGL_AKHIR, KODE_IJIN = @KODE_IJIN, BUKTI_IJIN = @BUKTI_IJIN, STATUS_IJIN = @STATUS_IJIN, TGL_BERSALIN = @TGL_BERSALIN WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" InsertCommand="INSERT INTO taIjinHari(NIP, TGL_AWAL, TGL_AKHIR, KODE_IJIN, JML_HARI, TGL_JATAH, BUKTI_IJIN, STATUS_IJIN, TGL_BERSALIN) VALUES (@NIP, @TGL_AWAL, @TGL_AKHIR, @KODE_IJIN, dbo.SetJmlHari(@NIP, @KODE_IJIN, @TGL_AWAL, @TGL_AKHIR), dbo.SetTglJatah(@NIP, @KODE_IJIN, @TGL_AWAL, @TGL_AKHIR), @BUKTI_IJIN, @STATUS_IJIN, @TGL_BERSALIN)" OnDeleted="dsAlasan_Deleted" DeleteCommand="DELETE FROM taIjinHari WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" OnUpdating="dsAlasanEdit_Updating" OnUpdated="dsAlasanEdit_Updated" OnInserting="dsAlasanEdit_Inserting" OnInserted="dsAlasanEdit_Inserted"><DeleteParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_AWAL"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="TGL_AKHIR"></asp:Parameter>
<asp:Parameter Name="KODE_IJIN"></asp:Parameter>
<asp:Parameter Name="BUKTI_IJIN"></asp:Parameter>
<asp:Parameter Name="STATUS_IJIN"></asp:Parameter>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_AWAL"></asp:Parameter>
    <asp:Parameter Name="TGL_BERSALIN" />
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="NIP"></asp:Parameter>
<asp:Parameter Name="TGL_AWAL"></asp:Parameter>
<asp:Parameter Name="TGL_AKHIR"></asp:Parameter>
<asp:Parameter Name="KODE_IJIN"></asp:Parameter>
<asp:Parameter Name="JML_HARI"></asp:Parameter>
<asp:Parameter Name="TGL_JATAH"></asp:Parameter>
<asp:Parameter Name="BUKTI_IJIN"></asp:Parameter>
<asp:Parameter Name="STATUS_IJIN"></asp:Parameter>
    <asp:Parameter Name="TGL_BERSALIN" />
</InsertParameters>
</asp:SqlDataSource><asp:SqlDataSource id="dsBagian" runat="server" SelectCommand="SELECT KODE_BIRO, NAMA_BIRO, KODE_CABANG, KODE_DEPUTI FROM q_BIRO ORDER BY KODE_BIRO" ConnectionString="<%$ ConnectionStrings:strCn %>">
                </asp:SqlDataSource> <TABLE id="tblFormView" runat="server"><TBODY><TR><TD vAlign=top><asp:FormView id="FvAlasan" runat="server" CssClass="FormView" DataSourceID="dsAlasan" OnDataBound="FvAlasan_DataBound" DataKeyNames="NIP,TGL_AWAL" OnItemCommand="FvAlasan_ItemCommand"><EditItemTemplate>
<TABLE style="WIDTH: 500px" cellPadding=1><TBODY><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNipEdit" runat="server" Text="<%$ Resources:Column0 %>"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem0FormView" runat="server" Text='<%# Bind("NIP") %>'></asp:Label><asp:Label id="lblItem0_FormView" runat="server" Text='<%# Bind("PIN") %>'></asp:Label></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNamaEdit" runat="server" Text="<%$ Resources:Column1 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem1FormView" runat="server" Text='<%# Eval("NAMA") %>'></asp:Label></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblTglAwalEdit" runat="server" Text="<%$ Resources:Column2 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem2FormView" runat="server" Text='<%# Bind("TGL_AWAL", "{0:d}") %>'></asp:Label>&nbsp;&nbsp;</TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblTglAkhirEdit" runat="server" Text="<%$ Resources:Column3 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem3FormView" runat="server" Text='<%# BIND("TGL_AKHIR","{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem3FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem3_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valItem3_2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare='<%# Eval("TGL_AWAL","{0:d}") %>' Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir">*</asp:CompareValidator> <cc1:CalendarExtender id="cexItem3FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem3FormView" PopupButtonID="imgItem3FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtItem3FormView"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblKodeIjinEdit" runat="server" Text="<%$ Resources:Column5 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:DropDownList id="ddlItem4FormView" runat="server" OnSelectedIndexChanged="ddlItem4FormView_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsIjin" DataValueField="KODE_IJIN" DataTextField="KET_IJIN" OnDataBound="ddlItem4FormView_SelectedIndexChanged" SelectedValue='<%# BIND("KODE_IJIN") %>'></asp:DropDownList><br />
    <asp:Label ID="lblTglBersalin" runat="server" Text="Tgl. Bersalin" Visible="False"></asp:Label><asp:TextBox
        ID="txtItem4aFormView" runat="server" Columns="10" MaxLength="10" Text='<%# Bind("TGL_BERSALIN", "{0:d}") %>'
        Visible="False" Width="100px"></asp:TextBox><asp:ImageButton ID="imgItem4aFormView"
                                                runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" Visible="False" /><asp:CompareValidator
                                                    ID="valItem4aFormView" runat="server" ControlToValidate="txtItem4aFormView" CssClass="fontR"
                                                    EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>"
                                                    meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" SkinID="fontR"
                                                    Type="Date" ValueToCompare="1/1/1900">*</asp:CompareValidator><asp:RangeValidator
                                                        ID="valItem4a_2FormView" runat="server" ControlToValidate="txtItem4aFormView"
                                                        CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:tglval %>"
                                                        MaximumValue="1/1/9000" MinimumValue="1/1/1900" SetFocusOnError="True" SkinID="fontR"
                                                        Type="Date">*</asp:RangeValidator><asp:CompareValidator ID="valItem4a_3FormView"
                                                            runat="server" ControlToCompare="txtItem3FormView" ControlToValidate="txtItem4aFormView"
                                                            CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>"
                                                            meta:resourceKey="CompareValTglAwal" Operator="LessThanEqual" SkinID="fontR"
                                                            Type="Date">*</asp:CompareValidator></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblBuktiIjinEdit" runat="server" Text="<%$ Resources:Column7 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem5FormView" runat="server" Text='<%# Bind("BUKTI_IJIN") %>' MaxLength="30" Columns="30"></asp:TextBox></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblStatusIjinEdit" runat="server" Text="<%$ Resources:Column8 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:CheckBox id="chkItem6FormView" runat="server" Text="<%$ Resources:Column9 %>" Checked='<%# Bind("STATUS_IJIN") %>'></asp:CheckBox></TD></TR><TR><TD colSpan=2>&nbsp;</TD></TR><TR><TD colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgUpdate" runat="server" ImageUrl="~/images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkUpdate" runat="server" Text="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:LinkButton>&nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Edit"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Edit"></asp:LinkButton></TD></TR></TBODY></TABLE>&nbsp;&nbsp; 
</EditItemTemplate>
<InsertItemTemplate>
<TABLE style="WIDTH: 500px" cellPadding=1><TBODY><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNipEdit" runat="server" Text="<%$ Resources:Column0 %>"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem0FormView" runat="server" AutoPostBack="True" width="100px" MaxLength="25" OnTextChanged="txtItem0FormView_TextChanged"></asp:TextBox>&nbsp;<asp:LinkButton id="lnkItem0FormView" onclick="lnkItem0FormView_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton>&nbsp;<asp:RequiredFieldValidator id="valItem0FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem0FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblNamaEdit" runat="server" Text="<%$ Resources:Column1 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:Label id="lblItem1FormView" runat="server"></asp:Label></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblTglAwalEdit" runat="server" Text="<%$ Resources:Column2 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem2FormView" runat="server" Text='<%# Bind("TGL_AWAL", "{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem2FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem2_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:RangeValidator id="CompareValTglAdd" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:tglval %>" ControlToValidate="txtItem2FormView" EnableClientScript="True" SetFocusOnError="True" Type="Date" MaximumValue="1/1/9000" MinimumValue="1/1/1900">*</asp:RangeValidator><cc1:CalendarExtender id="cexItem2FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem2FormView" PopupButtonID="imgItem2FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True">
                                    </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem2FormView" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtItem2FormView"></cc1:MaskedEditExtender>
    <br />
</TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblTglAkhirEdit" runat="server" Text="<%$ Resources:Column3 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem3FormView" runat="server" Text='<%# BIND("TGL_AKHIR","{0:d}") %>' width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgItem3FormView" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valItem3FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valItem3_1FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valItem3_2FormView" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtItem3FormView" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" ControlToCompare="txtItem2FormView">*</asp:CompareValidator> <cc1:CalendarExtender id="cexItem3FormView" runat="server" CssClass="cal_Theme1" targetcontrolid="txtItem3FormView" PopupButtonID="imgItem3FormView" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexItem3FormView" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtItem3FormView"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 150px; height: 50px;">&nbsp;<asp:Label id="lblKodeIjinEdit" runat="server" Text="<%$ Resources:Column5 %>"></asp:Label></TD><TD style="WIDTH: 350px; height: 50px;" vAlign=top><asp:DropDownList id="ddlItem4FormView" runat="server" OnSelectedIndexChanged="ddlItem4FormView_SelectedIndexChanged" AutoPostBack="True" DataSourceID="dsIjin" DataValueField="KODE_IJIN" DataTextField="KET_IJIN" OnDataBound="ddlItem4FormView_SelectedIndexChanged" SelectedValue='<%# BIND("KODE_IJIN") %>'></asp:DropDownList> <asp:Button id="btnRefreshGridSisaIjin" onclick="btnRefreshGridSisaIjin_Click" runat="server" Visible="False" Text="Refresh Detail Sisa Ijin"></asp:Button><br />
                                        <asp:Label ID="lblTglBersalin" runat="server" Text="Tgl. Bersalin" Visible="False"></asp:Label><asp:TextBox
                                            ID="txtItem4aFormView" runat="server" Columns="10" MaxLength="10" Text='<%# Bind("TGL_BERSALIN", "{0:d}") %>'
                                            Visible="False" Width="100px"></asp:TextBox><asp:ImageButton ID="imgItem4aFormView"
                                                runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif" Visible="False" /><asp:CompareValidator
                                                    ID="valItem4aFormView" runat="server" ControlToCompare="txtItem2FormView" ControlToValidate="txtItem4aFormView"
                                                    CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>"
                                                    meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" SkinID="fontR"
                                                    Type="Date">*</asp:CompareValidator><asp:RangeValidator ID="valItem4a_2FormView"
                                                        runat="server" ControlToValidate="txtItem4aFormView" CssClass="fontR" EnableClientScript="True"
                                                        ErrorMessage="<%$ Resources:tglval %>" MaximumValue="1/1/9000" MinimumValue="1/1/1900"
                                                        SetFocusOnError="True" SkinID="fontR" Type="Date">*</asp:RangeValidator><asp:CompareValidator
                                                            ID="valItem4a_3FormView" runat="server" ControlToCompare="txtItem3FormView" ControlToValidate="txtItem4aFormView"
                                                            CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>"
                                                            meta:resourceKey="CompareValTglAwal" Operator="LessThanEqual" SkinID="fontR"
                                                            Type="Date">*</asp:CompareValidator></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblBuktiIjinEdit" runat="server" Text="<%$ Resources:Column7 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:TextBox id="txtItem5FormView" runat="server" Text='<%# Bind("BUKTI_IJIN") %>' MaxLength="30" Columns="30"></asp:TextBox></TD></TR><TR><TD style="WIDTH: 150px">&nbsp;<asp:Label id="lblStatusIjinEdit" runat="server" Text="<%$ Resources:Column8 %>"></asp:Label></TD><TD style="WIDTH: 350px" vAlign=top><asp:CheckBox id="chkItem6FormView" runat="server" Text="<%$ Resources:Column9 %>" Checked='<%# Bind("STATUS_IJIN") %>'></asp:CheckBox></TD></TR><TR><TD colSpan=2>&nbsp;</TD></TR><TR><TD colSpan=2>&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgInsert" runat="server" ImageUrl="~/images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkInsert" runat="server" Text="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:LinkButton>&nbsp;&nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Insert"></asp:LinkButton></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView></TD><TD style="WIDTH: 200px" vAlign=top><asp:Label id="lblTitleSisaIjinDetail" runat="server" Font-Bold="True" Text="Detil Sisa Ijin"></asp:Label><BR /><BR /><asp:GridView id="GvSisaIjinDetail" runat="server" width="200px" DataSourceID="dsSisaIjin" AutoGenerateColumns="False"><Columns>
<asp:BoundField ReadOnly="True" DataField="TAHUN" SortExpression="TAHUN" HeaderText="TAHUN">
<HeaderStyle width="100px"></HeaderStyle>
</asp:BoundField>
<asp:BoundField DataField="SISA_IJIN" SortExpression="SISA_IJIN" HeaderText="SISA_IJIN">
<HeaderStyle width="100px"></HeaderStyle>
</asp:BoundField>
</Columns>

<RowStyle horizontalalign="Center"></RowStyle>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView><asp:SqlDataSource id="dsSisaIjin" runat="server" SelectCommand="SELECT DATEPART(YEAR, TGL_AWAL) AS TAHUN, SISA_IJIN FROM taJatahIjin WHERE (NIP = @NIP) AND (KODE_IJIN = @KODE_IJIN) AND (SISA_IJIN > 0) AND (EXPIRED <= @TGL_AWAL)" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource> </TD></TR></TBODY></TABLE>&nbsp;&nbsp;&nbsp; <BR /><asp:Button id="btnSimpan" onclick="btnSimpan_Click" runat="server" CssClass="lblStandar" Text="<%$ Resources:ImgUpdate %>"></asp:Button>&nbsp;<asp:CheckBox id="chkCheckOrClearAll" runat="server" Text="<%$ Resources:Resource, chkCheckOrClearAll %>" AutoPostBack="True" OnCheckedChanged="chkCheckOrClearAll_CheckedChanged"></asp:CheckBox><BR />
                <asp:Button ID="btnUploadDayoff" runat="server" onclick="Button1_Click" 
                    Text="Upload Ketidakhadiran" />
                <BR /><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender></TD></TR></TBODY></TABLE>
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
        SelectCommand="SELECT KODE_IJIN, '[' + KODE_IJIN + '] ' + KET_IJIN AS KET_IJIN FROM taIjin WHERE (KODE_TIDAK_HADIR = '1') ORDER BY KODE_IJIN">
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
    <br />
                <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False" width="330px"></asp:Label><asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>"
                    Visible="False" width="259px"></asp:Label><asp:Label ID="lblWrongDate" runat="server" Text="<%$ Resources:Resource, lblWrongDate %>"
                    Visible="False" width="320px"></asp:Label><asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label>
    <asp:Label ID="lblDuplicateInput" runat="server" Text="<%$ Resources:lblDuplicateInput %>"
        Visible="False"></asp:Label>
    <asp:Label ID="lblIjinKurang" runat="server" Text="<%$ Resources:lblIjinKurang %>"
        Visible="False"></asp:Label>
   
</asp:Content>



