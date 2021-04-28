<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="overtime.aspx.cs" Inherits="rtwin.overtime" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
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
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem0" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem0"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 50px" vAlign=top align=center><asp:Label id="lblTglAkhir" runat="server" Text="<%$ Resources:lblTo %>"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left><asp:TextBox id="txtFilterItem1" runat="server" width="100px" MaxLength="10" Columns="10"></asp:TextBox>&nbsp;<asp:ImageButton id="imgFilterItem1" runat="server" CausesValidation="False" ImageUrl="~/images/ew_calendar.gif"></asp:ImageButton> <asp:RequiredFieldValidator id="valFilterItem1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:CompareValidator id="valFilterItem1_1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" ValueToCompare="01/01/1900" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAwal">*</asp:CompareValidator><asp:CompareValidator id="valFilterItem1_2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:CompareValTglAkhir %>" ControlToValidate="txtFilterItem1" EnableClientScript="True" Type="Date" Operator="GreaterThanEqual" meta:resourceKey="CompareValTglAkhir" ControlToCompare="txtFilterItem0">*</asp:CompareValidator> <cc1:CalendarExtender id="cexFilterItem1" runat="server" CssClass="cal_Theme1" targetcontrolid="txtFilterItem1" PopupButtonID="imgFilterItem1" Format="<%$ Resources:Resource, formatTanggal %>" Enabled="True">
            </cc1:CalendarExtender> <cc1:MaskedEditExtender id="mexFilterItem1" runat="server" Mask="99/99/9999" MaskType="Date" TargetControlID="txtFilterItem1"></cc1:MaskedEditExtender></TD><TD style="WIDTH: 100px" vAlign=top><asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:Button></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:Column0 %>" width="80px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD colSpan=4><asp:TextBox id="txtFilterItem2" runat="server" AutoPostBack="True" width="100px"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem3" runat="server" OnSelectedIndexChanged="ddlFilterItem3_DataBound_SelectedChange" AutoPostBack="True" DataSourceID="dsBiro" DataValueField="KODE_DEPUTI" DataTextField="NAMA_DEPUTI" OnDataBound="ddlFilterItem3_DataBound_SelectedChange"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem4" runat="server" DataSourceID="dsBagian" DataValueField="KODE_BIRO" DataTextField="NAMA_BIRO" OnDataBound="ddlFilterItem4_SelectedIndexChanged" OnSelectedIndexChanged="ddlFilterItem4_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList></TD></TR>
    <tr>
        <td>
            <asp:Label ID="lblSubbagian" runat="server" Text="<%$ Resources:lblSubBagian %>"></asp:Label></td>
        <td colspan="4">
            <asp:DropDownList id="ddlFilterItem6" runat="server" DataSourceID="dsSubbagian" DataValueField="KODE_BAGIAN" DataTextField="NAMA_BAGIAN">
            </asp:DropDownList></td>
    </tr>
    <TR><TD><asp:Label id="lblStatusAlasan" runat="server" Text="<%$ Resources:lblStatusAlasan %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem5" runat="server"><asp:ListItem Value="-"></asp:ListItem>
<asp:ListItem Value="NOT">Sudah diproses</asp:ListItem>
<asp:ListItem Value="">Belum diproses</asp:ListItem>
</asp:DropDownList></TD></TR></TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" vAlign=top rowSpan=2>
    &nbsp;
    <BR /><BR /><asp:GridView id="GvLembur" runat="server" DataSourceID="dsLembur" OnDataBound="GvLembur_DataBound" OnRowDataBound="GvLembur_RowDataBound" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="NIP,PIN,TGL_MASUK" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GvLembur_RowEditing" OnRowCommand="GvLembur_RowCommand">
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
    <EditItemTemplate>
        <asp:Label ID="lblCol1Edit" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label>
    </EditItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TGL_MASUK" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
    <asp:Label ID="lblCol2Edit" runat="server" Text='<%# Bind("TGL_MASUK","{0:d}") %>'></asp:Label>
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TGL_MASUK","{0:d}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_MASUK" HeaderText="<%$ Resources:Column3 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("JAM_MASUK","{0:HH:mm}") %>'></asp:Label> 
</ItemTemplate>
    <EditItemTemplate>
        <asp:Label ID="lblCol3Edit" runat="server" Text='<%# Bind("JAM_MASUK","{0:HH:mm}") %>'></asp:Label>
    </EditItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JAM_KELUAR" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
    <asp:Label ID="lblCol4Edit" runat="server" Text='<%# Bind("JAM_KELUAR","{0:HH:mm}") %>'></asp:Label>
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("JAM_KELUAR","{0:HH:mm}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="TOTAL_LEMBUR" HeaderText="<%$ Resources:Column5 %>"><EditItemTemplate>
    <asp:Label ID="lblCol5Edit" runat="server" Text='<%# Bind("TOTAL_LEMBUR","{0:HH:mm}") %>'></asp:Label>
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("TOTAL_LEMBUR","{0:HH:mm}") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="LEMBUR_SKL" HeaderText="<%$ Resources:Column6 %>"><ItemTemplate>
    &nbsp;<asp:Label ID="lblCol6Item" runat="server" Text='<%# Bind("LEMBUR_SKL","{0:HH:mm}") %>'></asp:Label>
</ItemTemplate>
    <EditItemTemplate>
        <asp:TextBox ID="txtCol6Edit" runat="server" Columns="5" MaxLength="5" Text='<%# Bind("LEMBUR_SKL", "{0:HH:mm}") %>'></asp:TextBox>
        <asp:RequiredFieldValidator ID="valCol6Edit" runat="server" ControlToValidate="txtCol6Edit"
            CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>"
            SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator
            ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtCol6Edit"
            CssClass="fontR" EnableClientScript="True" ErrorMessage="<%$ Resources:salahInput %>"
            SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator><asp:CompareValidator
                ID="CompareValidator" runat="server" ControlToCompare="txtCol5Edit" ControlToValidate="txtCol6Edit"
                CssClass="fontR" ErrorMessage="Jam lembur terlalu besar" Operator="LessThanEqual"></asp:CompareValidator>
        <asp:TextBox ID="txtCol5Edit" runat="server" Columns="5" MaxLength="5" Text='<%# Bind("TOTAL_LEMBUR", "{0:HH:mm}") %>'
            Visible="False"></asp:TextBox>
        <cc1:MaskedEditExtender
                ID="mexCol6Edit" runat="server" Mask="99:99" MaskType="Time" TargetControlID="txtCol6Edit">
            </cc1:MaskedEditExtender>
    </EditItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
    <HeaderStyle HorizontalAlign="Center" Width="60px" />
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column7 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/images/iedit.gif" AlternateText="<%$ Resources:ImgEdit %>" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>
    <EditItemTemplate>
        <asp:ImageButton ID="imgUpdate" runat="server" AlternateText="<%$ Resources:ImgUpdate %>"
            CommandName="Update" ImageUrl="~/Images/edit.gif" /><asp:ImageButton ID="imgCancel"
                runat="server" AlternateText="<%$ Resources:ImgCancel %>" CausesValidation="False"
                CommandName="Cancel" ImageUrl="~/Images/delete.gif" />
    </EditItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column8 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" AlternateText="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton>&nbsp;
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="<%$ Resources:Column9 %>">
        <ItemTemplate>
            <asp:ImageButton ID="imgSisip" runat="server" AlternateText="<%$ Resources:Column9 %>"
                CausesValidation="False" CommandName="TambahLembur" ImageUrl="~/images/sisip.png" />
        </ItemTemplate>
        <ItemStyle HorizontalAlign="Center" />
        <HeaderStyle HorizontalAlign="Center" Width="50px" />
    </asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView><asp:SqlDataSource id="dsLembur" runat="server" SelectCommand="SELECT NIP, NAMA, TGL_MASUK, JAM_MASUK, JAM_KELUAR, TOTAL_LEMBUR, LEMBUR_SKL, PIN FROM q_skl" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taLembur2 WHERE NIP = @NIP AND TGL_SKL = @TGL_MASUK&#13;&#10;" InsertCommand="INSERT INTO taLembur2 (NIP, TGL_SKL, LEMBUR_SKL) VALUES (@NIP, @TGL_MASUK, @TOTAL_LEMBUR)" OnDeleted="dsLembur_Deleted" UpdateCommand="UPDATE taLembur2 SET LEMBUR_SKL = @LEMBUR_SKL WHERE NIP = @NIP AND TGL_SKL = @TGL_MASUK&#13;&#10;" OnInserted="dsLembur_Inserted" OnInserting="dsLembur_Inserting">
    <DeleteParameters>
        <asp:Parameter Name="NIP" />
        <asp:Parameter Name="TGL_MASUK" />
    </DeleteParameters>
    <InsertParameters>
        <asp:Parameter Name="NIP" />
        <asp:Parameter Name="TGL_MASUK" />
        <asp:Parameter Name="TOTAL_LEMBUR" />
    </InsertParameters>
</asp:SqlDataSource><asp:SqlDataSource id="dsBagian" runat="server" SelectCommand="SELECT KODE_BIRO, NAMA_BIRO, KODE_CABANG, KODE_DEPUTI FROM q_BIRO ORDER BY KODE_BIRO" ConnectionString="<%$ ConnectionStrings:strCn %>">
                </asp:SqlDataSource> 
    <asp:SqlDataSource ID="dsBiro" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT KODE_DEPUTI, NAMA_DEPUTI, KODE_CABANG FROM q_DEPUTI ORDER BY KODE_DEPUTI">
    </asp:SqlDataSource><asp:SqlDataSource id="dsSubbagian" runat="server" SelectCommand="SELECT KODE_BAGIAN, NAMA_BAGIAN, KODE_CABANG, KODE_BIRO , KODE_DEPUTI FROM q_BAGIAN ORDER BY KODE_BAGIAN" ConnectionString="<%$ ConnectionStrings:strCn %>">
    </asp:SqlDataSource>
    &nbsp; &nbsp; &nbsp;&nbsp;<BR />
    <br />
    <asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender>
    <asp:GridView ID="GvLemburValidasi" runat="server" AutoGenerateColumns="False" DataSourceID="dsLemburValidasi" DataKeyNames="KODE_DEPUTI" AllowPaging="True" OnDataBound="GvLemburValidasi_DataBound" OnRowUpdating="GvLemburValidasi_RowUpdating">
        <Columns>
            <asp:BoundField DataField="KODE_DEPUTI" HeaderText="KODE_DEPUTI" ReadOnly="True"
                SortExpression="KODE_DEPUTI" Visible="False" />
            <asp:TemplateField HeaderText="Nama Biro" SortExpression="NAMA_DEPUTI">
                <EditItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("NAMA_DEPUTI") %>'></asp:Label>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("NAMA_DEPUTI") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Tgl Yang Telah divalidasi" SortExpression="TGL_SKL">
                <EditItemTemplate>
                    <asp:TextBox ID="txtCol1Edit" runat="server" Columns="10" MaxLength="10" Text='<%# Bind("TGL_SKL", "{0:d}") %>'
                        Width="100px"></asp:TextBox><asp:ImageButton ID="imgCol0Edit" runat="server" CausesValidation="False"
                            ImageUrl="~/images/ew_calendar.gif" /><asp:RequiredFieldValidator ID="valCol1Edit"
                                runat="server" ControlToValidate="txtCol1Edit" CssClass="fontR" EnableClientScript="True"
                                ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" SetFocusOnError="True"
                                SkinID="fontR">*</asp:RequiredFieldValidator><asp:RegularExpressionValidator ID="valCol1_1Edit"
                                    runat="server" ControlToValidate="txtCol1Edit" CssClass="fontR" EnableClientScript="True"
                                    ErrorMessage="<%$ Resources:Resource, salahValidatorTanggal %>" SetFocusOnError="True"
                                    ValidationExpression="<%$ Resources:Resource, validatorTanggal %>">*</asp:RegularExpressionValidator>
                    <asp:CompareValidator ID="CompareValidatorTGL_SKL" runat="server" ControlToCompare="txtCol1Edit2"
                        ControlToValidate="txtCol1Edit" CssClass="fontR" ErrorMessage="Tidak dapat ubah ke tanggal lampau"
                        Operator="GreaterThan" Type="Date"></asp:CompareValidator>
                    <asp:TextBox ID="txtCol1Edit2" runat="server" Columns="10" MaxLength="10" Text='<%# Bind("TGL_SKL", "{0:d}") %>'
                        Visible="False" Width="100px"></asp:TextBox>&nbsp;
                    <cc1:CalendarExtender
                                        ID="cexCol1Edit" runat="server" CssClass="cal_Theme1" Enabled="True" Format="<%$ Resources:Resource, formatTanggal %>"
                                        PopupButtonID="imgCol0Edit" TargetControlID="txtCol1Edit">
                                    </cc1:CalendarExtender>
                    <cc1:MaskedEditExtender ID="mexCol1Edit" runat="server" Mask="99/99/9999" MaskType="Date"
                        TargetControlID="txtCol1Edit">
                    </cc1:MaskedEditExtender>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="lblCol1Item" runat="server" Text='<%# Bind("TGL_SKL", "{0:d}") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:ImageButton ID="imgUpdate" runat="server" AlternateText="<%$ Resources:ImgUpdate %>"
            CommandName="Update" ImageUrl="~/Images/edit.gif" /><asp:ImageButton ID="imgCancel"
                runat="server" AlternateText="<%$ Resources:ImgCancel %>" CausesValidation="False"
                CommandName="Cancel" ImageUrl="~/Images/delete.gif" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:ImageButton ID="imgEdit" runat="server" AlternateText="<%$ Resources:ImgEdit %>"
                        CommandName="Edit" ImageUrl="~/images/iedit.gif" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:ImageButton ID="imgDelete" runat="server" CommandName="Delete" ImageUrl="~/images/undo_16.png" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <PagerTemplate>
            <asp:ImageButton ID="btnfirst" runat="server" CommandArgument="First" CommandName="Page"
                ImageUrl="~/images/buttonfirst.gif" />
            &nbsp;<asp:ImageButton ID="btnprev" runat="server" CommandArgument="Prev" CommandName="Page"
                ImageUrl="~/images/buttonprev.gif" />
            <asp:Label ID="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label>
            <asp:TextBox ID="txtHalaman2" runat="server" AutoPostBack="True" Columns="3" MaxLength="3"
                OnTextChanged="txtHalaman2_TextChanged"></asp:TextBox>
            <asp:Label ID="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label>
            <asp:Label ID="lblJumlahHalaman" runat="server" Text="Label"></asp:Label>
            &nbsp;<asp:ImageButton ID="btnnext" runat="server" CommandArgument="Next" CommandName="Page"
                ImageUrl="~/images/buttonnext.gif" />
            <asp:ImageButton ID="btnlast" runat="server" CommandArgument="Last" CommandName="Page"
                ImageUrl="~/images/buttonlast.gif" />
        </PagerTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="dsLemburValidasi" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="IF @GradeID = '3'&#13;&#10;SELECT     dbo.taLemburValidasi.KODE_DEPUTI, dbo.taSatker.NAMA_SATKER AS NAMA_DEPUTI, dbo.taLemburValidasi.TGL_SKL&#13;&#10;FROM         dbo.taLemburValidasi INNER JOIN&#13;&#10;                      dbo.taSatker ON dbo.taLemburValidasi.KODE_DEPUTI = dbo.taSatker.KODE_SATKER&#13;&#10;WHERE taSatker.KODE_SATKER = @KODE_SATKER&#13;&#10;ELSE IF (@GradeID = '2' OR @GradeID = '1a')&#13;&#10;SELECT     dbo.taLemburValidasi.KODE_DEPUTI, dbo.taSatker.NAMA_SATKER AS NAMA_DEPUTI, dbo.taLemburValidasi.TGL_SKL&#13;&#10;FROM         dbo.taLemburValidasi INNER JOIN&#13;&#10;                      dbo.taSatker ON dbo.taLemburValidasi.KODE_DEPUTI = dbo.taSatker.KODE_SATKER&#13;&#10;WHERE dbo.taLemburValidasi.KODE_DEPUTI IN (SELECT KODE_DEPUTI FROM q_Deputi WHERE KODE_CABANG = @KODE_CABANG) OR KODE_DEPUTI IS NULL&#13;&#10;ELSE&#13;&#10;SELECT     dbo.taLemburValidasi.KODE_DEPUTI, dbo.taSatker.NAMA_SATKER AS NAMA_DEPUTI, dbo.taLemburValidasi.TGL_SKL&#13;&#10;FROM         dbo.taLemburValidasi INNER JOIN&#13;&#10;                      dbo.taSatker ON dbo.taLemburValidasi.KODE_DEPUTI = dbo.taSatker.KODE_SATKER&#13;&#10;&#13;&#10;" UpdateCommand="UPDATE taLemburValidasi SET TGL_SKL = @TGL_SKL WHERE KODE_DEPUTI = @KODE_DEPUTI" DeleteCommand="UPDATE taLemburValidasi SET TGL_SKL = dbo.FirstDate(dbo.FirstDate(getdate())-1)-1 WHERE KODE_DEPUTI = @KODE_DEPUTI">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="4" Name="GradeID" SessionField="GradeID" />
            <asp:SessionParameter Name="KODE_SATKER" SessionField="SatkerID" />
            <asp:SessionParameter DefaultValue="003" Name="KODE_CABANG" SessionField="CabangID" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="TGL_SKL" />
            <asp:Parameter Name="KODE_DEPUTI" />
        </UpdateParameters>
        <DeleteParameters>
            <asp:Parameter Name="KODE_DEPUTI" />
        </DeleteParameters>
    </asp:SqlDataSource>
</TD></TR><TR></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tbody><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    &nbsp;
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
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan=2><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" ImageUrl="~/images/exit4_16.png" AlternateText="<%$ Resources:Resource, lblClose %>"></asp:ImageButton> <asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
                <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False" width="330px"></asp:Label><asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>"
                    Visible="False" width="259px"></asp:Label><asp:Label ID="lblJamSalah2" runat="server" Text="<%$ Resources:lblJamSalah %>"
                    Visible="False" width="320px"></asp:Label><asp:Label ID="lblPeriode" runat="server" Text="<%$ Resources:tglval %>" Visible="False"></asp:Label>
   
</asp:Content>



