<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="shift.aspx.cs" Inherits="rtwin.shift" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<TABLE id="TABLE1"><TBODY><TR><TD style="WIDTH: 100%; HEIGHT: 100%"><TABLE style="WIDTH: 100%"><TBODY><TR><TD vAlign=top align=left><TABLE style="TEXT-ALIGN: left"><TBODY><TR><TD class="backgroundTitle"><IMG style="VERTICAL-ALIGN: middle" height=27 alt="" src="images/back_title.gif" />&nbsp; <asp:Label id="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle1 %>" width="230px"></asp:Label> <asp:Label id="Label23" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle2 %>" width="180px" __designer:wfdid="w1"></asp:Label> </TD></TR></TBODY></TABLE></TD></TR><TR><TD style="WIDTH: 100%; HEIGHT: 13px" align=left><asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label></TD></TR><TR><TD><TABLE><TBODY><TR><TD style="WIDTH: 60px; HEIGHT: 21px" align=center><asp:LinkButton id="lblPageMingguan" onclick="LinkButton1_Click" runat="server" CssClass="fontR" SkinID="fontR" Text="<%$ Resources:Weekly %>" CausesValidation="False"></asp:LinkButton></TD><TD style="WIDTH: 60px; HEIGHT: 21px" align=center><asp:LinkButton id="lblPageHarian" onclick="LinkButton2_Click" runat="server" CssClass="fontR" SkinID="fontR" Text="<%$ Resources:Daily %>" CausesValidation="False"></asp:LinkButton></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE><TABLE class="border_table" cellSpacing=0 cellPadding=0 border=0><TBODY><TR><TD style="WIDTH: 100%"><asp:MultiView id="MultiView1" runat="server" OnActiveViewChanged="MultiView1_ActiveViewChanged"><asp:View id="View1" runat="server"><asp:ImageButton style="VERTICAL-ALIGN: middle" id="btnAdd" onclick="btnAdd_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton>&nbsp;<asp:LinkButton id="lblTambah_1" onclick="lblTambah_1_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="gvMingguan" runat="server" DataSourceID="ds_Shift" EmptyDataText="<%$ Resources:lblEmptyData %>" AllowSorting="True" AllowPaging="True" DataKeyNames="Kode_Shift" AutoGenerateColumns="False" OnDataBound="gvMingguan_DataBound" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="gvMingguan_RowCommand">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_SHIFT" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>

<ItemStyle HorizontalAlign="Left"></ItemStyle>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Eval("Kode_Shift") %>' __designer:wfdid="w50"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_GROUP" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
&nbsp;
</EditItemTemplate>

<ItemStyle HorizontalAlign="Left"></ItemStyle>

<HeaderStyle Width="140px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label2" runat="server" Text='<%# Eval("Nama_Group") %>' __designer:wfdid="w489"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LIBUR_NASIONAL" HeaderText="<%$ Resources:lblLibur %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label24" runat="server" Text='<%# Bind("KET_LIBUR") %>' __designer:wfdid="w491"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_CABANG" HeaderText="<%$ Resources:Column6 %>">
<HeaderStyle Width="120px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label10" runat="server" Text='<%# Bind("NAMA_CABANG") %>' __designer:wfdid="w525"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Minggu" HeaderText="<%$ Resources:Minggu %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label3" runat="server" Text='<%# Bind("Minggu") %>' __designer:wfdid="w492"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Senin" HeaderText="<%$ Resources:Senin %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label4" runat="server" Text='<%# Bind("Senin") %>' __designer:wfdid="w506"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Selasa" HeaderText="<%$ Resources:Selasa %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label5" runat="server" Text='<%# Bind("Selasa") %>' __designer:wfdid="w496"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Rabu" HeaderText="<%$ Resources:Rabu %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label6" runat="server" Text='<%# Bind("Rabu") %>' __designer:wfdid="w498"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Kamis" HeaderText="<%$ Resources:Kamis %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label7" runat="server" Text='<%# Bind("Kamis") %>' __designer:wfdid="w500"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Jumat" HeaderText="<%$ Resources:Jumat %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label8" runat="server" Text='<%# Bind("Jumat") %>' __designer:wfdid="w502"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="Sabtu" HeaderText="<%$ Resources:Sabtu %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>

<HeaderStyle Width="60px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label9" runat="server" Text='<%# Bind("Sabtu") %>' __designer:wfdid="w504"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column4 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" __designer:wfdid="w51" ImageUrl="~/Images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit_Mingguan" CommandArgument='<%# Eval("KODE_SHIFT") %>'></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column5 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="btnDelete" runat="server" CausesValidation="False" __designer:wfdid="w52" ImageUrl="~/Images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w53" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="btnDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w54" targetcontrolid="btnDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" __designer:wfdid="w508" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" __designer:wfdid="w509" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w510"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3" __designer:wfdid="w511"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w512"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w513"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" __designer:wfdid="w514" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" __designer:wfdid="w515" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<RowStyle HorizontalAlign="Center"></RowStyle>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="ds_Shift" runat="server" SelectCommand="SELECT taPola.KODE_SHIFT, taPola.NAMA_GROUP, taPola.LIBUR_NASIONAL, CASE WHEN taPola.LIBUR_NASIONAL = 1 THEN 'Ya' ELSE 'Tidak' END AS KET_LIBUR, CASE WHEN taPola.KODE_DEPARTEMEN = '---' THEN 'GLOBAL' ELSE taCabang.NAMA_CABANG END AS NAMA_CABANG, SUBSTRING(taPola.FORMAT, 1, 2) AS Minggu, SUBSTRING(taPola.FORMAT, 3, 2) AS Senin, SUBSTRING(taPola.FORMAT, 5, 2) AS Selasa, SUBSTRING(taPola.FORMAT, 7, 2) AS Rabu, SUBSTRING(taPola.FORMAT, 9, 2) AS Kamis, SUBSTRING(taPola.FORMAT, 11, 2) AS Jumat, SUBSTRING(taPola.FORMAT, 13, 2) AS Sabtu, taPola.KODE_DEPARTEMEN FROM taPola LEFT OUTER JOIN taCabang ON taPola.KODE_DEPARTEMEN = taCabang.KODE_CABANG WHERE (SUBSTRING(taPola.KODE_SHIFT, 1, 1) = 'M')" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taPola WHERE (KODE_SHIFT = @KODE_SHIFT)" InsertCommand="INSERT INTO taPola(KODE_SHIFT, TGL_MULAI, NAMA_GROUP, LIBUR_NASIONAL, FORMAT, KODE_DEPARTEMEN) VALUES (@KODE_SHIFT, GETDATE(), @NAMA_GROUP, @LIBUR_NASIONAL, @FORMAT, @KODE_DEPARTEMEN)" OnDeleted="ds_Shift_Deleted" OnInserted="ds_shift2_Inserted" OnInserting="ds_shift2_Inserting" UpdateCommand="UPDATE taPola SET NAMA_GROUP = @NAMA_GROUP, LIBUR_NASIONAL = @LIBUR_NASIONAL,FORMAT = @FORMAT, KODE_DEPARTEMEN=@KODE_DEPARTEMEN WHERE (KODE_SHIFT = @KODE_SHIFT)" OnUpdating="ds_Shift_Updating" OnUpdated="ds_Shift_Updated"><DeleteParameters>
<asp:Parameter Name="KODE_SHIFT"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="NAMA_GROUP"></asp:Parameter>
<asp:Parameter Name="LIBUR_NASIONAL"></asp:Parameter>
<asp:Parameter Name="FORMAT"></asp:Parameter>
<asp:Parameter Name="KODE_DEPARTEMEN"></asp:Parameter>
<asp:Parameter Name="KODE_SHIFT"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_SHIFT"></asp:Parameter>
<asp:Parameter Name="NAMA_GROUP"></asp:Parameter>
<asp:Parameter Name="LIBUR_NASIONAL"></asp:Parameter>
<asp:Parameter Name="FORMAT"></asp:Parameter>
<asp:Parameter Name="KODE_DEPARTEMEN"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> <asp:FormView id="fvInsertMingguan" runat="server" DataSourceID="ds_Shift" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="KODE_SHIFT" DefaultMode="Insert" OnItemCommand="fvInsertMingguan_ItemCommand"><EditItemTemplate>
<table __designer:dtid="562949953421329"><tbody><tr __designer:dtid="562949953421330"><td __designer:dtid="562949953421331"><table __designer:dtid="562949953421332"><tbody><tr __designer:dtid="562949953421333"><td style="WIDTH: 120px" __designer:dtid="562949953421334"><asp:Label id="Label10" runat="server" Text="<%$ Resources:Shift %>" __designer:dtid="562949953421335" __designer:wfdid="w65"></asp:Label></td><td __designer:dtid="562949953421336"><asp:Label id="lblPola" runat="server" Text='<%# Eval("KODE_SHIFT") %>' __designer:dtid="562949953421337" __designer:wfdid="w66"></asp:Label></td></tr><tr __designer:dtid="562949953421338"><td style="WIDTH: 120px; HEIGHT: 42px" __designer:dtid="562949953421339"><asp:Label id="Label12" runat="server" Text="<%$ Resources:Group %>" width="117px" __designer:dtid="562949953421340" __designer:wfdid="w67"></asp:Label></td><td style="HEIGHT: 42px" __designer:dtid="562949953421341"><asp:TextBox id="Nama_GroupTextBox" runat="server" Text='<%# Bind("NAMA_GROUP") %>' __designer:dtid="562949953421342" __designer:wfdid="w68"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server" CssClass="fontR" SkinID="fontR" width="160px" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="Nama_GroupTextBox" __designer:dtid="562949953421343" __designer:wfdid="w69" SetFocusOnError="True"></asp:RequiredFieldValidator></td></tr><tr __designer:dtid="562949953421344"><td style="WIDTH: 120px" __designer:dtid="562949953421345"><asp:Label id="Label27" runat="server" Text="<%$ Resources:Direktorat %>" __designer:dtid="562949953421346" __designer:wfdid="w70"></asp:Label></td><td __designer:dtid="562949953421347"><asp:DropDownList id="DropDownList32" runat="server" DataSourceID="dsCabang" __designer:dtid="562949953421348" __designer:wfdid="w71" SelectedValue='<%# Bind("KODE_DEPARTEMEN") %>' DataValueField="KODE_CABANG" DataTextField="NAMA_CABANG"></asp:DropDownList></td></tr><tr __designer:dtid="562949953421349"><td style="WIDTH: 120px" __designer:dtid="562949953421350"><asp:Label id="Label2" runat="server" Text="<%$ Resources:lblLibur %>" width="120px" __designer:dtid="562949953421351" __designer:wfdid="w72"></asp:Label></td><td __designer:dtid="562949953421352"><asp:CheckBox id="CheckBox1" runat="server" __designer:dtid="562949953421353" __designer:wfdid="w73" Checked='<%# Bind("LIBUR_NASIONAL") %>'></asp:CheckBox></td></tr></tbody></table></td></tr><tr __designer:dtid="562949953421359"><td class="listBorder" __designer:dtid="562949953421360"><table __designer:dtid="562949953421361"><tbody><tr __designer:dtid="562949953421362"><td style="WIDTH: 100px" __designer:dtid="562949953421363">&nbsp;<asp:Label id="Label13" runat="server" Text="<%$ Resources:Minggu %>" __designer:dtid="562949953421364" __designer:wfdid="w74"></asp:Label></td><td __designer:dtid="562949953421365"><asp:DropDownList id="DropDownList1" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421366" __designer:wfdid="w75" SelectedValue='<%# Bind("Minggu") %>' DataValueField="KODE_RANGE" DataTextField="Baru"><asp:ListItem __designer:dtid="562949953421367">00</asp:ListItem>
</asp:DropDownList></td></tr><tr __designer:dtid="562949953421368"><td style="WIDTH: 100px" __designer:dtid="562949953421369">&nbsp;<asp:Label id="Label14" runat="server" Text="<%$ Resources:Senin %>" __designer:dtid="562949953421370" __designer:wfdid="w76"></asp:Label></td><td __designer:dtid="562949953421371"><asp:DropDownList id="DropDownList2" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421372" __designer:wfdid="w77" SelectedValue='<%# Bind("Senin") %>' DataValueField="KODE_RANGE" DataTextField="Baru"></asp:DropDownList></td></tr><tr __designer:dtid="562949953421373"><td style="WIDTH: 100px" __designer:dtid="562949953421374">&nbsp;<asp:Label id="Label15" runat="server" Text="<%$ Resources:Selasa %>" __designer:dtid="562949953421375" __designer:wfdid="w78"></asp:Label></td><td __designer:dtid="562949953421376"><asp:DropDownList id="DropDownList3" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421377" __designer:wfdid="w79" SelectedValue='<%# Bind("Selasa") %>' DataValueField="KODE_RANGE" DataTextField="Baru">
                                    </asp:DropDownList></td></tr><tr __designer:dtid="562949953421378"><td style="WIDTH: 100px" __designer:dtid="562949953421379">&nbsp;<asp:Label id="Label16" runat="server" Text="<%$ Resources:Rabu %>" __designer:dtid="562949953421380" __designer:wfdid="w80"></asp:Label></td><td __designer:dtid="562949953421381"><asp:DropDownList id="DropDownList4" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421382" __designer:wfdid="w81" SelectedValue='<%# Bind("Rabu") %>' DataValueField="KODE_RANGE" DataTextField="Baru">
                                    </asp:DropDownList></td></tr><tr __designer:dtid="562949953421383"><td style="WIDTH: 100px" __designer:dtid="562949953421384">&nbsp;<asp:Label id="Label17" runat="server" Text="<%$ Resources:Kamis %>" __designer:dtid="562949953421385" __designer:wfdid="w82"></asp:Label></td><td __designer:dtid="562949953421386"><asp:DropDownList id="DropDownList5" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421387" __designer:wfdid="w83" SelectedValue='<%# Bind("Kamis") %>' DataValueField="KODE_RANGE" DataTextField="Baru">
                                    </asp:DropDownList></td></tr><tr __designer:dtid="562949953421388"><td style="WIDTH: 100px" __designer:dtid="562949953421389">&nbsp;<asp:Label id="Label18" runat="server" Text="<%$ Resources:Jumat %>" __designer:dtid="562949953421390" __designer:wfdid="w84"></asp:Label></td><td __designer:dtid="562949953421391"><asp:DropDownList id="DropDownList6" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421392" __designer:wfdid="w85" SelectedValue='<%# Bind("Jumat") %>' DataValueField="KODE_RANGE" DataTextField="Baru">
                                    </asp:DropDownList></td></tr><tr __designer:dtid="562949953421393"><td style="WIDTH: 100px" __designer:dtid="562949953421394">&nbsp;<asp:Label id="Label19" runat="server" Text="<%$ Resources:Sabtu %>" __designer:dtid="562949953421395" __designer:wfdid="w86"></asp:Label></td><td __designer:dtid="562949953421396"><asp:DropDownList id="DropDownList7" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421397" __designer:wfdid="w87" SelectedValue='<%# Bind("Sabtu") %>' DataValueField="KODE_RANGE" DataTextField="Baru">
                                    </asp:DropDownList></td></tr><tr __designer:dtid="562949953421398"><td valign=bottom align=left colspan=2 __designer:dtid="562949953421399">&nbsp; </td></tr><tr __designer:dtid="562949953421400"><td valign=bottom align=left colspan=2 __designer:dtid="562949953421401">&nbsp;<asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton4" runat="server" __designer:dtid="562949953421402" __designer:wfdid="w88" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Update"></asp:ImageButton> <asp:LinkButton id="lbInsert" runat="server" Text="<%$ Resources:ImgUpdate %>" __designer:dtid="562949953421403" __designer:wfdid="w89" CommandName="Update"></asp:LinkButton> &nbsp;&nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton5" runat="server" CausesValidation="False" __designer:dtid="562949953421404" __designer:wfdid="w90" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Edit_Mingguan"></asp:ImageButton>&nbsp;<asp:LinkButton id="lbCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:dtid="562949953421405" __designer:wfdid="w91" CommandName="Cancel_Edit_Mingguan"></asp:LinkButton></td></tr><tr __designer:dtid="562949953421406"><td valign=bottom align=left colspan=2 __designer:dtid="562949953421407">&nbsp; </td></tr></tbody></table></td></tr></tbody></table>
</EditItemTemplate>
<InsertItemTemplate>
<TABLE><TBODY><TR><TD><TABLE><TBODY><TR><TD style="WIDTH: 120px"><asp:Label id="Label10" runat="server" Text="<%$ Resources:Shift %>" __designer:wfdid="w55"></asp:Label></TD><TD><asp:Label id="lblPola" runat="server" Text="<%$ Resources:M %>" __designer:wfdid="w56"></asp:Label></TD></TR><TR><TD style="WIDTH: 120px; HEIGHT: 42px"><asp:Label id="Label11" runat="server" Text="<%$ Resources:Group %>" __designer:wfdid="w57"></asp:Label></TD><TD style="HEIGHT: 42px"><asp:TextBox id="txtGroup" runat="server" __designer:wfdid="w58" Columns="3" MaxLength="3"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" CssClass="fontR" SkinID="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtGroup" __designer:wfdid="w59" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD style="WIDTH: 120px"><asp:Label id="Label12" runat="server" Text="<%$ Resources:Column1 %>" width="89px" __designer:wfdid="w60"></asp:Label></TD><TD><asp:TextBox id="Nama_GroupTextBox" runat="server" Text='<%# Bind("NAMA_GROUP") %>' __designer:wfdid="w61" Columns="20" MaxLength="20"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" CssClass="fontR" SkinID="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="Nama_GroupTextBox" __designer:wfdid="w62" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD style="WIDTH: 120px; HEIGHT: 24px"><asp:Label id="Label27" runat="server" Text="<%$ Resources:Direktorat %>" __designer:wfdid="w63"></asp:Label></TD><TD style="HEIGHT: 24px"><asp:DropDownList id="DropDownList32" runat="server" DataSourceID="dsCabang" __designer:wfdid="w64" DataTextField="NAMA_CABANG" DataValueField="KODE_CABANG" SelectedValue='<%# Bind("KODE_DEPARTEMEN") %>'></asp:DropDownList></TD></TR><TR><TD style="WIDTH: 120px"><asp:Label id="Label25" runat="server" Text="<%$ Resources:lblLibur %>" width="120px" __designer:wfdid="w65"></asp:Label></TD><TD><asp:CheckBox id="CheckBox1" runat="server" __designer:wfdid="w66" Checked='<%# Bind("LIBUR_NASIONAL") %>'></asp:CheckBox></TD></TR></TBODY></TABLE></TD></TR><TR><TD class="listBorder"><TABLE><TBODY><TR><TD style="WIDTH: 100px"><asp:Label id="Label13" runat="server" Text="<%$ Resources:Minggu %>" __designer:wfdid="w67"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="DropDownList1" runat="server" DataSourceID="ds_RangeforDropDown" __designer:wfdid="w68" DataTextField="Baru" DataValueField="KODE_RANGE"><asp:ListItem>00</asp:ListItem>
</asp:DropDownList></TD></TR><TR><TD style="WIDTH: 100px"><asp:Label id="Label14" runat="server" Text="<%$ Resources:Senin %>" __designer:wfdid="w69"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="DropDownList2" runat="server" DataSourceID="ds_RangeforDropDown" __designer:wfdid="w70" DataTextField="Baru" DataValueField="KODE_RANGE">
                        </asp:DropDownList></TD></TR><TR><TD style="WIDTH: 100px"><asp:Label id="Label15" runat="server" Text="<%$ Resources:Selasa %>" __designer:wfdid="w71"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="DropDownList3" runat="server" DataSourceID="ds_RangeforDropDown" __designer:wfdid="w72" DataTextField="Baru" DataValueField="KODE_RANGE">
                        </asp:DropDownList></TD></TR><TR><TD style="WIDTH: 100px"><asp:Label id="Label16" runat="server" Text="<%$ Resources:Rabu %>" __designer:wfdid="w73"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="DropDownList4" runat="server" DataSourceID="ds_RangeforDropDown" __designer:wfdid="w74" DataTextField="Baru" DataValueField="KODE_RANGE">
                        </asp:DropDownList></TD></TR><TR><TD style="WIDTH: 100px"><asp:Label id="Label17" runat="server" Text="<%$ Resources:Kamis %>" __designer:wfdid="w75"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="DropDownList5" runat="server" DataSourceID="ds_RangeforDropDown" __designer:wfdid="w76" DataTextField="Baru" DataValueField="KODE_RANGE">
                        </asp:DropDownList></TD></TR><TR><TD style="WIDTH: 100px"><asp:Label id="Label18" runat="server" Text="<%$ Resources:Jumat %>" __designer:wfdid="w77"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="DropDownList6" runat="server" DataSourceID="ds_RangeforDropDown" __designer:wfdid="w78" DataTextField="Baru" DataValueField="KODE_RANGE">
                        </asp:DropDownList></TD></TR><TR><TD style="WIDTH: 100px"><asp:Label id="Label19" runat="server" Text="<%$ Resources:Sabtu %>" __designer:wfdid="w79"></asp:Label></TD><TD style="WIDTH: 100px"><asp:DropDownList id="DropDownList7" runat="server" DataSourceID="ds_RangeforDropDown" __designer:wfdid="w80" DataTextField="Baru" DataValueField="KODE_RANGE">
                        </asp:DropDownList></TD></TR><TR><TD align=left colSpan=2>&nbsp; &nbsp; &nbsp; &nbsp;&nbsp; </TD></TR><TR><TD style="HEIGHT: 8px" vAlign=bottom align=left colSpan=2><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton4" runat="server" __designer:wfdid="w81" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton> <asp:LinkButton id="lbSimpan_1" runat="server" Text="<%$ Resources:ImgInsert %>" __designer:wfdid="w82" CommandName="Insert">Simpan</asp:LinkButton> &nbsp; &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton5" runat="server" CausesValidation="False" __designer:wfdid="w83" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Mingguan"></asp:ImageButton>&nbsp; <asp:LinkButton id="lbCancel_1" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w84" CommandName="Cancel_Mingguan"></asp:LinkButton></TD></TR><TR><TD style="HEIGHT: 16px" vAlign=bottom align=left colSpan=2></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView></asp:View> <asp:View id="View2" runat="server"><asp:ImageButton style="VERTICAL-ALIGN: middle" id="btnAdd2" onclick="btnAdd2_Click" runat="server" ImageUrl="~/Images/ipost.gif" AlternateText="<%$ Resources:ImgAdd %>"></asp:ImageButton> <asp:LinkButton id="lblTambah_2" onclick="lblTambah_2_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton><BR /><BR /><asp:GridView id="gvHarian" runat="server" DataSourceID="ds_shift3" EmptyDataText="<%$ Resources:lblEmptyData %>" AllowSorting="True" AllowPaging="True" DataKeyNames="KODE_SHIFT" AutoGenerateColumns="False" OnDataBound="gvHarian_DataBound" OnRowDataBound="GridView1_RowDataBound" OnRowCommand="gvMingguan_RowCommand">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="KODE_SHIFT" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("KODE_SHIFT") %>' id="Label1"></asp:Label>
</EditItemTemplate>

<ItemStyle horizontalalign="Left"></ItemStyle>

<HeaderStyle width="40px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("KODE_SHIFT") %>' id="Label3"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_MULAI" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TGL_MULAI") %>'></asp:TextBox>
                                    
</EditItemTemplate>

<HeaderStyle width="80px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("TGL_MULAI", "{0:d}") %>' __designer:wfdid="w112"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_GROUP" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox runat="server" Text='<%# Bind("NAMA_GROUP") %>' id="TextBox2"></asp:TextBox>
</EditItemTemplate>

<ItemStyle horizontalalign="Left"></ItemStyle>

<HeaderStyle width="140px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("NAMA_GROUP") %>' id="Label4"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_CABANG" HeaderText="<%$ Resources:Column6 %>"><EditItemTemplate>
<asp:TextBox runat="server" Text='<%# Bind("NAMA_CABANG") %>' id="TextBox3"></asp:TextBox>
</EditItemTemplate>

<HeaderStyle width="120px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("NAMA_CABANG") %>' id="Label5"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LIBUR_NASIONAL" HeaderText="<%$ Resources:lblLibur %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="80px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label2" runat="server" Text='<%# Bind("KET_LIBUR") %>' __designer:wfdid="w70"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h01" HeaderText="01"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h01") %>' id="Label2"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h01") %>' id="Label6"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h02" HeaderText="02"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h02") %>' id="Label3"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h02") %>' id="Label7"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h03" HeaderText="03"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h03") %>' id="Label4"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h03") %>' id="Label8"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h04" HeaderText="04"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h04") %>' id="Label5"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h04") %>' id="Label9"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h05" HeaderText="05"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h05") %>' id="Label6"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h05") %>' id="Label10"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h06" HeaderText="06"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h06") %>' id="Label7"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h06") %>' id="Label11"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h07" HeaderText="07"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h07") %>' id="Label8"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h07") %>' id="Label12"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h08" HeaderText="08"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h08") %>' id="Label9"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h08") %>' id="Label13"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h09" HeaderText="09"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h09") %>' id="Label10"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h09") %>' id="Label14"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h10" HeaderText="10"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h10") %>' id="Label11"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h10") %>' id="Label15"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h11" HeaderText="11"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h11") %>' id="Label12"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h11") %>' id="Label16"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h12" HeaderText="12"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h12") %>' id="Label13"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h12") %>' id="Label17"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h13" HeaderText="13"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h13") %>' id="Label14"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h13") %>' id="Label18"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h14" HeaderText="14"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h14") %>' id="Label15"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h14") %>' id="Label19"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h15" HeaderText="15"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h15") %>' id="Label16"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h15") %>' id="Label20"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h16" HeaderText="16"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h16") %>' id="Label17"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h16") %>' id="Label21"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h17" HeaderText="17"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h17") %>' id="Label18"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h17") %>' id="Label22"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h18" HeaderText="18"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h18") %>' id="Label19"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h18") %>' id="Label23"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h19" HeaderText="19"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h19") %>' id="Label20"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h19") %>' id="Label24"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h20" HeaderText="20"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h20") %>' id="Label21"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h20") %>' id="Label25"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h21" HeaderText="21"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h21") %>' id="Label22"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h21") %>' id="Label26"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h22" HeaderText="22"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h22") %>' id="Label23"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h22") %>' id="Label27"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h23" HeaderText="23"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h23") %>' id="Label24"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h23") %>' id="Label28"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h24" HeaderText="24"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h24") %>' id="Label25"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h24") %>' id="Label29"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h25" HeaderText="25"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h25") %>' id="Label26"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h25") %>' id="Label30"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h26" HeaderText="26"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h26") %>' id="Label27"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h26") %>' id="Label31"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h27" HeaderText="27"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h27") %>' id="Label28"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h27") %>' id="Label32"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h28" HeaderText="28"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h28") %>' id="Label29"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h28") %>' id="Label33"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h29" HeaderText="29"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h29") %>' id="Label30"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h29") %>' id="Label34"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h30" HeaderText="30"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h30") %>' id="Label31"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h30") %>' id="Label35"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="h31" HeaderText="31"><EditItemTemplate>
<asp:Label runat="server" Text='<%# Eval("h31") %>' id="Label32"></asp:Label>
</EditItemTemplate>

<HeaderStyle width="20px"></HeaderStyle>
<ItemTemplate>
<asp:Label runat="server" Text='<%# Bind("h31") %>' id="Label36"></asp:Label>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column4 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" __designer:wfdid="w111" AlternateText="<%$ Resources:ImgEdit %>" ImageUrl="~/Images/iedit.gif" CommandArgument='<%# Eval("KODE_SHIFT") %>' CommandName="Edit_Harian"></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column5 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="btnDelete" runat="server" CausesValidation="False" __designer:wfdid="w65" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w66" targetcontrolid="btnDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w67" targetcontrolid="btnDelete" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfrst" runat="server" __designer:wfdid="w125" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> <asp:ImageButton id="btnprevs" runat="server" __designer:wfdid="w126" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton>&nbsp;<asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w127"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" width="44px" __designer:wfdid="w128" OnTextChanged="txhal_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w129"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w130"></asp:Label>&nbsp;<asp:ImageButton id="btnnexts" runat="server" __designer:wfdid="w131" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" __designer:wfdid="w132" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> &nbsp; 
</PagerTemplate>

<RowStyle horizontalalign="Center"></RowStyle>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="ds_shift3" runat="server" SelectCommand="SELECT taPola.KODE_SHIFT, taPola.TGL_MULAI, taPola.NAMA_GROUP, taPola.LIBUR_NASIONAL, CASE WHEN LIBUR_NASIONAL = 1 THEN 'Ya' ELSE 'Tidak' END AS KET_LIBUR, CASE WHEN taPola.KODE_DEPARTEMEN = '---' THEN 'GLOBAL' ELSE taCabang.NAMA_CABANG END AS NAMA_CABANG, SUBSTRING(taPola.FORMAT, 1, 2) AS h01, SUBSTRING(taPola.FORMAT, 3, 2) AS h02, SUBSTRING(taPola.FORMAT, 5, 2) AS h03, SUBSTRING(taPola.FORMAT, 7, 2) AS h04, SUBSTRING(taPola.FORMAT, 9, 2) AS h05, SUBSTRING(taPola.FORMAT, 11, 2) AS h06, SUBSTRING(taPola.FORMAT, 13, 2) AS h07, SUBSTRING(taPola.FORMAT, 15, 2) AS h08, SUBSTRING(taPola.FORMAT, 17, 2) AS h09, SUBSTRING(taPola.FORMAT, 19, 2) AS h10, SUBSTRING(taPola.FORMAT, 21, 2) AS h11, SUBSTRING(taPola.FORMAT, 23, 2) AS h12, SUBSTRING(taPola.FORMAT, 25, 2) AS h13, SUBSTRING(taPola.FORMAT, 27, 2) AS h14, SUBSTRING(taPola.FORMAT, 29, 2) AS h15, SUBSTRING(taPola.FORMAT, 31, 2) AS h16, SUBSTRING(taPola.FORMAT, 33, 2) AS h17, SUBSTRING(taPola.FORMAT, 35, 2) AS h18, SUBSTRING(taPola.FORMAT, 37, 2) AS h19, SUBSTRING(taPola.FORMAT, 39, 2) AS h20, SUBSTRING(taPola.FORMAT, 41, 2) AS h21, SUBSTRING(taPola.FORMAT, 43, 2) AS h22, SUBSTRING(taPola.FORMAT, 45, 2) AS h23, SUBSTRING(taPola.FORMAT, 47, 2) AS h24, SUBSTRING(taPola.FORMAT, 49, 2) AS h25, SUBSTRING(taPola.FORMAT, 51, 2) AS h26, SUBSTRING(taPola.FORMAT, 53, 2) AS h27, SUBSTRING(taPola.FORMAT, 55, 2) AS h28, SUBSTRING(taPola.FORMAT, 57, 2) AS h29, SUBSTRING(taPola.FORMAT, 59, 2) AS h30, SUBSTRING(taPola.FORMAT, 61, 2) AS h31, taPola.KODE_DEPARTEMEN FROM taPola LEFT OUTER JOIN taCabang ON taPola.KODE_DEPARTEMEN = taCabang.KODE_CABANG WHERE (SUBSTRING(taPola.KODE_SHIFT, 1, 1) = 'N')" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taPola WHERE (KODE_SHIFT = @KODE_SHIFT)" InsertCommand="INSERT INTO taPola(KODE_SHIFT, TGL_MULAI, NAMA_GROUP, LIBUR_NASIONAL, FORMAT, KODE_DEPARTEMEN) VALUES (@KODE_SHIFT, @TGL_MULAI, @NAMA_GROUP, @LIBUR_NASIONAL, @FORMAT, @KODE_DEPARTEMEN)" OnDeleted="ds_Shift_Deleted" OnInserted="ds_shift3_Inserted" OnInserting="ds_shift3_Inserting" UpdateCommand="UPDATE [taPola] SET [TGL_MULAI] = @TGL_MULAI, [NAMA_GROUP] = @NAMA_GROUP, [LIBUR_NASIONAL] = @LIBUR_NASIONAL,[FORMAT] = @FORMAT, [KODE_DEPARTEMEN] = @KODE_DEPARTEMEN WHERE [KODE_SHIFT] = @KODE_SHIFT" OnUpdating="ds_shift3_Updating" OnUpdated="ds_Shift_Updated"><DeleteParameters>
<asp:Parameter Name="KODE_SHIFT"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="TGL_MULAI"></asp:Parameter>
<asp:Parameter Name="NAMA_GROUP"></asp:Parameter>
<asp:Parameter Name="LIBUR_NASIONAL"></asp:Parameter>
<asp:Parameter Name="FORMAT"></asp:Parameter>
<asp:Parameter Name="KODE_DEPARTEMEN"></asp:Parameter>
<asp:Parameter Name="KODE_SHIFT"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_SHIFT"></asp:Parameter>
<asp:Parameter Name="TGL_MULAI"></asp:Parameter>
<asp:Parameter Name="NAMA_GROUP"></asp:Parameter>
<asp:Parameter Name="LIBUR_NASIONAL"></asp:Parameter>
<asp:Parameter Name="FORMAT"></asp:Parameter>
<asp:Parameter Name="KODE_DEPARTEMEN"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource> <asp:FormView id="fvInsertHarian" runat="server" Visible="False" DataSourceID="ds_shift3" DataKeyNames="KODE_SHIFT" OnDataBound="FormView2_Load" DefaultMode="Insert" OnItemCommand="fvInsertMingguan_ItemCommand"><EditItemTemplate>
<TABLE width="100%" __designer:dtid="562949953421330"><TBODY><TR __designer:dtid="562949953421331"><TD __designer:dtid="562949953421332"><TABLE width="100%" __designer:dtid="562949953421333"><TBODY><TR __designer:dtid="562949953421334"><TD style="WIDTH: 120px" __designer:dtid="562949953421335"><asp:Label id="Label1" runat="server" Text="<%$ Resources:Shift %>" __designer:dtid="562949953421336" __designer:wfdid="w139"></asp:Label></TD><TD style="WIDTH: 240px" __designer:dtid="562949953421337"><asp:Label id="KODE_SHIFTLabel1" runat="server" Text='<%# Bind("KODE_SHIFT") %>' __designer:dtid="562949953421338" __designer:wfdid="w140"></asp:Label></TD></TR><TR __designer:dtid="562949953421339"><TD style="WIDTH: 120px" __designer:dtid="562949953421340"><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column2 %>" __designer:dtid="562949953421341" __designer:wfdid="w141"></asp:Label></TD><TD style="WIDTH: 240px" __designer:dtid="562949953421342"><asp:TextBox id="ASPxdeTglMulai" runat="server" Text='<%# Bind("TGL_MULAI", "{0:d}") %>' width="100px" __designer:wfdid="w142" Columns="10" MaxLength="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgCol0Edit" runat="server" CausesValidation="False" __designer:wfdid="w143" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton>&nbsp;<asp:RequiredFieldValidator id="valCol0Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="ASPxdeTglMulai" __designer:wfdid="w144" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="ASPxdeTglMulai" __designer:wfdid="w145" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator><cc1:CalendarExtender id="cexCol0Edit" runat="server" CssClass="cal_Theme1" __designer:wfdid="w146" targetcontrolid="ASPxdeTglMulai" PopupButtonID="imgCol0Edit" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexTglMulai" runat="server" __designer:wfdid="w189" TargetControlID="ASPxdeTglMulai" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR __designer:dtid="562949953421345"><TD style="WIDTH: 120px" vAlign=middle align=left __designer:dtid="562949953421346"><asp:Label id="Label3" runat="server" Text="<%$ Resources:Group %>" width="87px" __designer:dtid="562949953421347" __designer:wfdid="w147"></asp:Label></TD><TD style="WIDTH: 240px" vAlign=top align=left __designer:dtid="562949953421348"><asp:TextBox id="NAMA_GROUPTextBox" runat="server" Text='<%# Bind("NAMA_GROUP") %>' __designer:dtid="562949953421349" __designer:wfdid="w148"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" CssClass="fontR" SkinID="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="NAMA_GROUPTextBox" __designer:dtid="562949953421350" __designer:wfdid="w149" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR __designer:dtid="562949953421351"><TD style="WIDTH: 120px" __designer:dtid="562949953421352"><asp:Label id="Label27" runat="server" Text="<%$ Resources:Direktorat %>" __designer:dtid="562949953421353" __designer:wfdid="w150"></asp:Label></TD><TD style="WIDTH: 240px" __designer:dtid="562949953421354"><asp:DropDownList id="DropDownList32" runat="server" DataSourceID="dsCabang" __designer:dtid="562949953421355" __designer:wfdid="w151" DataTextField="NAMA_CABANG" DataValueField="KODE_CABANG" SelectedValue='<%# Bind("KODE_DEPARTEMEN") %>'></asp:DropDownList></TD></TR><TR __designer:dtid="562949953421356"><TD style="WIDTH: 120px" vAlign=middle align=left __designer:dtid="562949953421357"><asp:Label id="Label4" runat="server" Text="<%$ Resources:lblLibur %>" width="120px" __designer:dtid="562949953421358" __designer:wfdid="w152"></asp:Label></TD><TD style="WIDTH: 240px" vAlign=top align=left __designer:dtid="562949953421359"><asp:CheckBox id="CheckBox1" runat="server" __designer:dtid="562949953421360" __designer:wfdid="w153" Checked='<%# Bind("LIBUR_NASIONAL") %>' Font-Underline="True"></asp:CheckBox></TD></TR></TBODY></TABLE></TD></TR><TR __designer:dtid="562949953421366"><TD style="HEIGHT: 264px" class="listBorder" __designer:dtid="562949953421367"><TABLE __designer:dtid="562949953421368"><TBODY><TR __designer:dtid="562949953421369"><TD __designer:dtid="562949953421370">1:<asp:DropDownList id="DropDownList1" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421371" __designer:wfdid="w154" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h01") %>' AppendDataBoundItems="True"><asp:ListItem></asp:ListItem>
</asp:DropDownList></TD><TD align=right __designer:dtid="562949953421372">9:<asp:DropDownList id="DropDownList9" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421373" __designer:wfdid="w155" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h09") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421374">17:<asp:DropDownList id="DropDownList17" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421375" __designer:wfdid="w156" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h17") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421376">25:<asp:DropDownList id="DropDownList25" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421377" __designer:wfdid="w157" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h25") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421378"><TD __designer:dtid="562949953421379">2:<asp:DropDownList id="DropDownList2" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421380" __designer:wfdid="w158" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h02") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
</asp:DropDownList></TD><TD __designer:dtid="562949953421381">10:<asp:DropDownList id="DropDownList10" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421382" __designer:wfdid="w159" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h10") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421383">18:<asp:DropDownList id="DropDownList18" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421384" __designer:wfdid="w160" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h18") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421385">26:<asp:DropDownList id="DropDownList26" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421386" __designer:wfdid="w161" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h26") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421387"><TD __designer:dtid="562949953421388">3:<asp:DropDownList id="DropDownList3" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421389" __designer:wfdid="w162" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h03") %>' AppendDataBoundItems="True"><asp:ListItem Selected="True"> </asp:ListItem>
</asp:DropDownList></TD><TD __designer:dtid="562949953421390">11:<asp:DropDownList id="DropDownList11" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421391" __designer:wfdid="w163" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h11") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421392">19:<asp:DropDownList id="DropDownList19" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421393" __designer:wfdid="w164" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h19") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421394">27:<asp:DropDownList id="DropDownList27" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421395" __designer:wfdid="w165" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h27") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421396"><TD __designer:dtid="562949953421397">4:<asp:DropDownList id="DropDownList4" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421398" __designer:wfdid="w166" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h04") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421399">12:<asp:DropDownList id="DropDownList12" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421400" __designer:wfdid="w167" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h12") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421401">20:<asp:DropDownList id="DropDownList20" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421402" __designer:wfdid="w168" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h20") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421403">28:<asp:DropDownList id="DropDownList28" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421404" __designer:wfdid="w169" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h28") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421405"><TD __designer:dtid="562949953421406">5:<asp:DropDownList id="DropDownList5" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421407" __designer:wfdid="w170" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h05") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421408">13:<asp:DropDownList id="DropDownList13" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421409" __designer:wfdid="w171" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h13") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421410">21:<asp:DropDownList id="DropDownList21" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421411" __designer:wfdid="w172" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h21") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421412">29:<asp:DropDownList id="DropDownList29" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421413" __designer:wfdid="w173" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h29") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421414"><TD __designer:dtid="562949953421415">6:<asp:DropDownList id="DropDownList6" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421416" __designer:wfdid="w174" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h06") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421417">14:<asp:DropDownList id="DropDownList14" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421418" __designer:wfdid="w175" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h14") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421419">22:<asp:DropDownList id="DropDownList22" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421420" __designer:wfdid="w176" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h22") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421421">30:<asp:DropDownList id="DropDownList30" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421422" __designer:wfdid="w177" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h30") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421423"><TD __designer:dtid="562949953421424">7:<asp:DropDownList id="DropDownList7" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421425" __designer:wfdid="w178" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h07") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421426">15:<asp:DropDownList id="DropDownList15" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421427" __designer:wfdid="w179" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h15") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421428">23:<asp:DropDownList id="DropDownList23" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421429" __designer:wfdid="w180" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h23") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421430">31:<asp:DropDownList id="DropDownList31" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421431" __designer:wfdid="w181" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h31") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421432"><TD __designer:dtid="562949953421433">8:<asp:DropDownList id="DropDownList8" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421434" __designer:wfdid="w182" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h08") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421435">16:<asp:DropDownList id="DropDownList16" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421436" __designer:wfdid="w183" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h16") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421437">24:<asp:DropDownList id="DropDownList24" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421438" __designer:wfdid="w184" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h24") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421439"></TD></TR><TR __designer:dtid="562949953421440"><TD vAlign=bottom align=left colSpan=4 __designer:dtid="562949953421441">&nbsp;</TD></TR><TR __designer:dtid="562949953421442"><TD vAlign=bottom align=left colSpan=4 __designer:dtid="562949953421443"><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton4" runat="server" __designer:dtid="562949953421444" __designer:wfdid="w185" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgUpdate %>" CommandName="Update"></asp:ImageButton> <asp:LinkButton id="lbUpdate" runat="server" Text="<%$ Resources:ImgUpdate %>" __designer:dtid="562949953421445" __designer:wfdid="w186" CommandName="Update">Update</asp:LinkButton> &nbsp; <asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton5" runat="server" CausesValidation="False" __designer:dtid="562949953421446" __designer:wfdid="w187" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Edit_Harian"></asp:ImageButton> <asp:LinkButton id="lbCancel" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:dtid="562949953421447" __designer:wfdid="w188" CommandName="Cancel_Edit_Harian"></asp:LinkButton></TD></TR><TR __designer:dtid="562949953421448"><TD vAlign=bottom align=left colSpan=4 __designer:dtid="562949953421449">&nbsp;</TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
</EditItemTemplate>
<InsertItemTemplate>
<TABLE style="WIDTH: 100%"><TBODY><TR><TD><TABLE width="100%"><TBODY><TR><TD style="WIDTH: 120px"><asp:Label id="Label10" runat="server" Text="<%$ Resources:Shift %>" __designer:wfdid="w85"></asp:Label></TD><TD><asp:Label id="lblPola" runat="server" Text="<%$ Resources:N %>" __designer:wfdid="w86"></asp:Label></TD></TR><TR><TD style="WIDTH: 120px"><asp:Label id="Label20" runat="server" Text="<%$ Resources:Group %>" __designer:wfdid="w87"></asp:Label></TD><TD style="WIDTH: 240px"><asp:TextBox id="TextBox1" runat="server" __designer:wfdid="w88" Columns="2" MaxLength="3"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" CssClass="fontR" SkinID="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="TextBox1" __designer:wfdid="w89" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD style="WIDTH: 120px"><asp:Label id="Label21" runat="server" Text="<%$ Resources:Column2 %>" width="130px" __designer:wfdid="w90"></asp:Label></TD><TD style="WIDTH: 240px"><asp:TextBox id="ASPxdeTglMulai" runat="server" Text='<%# Bind("TGL_MULAI", "{0:d}") %>' width="100px" __designer:wfdid="w91" Columns="10" MaxLength="10"></asp:TextBox><asp:ImageButton id="imgCol0Edit" runat="server" CausesValidation="False" __designer:wfdid="w92" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton><asp:RequiredFieldValidator id="valCol0Edit" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="ASPxdeTglMulai" __designer:wfdid="w93" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator id="valCol0_1Edit" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="ASPxdeTglMulai" __designer:wfdid="w94" EnableClientScript="True" SetFocusOnError="True" ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator><cc1:CalendarExtender id="cexCol0Edit" runat="server" CssClass="cal_Theme1" __designer:wfdid="w95" targetcontrolid="ASPxdeTglMulai" PopupButtonID="imgCol0Edit" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>"></cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexTglMulai" runat="server" __designer:wfdid="w138" TargetControlID="ASPxdeTglMulai" MaskType="Date" Mask="99/99/9999"></cc1:MaskedEditExtender></TD></TR><TR><TD style="WIDTH: 120px"><asp:Label id="Label22" runat="server" Text="<%$ Resources:Column1 %>" width="120px" __designer:wfdid="w96"></asp:Label></TD><TD style="WIDTH: 340px"><asp:TextBox id="NAMA_GROUPTextBox" runat="server" Text='<%# Bind("NAMA_GROUP") %>' __designer:wfdid="w97"></asp:TextBox> <asp:RequiredFieldValidator id="RequiredFieldValidator4" runat="server" CssClass="fontR" SkinID="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="NAMA_GROUPTextBox" __designer:wfdid="w98" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></TD></TR><TR><TD style="WIDTH: 120px"><asp:Label id="Label27" runat="server" Text="<%$ Resources:Direktorat %>" __designer:wfdid="w99"></asp:Label></TD><TD><asp:DropDownList id="DropDownList32" runat="server" DataSourceID="dsCabang" __designer:wfdid="w100" DataTextField="NAMA_CABANG" DataValueField="KODE_CABANG" SelectedValue='<%# Bind("KODE_DEPARTEMEN") %>'></asp:DropDownList></TD></TR><TR><TD style="WIDTH: 120px"><asp:Label id="Label26" runat="server" Text="<%$ Resources:lblLibur %>" width="120px" __designer:wfdid="w101"></asp:Label></TD><TD style="WIDTH: 240px"><asp:CheckBox id="CheckBox2" runat="server" __designer:wfdid="w102" Checked='<%# Bind("LIBUR_NASIONAL") %>'></asp:CheckBox></TD></TR></TBODY></TABLE></TD></TR><TR><TD style="WIDTH: 100px" class="listBorder" align=center><TABLE __designer:dtid="562949953421368"><TBODY><TR __designer:dtid="562949953421369"><TD __designer:dtid="562949953421370">1:<asp:DropDownList id="DropDownList1" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421371" __designer:wfdid="w103" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h01") %>' AppendDataBoundItems="True"><asp:ListItem Selected="True"></asp:ListItem>
</asp:DropDownList></TD><TD align=right __designer:dtid="562949953421372">9:<asp:DropDownList id="DropDownList9" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421373" __designer:wfdid="w104" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h09") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421374">17:<asp:DropDownList id="DropDownList17" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421375" __designer:wfdid="w105" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h17") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421376">25:<asp:DropDownList id="DropDownList25" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421377" __designer:wfdid="w106" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h25") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421378"><TD __designer:dtid="562949953421379">2:<asp:DropDownList id="DropDownList2" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421380" __designer:wfdid="w107" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h02") %>' AppendDataBoundItems="True"><asp:ListItem Selected="True"></asp:ListItem>
</asp:DropDownList></TD><TD __designer:dtid="562949953421381">10:<asp:DropDownList id="DropDownList10" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421382" __designer:wfdid="w108" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h10") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421383">18:<asp:DropDownList id="DropDownList18" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421384" __designer:wfdid="w109" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h18") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421385">26:<asp:DropDownList id="DropDownList26" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421386" __designer:wfdid="w110" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h26") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421387"><TD __designer:dtid="562949953421388">3:<asp:DropDownList id="DropDownList3" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421389" __designer:wfdid="w111" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h03") %>' AppendDataBoundItems="True"><asp:ListItem Selected="True"></asp:ListItem>
</asp:DropDownList></TD><TD __designer:dtid="562949953421390">11:<asp:DropDownList id="DropDownList11" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421391" __designer:wfdid="w112" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h11") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421392">19:<asp:DropDownList id="DropDownList19" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421393" __designer:wfdid="w113" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h19") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421394">27:<asp:DropDownList id="DropDownList27" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421395" __designer:wfdid="w114" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h27") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421396"><TD __designer:dtid="562949953421397">4:<asp:DropDownList id="DropDownList4" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421398" __designer:wfdid="w115" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h04") %>' AppendDataBoundItems="True"><asp:ListItem Selected="True"></asp:ListItem>
</asp:DropDownList></TD><TD __designer:dtid="562949953421399">12:<asp:DropDownList id="DropDownList12" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421400" __designer:wfdid="w116" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h12") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421401">20:<asp:DropDownList id="DropDownList20" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421402" __designer:wfdid="w117" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h20") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421403">28:<asp:DropDownList id="DropDownList28" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421404" __designer:wfdid="w118" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h28") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421405"><TD __designer:dtid="562949953421406">5:<asp:DropDownList id="DropDownList5" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421407" __designer:wfdid="w119" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h05") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421408">13:<asp:DropDownList id="DropDownList13" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421409" __designer:wfdid="w120" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h13") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421410">21:<asp:DropDownList id="DropDownList21" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421411" __designer:wfdid="w121" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h21") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421412">29:<asp:DropDownList id="DropDownList29" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421413" __designer:wfdid="w122" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h29") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421414"><TD __designer:dtid="562949953421415">6:<asp:DropDownList id="DropDownList6" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421416" __designer:wfdid="w123" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h06") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421417">14:<asp:DropDownList id="DropDownList14" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421418" __designer:wfdid="w124" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h14") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421419">22:<asp:DropDownList id="DropDownList22" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421420" __designer:wfdid="w125" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h22") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421421">30:<asp:DropDownList id="DropDownList30" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421422" __designer:wfdid="w126" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h30") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421423"><TD __designer:dtid="562949953421424">7:<asp:DropDownList id="DropDownList7" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421425" __designer:wfdid="w127" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h07") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421426">15:<asp:DropDownList id="DropDownList15" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421427" __designer:wfdid="w128" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h15") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421428">23:<asp:DropDownList id="DropDownList23" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421429" __designer:wfdid="w129" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h23") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421430">31:<asp:DropDownList id="DropDownList31" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421431" __designer:wfdid="w130" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h31") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD></TR><TR __designer:dtid="562949953421432"><TD __designer:dtid="562949953421433">8:<asp:DropDownList id="DropDownList8" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421434" __designer:wfdid="w131" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h08") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421435">16:<asp:DropDownList id="DropDownList16" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421436" __designer:wfdid="w132" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h16") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421437">24:<asp:DropDownList id="DropDownList24" runat="server" DataSourceID="ds_RangeforDropDown" __designer:dtid="562949953421438" __designer:wfdid="w133" DataTextField="Baru" DataValueField="KODE_RANGE" SelectedValue='<%# Bind("h24") %>' AppendDataBoundItems="True"><asp:ListItem> </asp:ListItem>
                        </asp:DropDownList></TD><TD __designer:dtid="562949953421439"></TD></TR><TR __designer:dtid="562949953421440"><TD vAlign=bottom align=left colSpan=4 __designer:dtid="562949953421441">&nbsp;</TD></TR><TR __designer:dtid="562949953421442"><TD vAlign=bottom align=left colSpan=4 __designer:dtid="562949953421443"><asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton4" runat="server" __designer:wfdid="w134" ImageUrl="~/Images/edit.gif" AlternateText="<%$ Resources:ImgInsert %>" CommandName="Insert"></asp:ImageButton> <asp:LinkButton id="lbSimpan_2" runat="server" Text="<%$ Resources:ImgInsert %>" __designer:wfdid="w135" CommandName="Insert"></asp:LinkButton> <asp:ImageButton style="VERTICAL-ALIGN: middle" id="ImageButton5" runat="server" CausesValidation="False" __designer:wfdid="w136" ImageUrl="~/Images/delete.gif" AlternateText="<%$ Resources:ImgCancel %>" CommandName="Cancel_Insert"></asp:ImageButton> <asp:LinkButton id="lbCancel_2" runat="server" Text="<%$ Resources:ImgCancel %>" CausesValidation="False" __designer:wfdid="w137" CommandName="Cancel_Insert"></asp:LinkButton></TD></TR><TR __designer:dtid="562949953421448"><TD vAlign=bottom align=left colSpan=4 __designer:dtid="562949953421449">&nbsp;</TD></TR></TBODY></TABLE>&nbsp;</TD></TR></TBODY></TABLE>
</InsertItemTemplate>
</asp:FormView> </asp:View> </asp:MultiView></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsCabang" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_CABANG, CASE WHEN KODE_CABANG = '---' THEN 'GLOBAL' ELSE NAMA_CABANG END AS NAMA_CABANG FROM taCabang">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="ds_RangeforDropDown" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_RANGE], [JAM_AWAL], [JAM_AKHIR],'[' + [KODE_RANGE] + ']' + ' : ' + substring( convert(char(20),[JAM_AWAL],108),1,5) + ' s/d ' + substring(convert(char(20),[JAM_AKHIR],108),1,5) AS Baru FROM [taRange]">
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
                    <asp:Label ID="lblConfirmDelete2" runat="server" Font-Bold="True" Font-Size="Small"
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
    <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
        Visible="False"></asp:Label><br />
                <asp:Label ID="lblCannotEditApproved" runat="server" Text="<%$ Resources:Resource, lblCannotEditApproved %>"
                    Visible="False"></asp:Label><br />
                        <asp:Label ID="lblCannotNull" runat="server" Text="<%$ Resources:cannot_null %>"
                            Visible="False"></asp:Label>

</asp:Content>

