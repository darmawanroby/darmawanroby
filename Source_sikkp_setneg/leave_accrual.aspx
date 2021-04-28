<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="leave_accrual.aspx.cs" Inherits="rtwin.leave_accrual" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" __designer:wfdid="w134" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" __designer:wfdid="w135" EnableViewState="False"></asp:Label><BR /><DIV id="hideForm" runat="server"><TABLE style="WIDTH: 100%" id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 border=0 runat="server"><TBODY><TR><TD style="WIDTH: 100%"><BR /><TABLE cellPadding=1 width=750 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="lblTglAwal" runat="server" Text="<%$ Resources:Label1 %>" width="100px" __designer:wfdid="w136"></asp:Label></TD><TD style="WIDTH: 450px" vAlign=top align=left colSpan=3><asp:DropDownList id="ddlFilterItem0" runat="server" OnSelectedIndexChanged="btnRefresh_Click" AutoPostBack="True" CausesValidation="True" __designer:wfdid="w31"></asp:DropDownList>&nbsp;<asp:Label id="lblTglAkhir" runat="server" Text="<%$ Resources:Label2 %>" __designer:wfdid="w32"></asp:Label>&nbsp;<asp:DropDownList id="ddlFilterItem1" runat="server" OnSelectedIndexChanged="btnRefresh_Click" AutoPostBack="True" CausesValidation="True" __designer:wfdid="w33"></asp:DropDownList></TD><TD style="WIDTH: 100px" vAlign=top align=right><asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>" __designer:wfdid="w149"></asp:Button></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:Column0 %>" width="80px" __designer:wfdid="w150"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN" __designer:wfdid="w356"></asp:Label></TD><TD colSpan=4><asp:TextBox id="txtFilterItem2" runat="server" Text='<%# Bind("NIP") %>' width="100px" __designer:wfdid="w34"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False" __designer:wfdid="w35">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblBiro %>" __designer:wfdid="w153"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem3" runat="server" OnSelectedIndexChanged="ddlFilterItem3_DataBound_SelectedChange" AutoPostBack="True" DataSourceID="dsBiro" __designer:wfdid="w36" OnDataBound="ddlFilterItem3_DataBound_SelectedChange" DataTextField="NAMA_DEPUTI" DataValueField="KODE_DEPUTI"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:lblBagian %>" __designer:wfdid="w155"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem4" runat="server" DataSourceID="dsBagian" __designer:wfdid="w37" DataTextField="NAMA_BIRO" DataValueField="KODE_BIRO"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblIsiManual" runat="server" Text="<%$ Resources:lblKodeIjin %>" __designer:wfdid="w157"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem5" runat="server" DataSourceID="dsIjin" __designer:wfdid="w38" DataTextField="KET_IJIN" DataValueField="KODE_IJIN"></asp:DropDownList> </TD></TR></TBODY></TABLE><BR /><asp:Panel id="pnlColabsibleControl" runat="server" CssClass="HeaderStyle" width="300px" forecolor="Yellow" __designer:wfdid="w269"><table style="WIDTH: 100%"><tbody><tr><td valign=middle><asp:Label id="lblPnlColapsibleText" runat="server" __designer:wfdid="w259"></asp:Label></td><td valign=middle align=right><asp:ImageButton id="Image1" runat="server" __designer:wfdid="w270" ImageUrl="~/images/expand_blue.jpg" AlternateText="(Show Details...)"></asp:ImageButton></td></tr></tbody></table></asp:Panel> <asp:Panel id="PNLFilterExt" runat="server" __designer:wfdid="w256"><TABLE width=300><TBODY><TR><TD><asp:CheckBox id="chkExpired" runat="server" Text="<%$ Resources:Column9 %>" AutoPostBack="True" __designer:wfdid="w260" OnCheckedChanged="chkExpired_CheckedChanged"></asp:CheckBox></TD><TD><asp:DropDownList id="ddlOperasiBatas" runat="server" __designer:wfdid="w268"><asp:ListItem>=</asp:ListItem>
<asp:ListItem>&gt;=</asp:ListItem>
<asp:ListItem>&lt;=</asp:ListItem>
</asp:DropDownList></TD><TD><asp:TextBox id="txtTglBatas" runat="server" width="100px" __designer:wfdid="w271" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgTglBatas" runat="server" CausesValidation="False" __designer:wfdid="w272" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valTglBatas0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtTglBatas" __designer:wfdid="w273" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valTglBatas1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtTglBatas" __designer:wfdid="w274" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/1900">*</asp:CompareValidator><cc1:CalendarExtender id="cexTglBatas" runat="server" CssClass="cal_Theme1" __designer:wfdid="w275" Enabled="True" targetcontrolid="txtTglBatas" Format="<%$ Resources:Resource, formatTanggal %>" PopupButtonID="imgTglBatas"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexTglBatas" runat="server" __designer:wfdid="w310" Mask="99/99/9999" MaskType="Date" TargetControlID="txtTglBatas"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:CheckBox id="chkLamaKerja" runat="server" Text="<%$ Resources:Column3 %>" AutoPostBack="True" __designer:wfdid="w261" OnCheckedChanged="chkLamaKerja_CheckedChanged"></asp:CheckBox></TD><TD><asp:DropDownList id="ddlOperasiBatasMasaKerja" runat="server" __designer:wfdid="w24"><asp:ListItem>=</asp:ListItem>
<asp:ListItem>&gt;=</asp:ListItem>
<asp:ListItem>&lt;=</asp:ListItem>
</asp:DropDownList></TD><TD><asp:TextBox id="txtMasaKerja" runat="server" __designer:wfdid="w276" Columns="3" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtMasaKerja" __designer:wfdid="w1" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtMasaKerja" __designer:wfdid="w274" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexMasaKerja" runat="server" __designer:wfdid="w311" Mask="99999" MaskType="Number" TargetControlID="txtMasaKerja" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:CheckBox id="chkJatahIjin" runat="server" Text="<%$ Resources:Column7 %>" AutoPostBack="True" __designer:wfdid="w262" OnCheckedChanged="chkJatahIjin_CheckedChanged"></asp:CheckBox></TD><TD><asp:DropDownList id="ddlOperasiBatasJatahIjin" runat="server" __designer:wfdid="w25"><asp:ListItem>=</asp:ListItem>
<asp:ListItem>&gt;=</asp:ListItem>
<asp:ListItem>&lt;=</asp:ListItem>
</asp:DropDownList></TD><TD><asp:TextBox id="txtJatahIjin" runat="server" __designer:wfdid="w277" Columns="3" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtJatahIjin" __designer:wfdid="w2" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtJatahIjin" __designer:wfdid="w7" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexJatahIjin" runat="server" __designer:wfdid="w312" Mask="99999" MaskType="Number" TargetControlID="txtJatahIjin" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:CheckBox id="chkDiambil" runat="server" Text="<%$ Resources:Column10 %>" AutoPostBack="True" __designer:wfdid="w263" OnCheckedChanged="chkDiambil_CheckedChanged"></asp:CheckBox></TD><TD><asp:DropDownList id="ddlOperasiBatasDiambil" runat="server" __designer:wfdid="w26"><asp:ListItem>=</asp:ListItem>
<asp:ListItem>&gt;=</asp:ListItem>
<asp:ListItem>&lt;=</asp:ListItem>
</asp:DropDownList></TD><TD><asp:TextBox id="txtDiambil" runat="server" __designer:wfdid="w278" Columns="3" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtDiambil" __designer:wfdid="w3" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator3" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtDiambil" __designer:wfdid="w8" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexDiambil" runat="server" __designer:wfdid="w313" Mask="99999" MaskType="Number" TargetControlID="txtDiambil" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:CheckBox id="chkTidakDiambil" runat="server" Text="<%$ Resources:Column11 %>" AutoPostBack="True" __designer:wfdid="w264" OnCheckedChanged="chkTidakDiambil_CheckedChanged"></asp:CheckBox></TD><TD><asp:DropDownList id="ddlOperasiBatasHangus" runat="server" __designer:wfdid="w27"><asp:ListItem>=</asp:ListItem>
<asp:ListItem>&gt;=</asp:ListItem>
<asp:ListItem>&lt;=</asp:ListItem>
</asp:DropDownList></TD><TD><asp:TextBox id="txtHangus" runat="server" __designer:wfdid="w279" Columns="3" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtHangus" __designer:wfdid="w4" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator4" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtHangus" __designer:wfdid="w9" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexHangus" runat="server" __designer:wfdid="w314" Mask="99999" MaskType="Number" TargetControlID="txtHangus" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:CheckBox id="chkSisaIjin" runat="server" Text="<%$ Resources:Column12 %>" AutoPostBack="True" __designer:wfdid="w265" OnCheckedChanged="chkSisaIjin_CheckedChanged"></asp:CheckBox></TD><TD><asp:DropDownList id="ddlOperasiBatasSisa" runat="server" __designer:wfdid="w28"><asp:ListItem>=</asp:ListItem>
<asp:ListItem>&gt;=</asp:ListItem>
<asp:ListItem>&lt;=</asp:ListItem>
</asp:DropDownList></TD><TD><asp:TextBox id="txtSisa" runat="server" __designer:wfdid="w280" Columns="3" MaxLength="5"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator5" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtSisa" __designer:wfdid="w5" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="CompareValidator5" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtSisa" __designer:wfdid="w10" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexSisa" runat="server" __designer:wfdid="w315" Mask="99999" MaskType="Number" TargetControlID="txtSisa" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR></TBODY></TABLE></asp:Panel> <cc1:CollapsiblePanelExtender id="CollapsiblePanelExtender1" runat="server" __designer:wfdid="w257" Enabled="True" targetcontrolid="PNLFilterExt" Collapsed="True" CollapsedText="<%$ Resources:lblShow %>" ExpandedText="<%$ Resources:lblHide %>" CollapseControlID="pnlColabsibleControl" ExpandControlID="pnlColabsibleControl" TextLabelID="lblPnlColapsibleText" ImageControlID="Image1" CollapsedImage="~/images/expand_blue.jpg" ExpandedImage="~/images/collapse_blue.jpg" SuppressPostBack="True"></cc1:CollapsiblePanelExtender></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" vAlign=top rowSpan=2><asp:GridView id="GvSaldoIjin" runat="server" DataSourceID="dsSaldoIjin" __designer:wfdid="w161" OnDataBound="GvSaldoIjin_DataBound" OnRowCommand="GvSaldoIjin_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" EmptyDataText="<%$ Resources:lblEmptyData %>" OnRowDataBound="GvSaldoIjin_RowDataBound">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="NIP" HeaderText="<%$ Resources:Column0 %>">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:LinkButton id="lnkCol0Item" runat="server" Text='<%# Eval("NIP") %>' __designer:wfdid="w3" CommandName="Show"></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="PIN" HeaderText="PIN">
<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:LinkButton id="lnkCol0_Item" runat="server" Text='<%# Eval("PIN") %>' __designer:wfdid="w2" CommandName="Show"></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column1 %>">
<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Eval("NAMA") %>' __designer:wfdid="w317"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TMT" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Eval("TMT","{0:d}") %>' __designer:wfdid="w318"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LAMA_KERJA" HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Eval("LAMA_KERJA") %>' __designer:wfdid="w319"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_AKHIR" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Visible="False" Text='<%# Eval("TGL_AKHIR","{0:yyyy}") %>' __designer:wfdid="w320"></asp:Label><asp:LinkButton id="lnkCol4Item" runat="server" Visible="False" Text='<%# Eval("TGL_AKHIR","{0:yyyy}") %>' __designer:wfdid="w5" CommandName="Show"></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KODE_IJIN" HeaderText="<%$ Resources:Column5 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Eval("KODE_IJIN") %>' __designer:wfdid="w255"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_IJIN" HeaderText="<%$ Resources:Column6 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Eval("KET_IJIN") %>' __designer:wfdid="w17"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JATAH_IJIN" HeaderText="<%$ Resources:Column7 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# Eval("JATAH_IJIN") %>' __designer:wfdid="w18"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_BERLAKU" HeaderText="<%$ Resources:Column8 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol8Item" runat="server" Text='<%# Eval("TGL_BERLAKU","{0:d}") %>' __designer:wfdid="w19"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="EXPIRED" HeaderText="<%$ Resources:Column9 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol9Item" runat="server" Text='<%# Eval("EXPIRED","{0:d}") %>' __designer:wfdid="w237"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="DIAMBIL" HeaderText="<%$ Resources:Column10 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol10Item" runat="server" Text='<%# Eval("DIAMBIL") %>' __designer:wfdid="w21"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TIDAK_DIAMBIL" HeaderText="<%$ Resources:Column11 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol11Item" runat="server" Text='<%# Eval("TIDAK_DIAMBIL") %>' __designer:wfdid="w22"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="SISA_IJIN" HeaderText="<%$ Resources:Column12 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol12Item" runat="server" Text='<%# Eval("SISA_IJIN") %>' __designer:wfdid="w23"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_AWAL" Visible="False"><ItemTemplate>
<asp:Label id="lblCol13Item" runat="server" Text='<%# Bind("TGL_AWAL","{0:d}") %>' __designer:wfdid="w276"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First" __designer:wfdid="w111"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev" __designer:wfdid="w112"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w113"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged" __designer:wfdid="w114"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w115"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w116"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next" __designer:wfdid="w117"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last" __designer:wfdid="w118"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView><BR /><asp:Label id="lblTitleRincianJatahIjin" runat="server" Visible="False" Font-Bold="True" Text="Rincian Jatah Ijin" __designer:wfdid="w259"></asp:Label><BR /><BR /><asp:GridView id="gvIjinRinci" runat="server" Visible="False" width="390px" DataSourceID="dsIjinRinci" __designer:wfdid="w262" AutoGenerateColumns="False"><Columns>
<asp:TemplateField SortExpression="TGL_PROSES" HeaderText="Tgl. Proses">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("TGL_PROSES", "{0:d}") %>' __designer:wfdid="w264"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KET_JATAH" HeaderText="Keterangan">
<HeaderStyle width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("KET_JATAH") %>' __designer:wfdid="w265"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KREDIT" HeaderText="Kredit">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="70px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("KREDIT") %>' __designer:wfdid="w269"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="DEBIT" HeaderText="Debit">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="70px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("DEBIT") %>' __designer:wfdid="w270"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
</Columns>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView><asp:SqlDataSource id="dsIjinRinci" runat="server" SelectCommand="select TGL_PROSES, KET_JATAH, KREDIT, DEBIT from q_JatahIjinRinci" ConnectionString="<%$ ConnectionStrings:strCn %>" __designer:wfdid="w263"></asp:SqlDataSource> &nbsp;<BR /><asp:Panel id="pnlProses" runat="server" __designer:wfdid="w48"><TABLE width=300><TBODY><TR><TD style="WIDTH: 300px"><asp:Label id="Label3" runat="server" Text="Proses" __designer:wfdid="w49"></asp:Label></TD></TR><TR><TD style="WIDTH: 300px">&nbsp;&nbsp;&nbsp; <asp:RadioButton id="radProsesUpdateJatahIjin" runat="server" Text="<%$ Resources:lblUpdateJatahIjin %>" __designer:wfdid="w50" Checked="True" GroupName="radProses"></asp:RadioButton></TD></TR><TR><TD style="WIDTH: 300px">&nbsp;&nbsp;&nbsp; <asp:RadioButton id="radTambahJatahIjin" runat="server" Text="<%$ Resources:lblTambahJatahIjin %>" __designer:wfdid="w51" GroupName="radProses"></asp:RadioButton></TD></TR><TR><TD style="WIDTH: 300px">&nbsp;&nbsp;&nbsp; <asp:RadioButton id="radPotongJatahIjin" runat="server" Text="<%$ Resources:lblPotongJatahIjin %>" __designer:wfdid="w52" GroupName="radProses"></asp:RadioButton></TD></TR><TR><TD style="WIDTH: 300px">&nbsp;&nbsp;&nbsp; <asp:RadioButton id="radPotongSisaJatahIjin" runat="server" Text="<%$ Resources:lblPotongSisaJatahIjin %>" __designer:wfdid="w53" GroupName="radProses"></asp:RadioButton></TD></TR><TR><TD style="WIDTH: 300px">&nbsp;&nbsp;&nbsp; <asp:RadioButton id="radSetExpiredJatahIjin" runat="server" Text="<%$ Resources:lblSetExpiredJatahIjin %>" __designer:wfdid="w54" GroupName="radProses"></asp:RadioButton></TD></TR><TR><TD style="WIDTH: 300px">&nbsp;&nbsp;&nbsp; <asp:RadioButton id="radPerpanjangJatahIjin" runat="server" Text="<%$ Resources:lblPerpanjangJatahIjin %>" __designer:wfdid="w55" GroupName="radProses"></asp:RadioButton></TD></TR><TR><TD style="WIDTH: 300px">&nbsp;&nbsp;&nbsp; <asp:RadioButton id="radHangusJatahIjin" runat="server" Text="<%$ Resources:lblHangusJatahIjin %>" __designer:wfdid="w56" GroupName="radProses"></asp:RadioButton></TD></TR><TR><TD style="WIDTH: 300px" align=right><asp:Button id="btnProses" onclick="btnProses_Click" runat="server" Text="Proses" __designer:wfdid="w57"></asp:Button> <asp:LinkButton id="lnkPopupParameterInteger" runat="server" __designer:wfdid="w33"></asp:LinkButton> <cc1:ModalPopupExtender id="mpeParameterInteger" runat="server" __designer:wfdid="w63" targetcontrolid="lnkPopupParameterInteger" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="PNLInputParameterInteger"></cc1:ModalPopupExtender><asp:LinkButton id="lnkPopupParameterTanggal" runat="server" __designer:wfdid="w34"></asp:LinkButton><cc1:ModalPopupExtender id="mpeParameterTanggal" runat="server" __designer:wfdid="w35" targetcontrolid="lnkPopupParameterTanggal" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="pnlInputParameterTanggal"></cc1:ModalPopupExtender><asp:LinkButton id="lnkPopupConfirmation" runat="server" __designer:wfdid="w11"></asp:LinkButton><cc1:ModalPopupExtender id="mpeConfirmation" runat="server" __designer:wfdid="w12" targetcontrolid="lnkPopupConfirmation" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="PNLKonfirmasi"></cc1:ModalPopupExtender></TD></TR></TBODY></TABLE></asp:Panel> <asp:Panel style="BORDER-RIGHT: black 2px solid; PADDING-RIGHT: 20px; BORDER-TOP: black 2px solid; DISPLAY: none; PADDING-LEFT: 20px; PADDING-BOTTOM: 20px; BORDER-LEFT: black 2px solid; WIDTH: 300px; PADDING-TOP: 20px; BORDER-BOTTOM: black 2px solid; BACKGROUND-COLOR: white" id="PNLInputParameterInteger" runat="server" __designer:wfdid="w44"><DIV style="TEXT-ALIGN: right"><TABLE width="100%"><TBODY><TR><TD align=left colSpan=2><asp:Label id="lblTitleInputParameterInteger" runat="server" __designer:wfdid="w45">Input Parameter</asp:Label> 
<HR />
</TD></TR><TR><TD align=left><asp:Label id="lblTanyaParameterInteger" runat="server" __designer:wfdid="w46"></asp:Label></TD><TD align=left><asp:TextBox id="txtInputParameterInteger" runat="server" __designer:wfdid="w47" Columns="3" MaxLength="5"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valTxtInputParameterInteger0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtInputParameterInteger" __designer:wfdid="w48" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valTxtInputParameterInteger1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtInputParameterInteger" __designer:wfdid="w49" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Integer" ValueToCompare="0">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexInputParameterInteger" runat="server" __designer:wfdid="w322" Mask="99999" MaskType="Number" TargetControlID="txtInputParameterInteger" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD colSpan=2><asp:Button id="btnOK" onclick="btnOK_Click" runat="server" Text="OK" __designer:wfdid="w50"></asp:Button> <asp:Button id="btnCancel" onclick="cancelInputParameter" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w51"></asp:Button></TD></TR></TBODY></TABLE></DIV></asp:Panel> <asp:Panel style="BORDER-RIGHT: black 2px solid; PADDING-RIGHT: 20px; BORDER-TOP: black 2px solid; DISPLAY: none; PADDING-LEFT: 20px; PADDING-BOTTOM: 20px; BORDER-LEFT: black 2px solid; WIDTH: 300px; PADDING-TOP: 20px; BORDER-BOTTOM: black 2px solid; BACKGROUND-COLOR: white" id="pnlInputParameterTanggal" runat="server" __designer:wfdid="w19"><DIV style="TEXT-ALIGN: right"><TABLE><TBODY><TR><TD align=left colSpan=2><asp:Label id="lblTitleInputParameterTanggal" runat="server" __designer:wfdid="w7">Input Parameter</asp:Label> 
<HR />
</TD></TR><TR><TD align=left><asp:Label id="lblTanyaParameterTanggal" runat="server" Text="<%$ Resources:lblSetExpiredJumlahJatahIjin %>" __designer:wfdid="w4"></asp:Label></TD><TD align=left><asp:TextBox id="txtInputParameterTanggal" runat="server" width="100px" __designer:wfdid="w26" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgInputParameterTanggal" runat="server" CausesValidation="False" __designer:wfdid="w27" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valTxtInputParameterTanggal0" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtInputParameterTanggal" __designer:wfdid="w28" EnableClientScript="True" Enabled="False" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valTxtInputParameterTanggal1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtInputParameterTanggal" __designer:wfdid="w29" EnableClientScript="True" Enabled="False" meta:resourceKey="CompareValTglAwal" Operator="GreaterThanEqual" Type="Date" ValueToCompare="01/01/1900">*</asp:CompareValidator><cc1:CalendarExtender id="cexTxtInputParameterTanggal" runat="server" CssClass="cal_Theme1" __designer:wfdid="w30" Enabled="True" targetcontrolid="txtInputParameterTanggal" Format="<%$ Resources:Resource, formatTanggal %>" PopupButtonID="imgInputParameterTanggal"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexInputParameterTanggal" runat="server" __designer:wfdid="w323" Mask="99/99/9999" MaskType="Date" TargetControlID="txtInputParameterTanggal"></cc1:MaskedEditExtender></TD></TR><TR><TD colSpan=2><asp:Button id="btnOK2" onclick="btnOK_Click" runat="server" Text="OK" __designer:wfdid="w31"></asp:Button> <asp:Button id="btnCancel2" onclick="cancelInputParameter" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w32"></asp:Button></TD></TR></TBODY></TABLE></DIV></asp:Panel> <asp:Panel style="BORDER-RIGHT: black 2px solid; PADDING-RIGHT: 20px; BORDER-TOP: black 2px solid; DISPLAY: none; PADDING-LEFT: 20px; PADDING-BOTTOM: 20px; BORDER-LEFT: black 2px solid; WIDTH: 300px; PADDING-TOP: 20px; BORDER-BOTTOM: black 2px solid; BACKGROUND-COLOR: white" id="PNLKonfirmasi" runat="server" __designer:wfdid="w6"><asp:Label id="lblConfirmTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblConfirmation %>" Font-Size="Small" __designer:wfdid="w7"></asp:Label> 
<HR />
<TABLE><TBODY><TR><TD colSpan=2><asp:Label id="lblConfirmProses" runat="server" Font-Bold="True" Font-Size="Small" __designer:wfdid="w8"></asp:Label></TD></TR><TR><TD style="HEIGHT: 26px" colSpan=2><asp:Button id="btnOK3" onclick="btnOK_Click" runat="server" Text="OK" __designer:wfdid="w9"></asp:Button>&nbsp;<asp:Button id="btnCancel3" onclick="cancelInputParameter" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w10"></asp:Button></TD></TR></TBODY></TABLE><DIV style="TEXT-ALIGN: right">&nbsp;</DIV></asp:Panel> <BR /><asp:SqlDataSource id="dsSaldoIjin" runat="server" SelectCommand="SELECT NIP, NAMA, TMT, LAMA_KERJA, TGL_AKHIR, KODE_IJIN, KET_IJIN, JATAH_IJIN, TGL_BERLAKU, EXPIRED, DIAMBIL, TIDAK_DIAMBIL, SISA_IJIN, TGL_AWAL, PIN FROM q_SaldoIjin" ConnectionString="<%$ ConnectionStrings:strCn %>" __designer:wfdid="w162"></asp:SqlDataSource><asp:SqlDataSource id="dsBagian" runat="server" SelectCommand="SELECT KODE_BIRO, NAMA_BIRO, KODE_CABANG, KODE_DEPUTI FROM q_BIRO ORDER BY KODE_BIRO" ConnectionString="<%$ ConnectionStrings:strCn %>" __designer:wfdid="w164">
                </asp:SqlDataSource><asp:LinkButton id="lnkLookupTriger" runat="server" __designer:wfdid="w172"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" __designer:wfdid="w173" targetcontrolid="lnkLookupTriger" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="PNL_Lookup"></cc1:ModalPopupExtender></TD></TR><TR></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:SqlDataSource ID="dsBiro" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_DEPUTI, NAMA_DEPUTI, KODE_CABANG FROM q_DEPUTI ORDER BY KODE_DEPUTI">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsIjin" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_IJIN], [KET_IJIN] FROM [taIjin] WHERE ([KREDIT] = @KREDIT)">
        <SelectParameters>
            <asp:Parameter DefaultValue="1" Name="KREDIT" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:Panel ID="PNL_Lookup" runat="server" Style="border-right: black 2px solid; padding-right: 20px;
        border-top: black 2px solid; display: none; padding-left: 20px; padding-bottom: 20px;
        border-left: black 2px solid; width: 600px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small"></asp:Label> 
<HR />
<asp:Label id="lblLookupCariPegawai" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblNama %>" Font-Size="Small"></asp:Label> <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False"></asp:Button><br /><br /><table><tbody><tr><td colspan=2><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" OnDataBound="GvLookupPegawai_DataBound" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NIP"><Columns>
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
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]" ConnectionString="<%$ ConnectionStrings:strCn %>"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan=2><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" AlternateText="<%$ Resources:Resource, lblClose %>" ImageUrl="~/images/exit4_16.png"></asp:ImageButton> <asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
                <asp:Label ID="lblConfirmUpdateJatahIjin" runat="server" Text="<%$ Resources:lblConfirmationUpdateJatahIjin %>"
                    Visible="False"></asp:Label><asp:Label ID="lblConfirmHangusJatahIjin" runat="server" Text="<%$ Resources:lblConfirmationHangusJatahIjin %>"
                    Visible="False"></asp:Label><br />
                <asp:Label ID="lblTambahJumlahJatahIjin" runat="server" Text="<%$ Resources:lblTambahJumlahJatahIjin %>"
                    Visible="False" width="330px"></asp:Label><asp:Label ID="lblPotongJumlahJatahIjin" runat="server" Text="<%$ Resources:lblPotongJumlahJatahIjin %>" Visible="False"></asp:Label><asp:Label ID="lblPotongSisaJumlahJatahIjin" runat="server" Text="<%$ Resources:lblPotongSisaJumlahJatahIjin %>"
                    Visible="False"></asp:Label><asp:Label ID="lblPerpanjangJumlahJatahIjin" runat="server" Text="<%$ Resources:lblPerpanjanganJumlahJatahIjin %>"
                    Visible="False"></asp:Label>
    <asp:Label ID="lblProsesGagal" runat="server" Text="<%$ Resources:lblProsesGagal %>"
        Visible="False"></asp:Label>
   
</asp:Content>



