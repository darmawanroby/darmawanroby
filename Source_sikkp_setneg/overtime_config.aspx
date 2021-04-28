<%@ Page MasterPageFile ="~/MasterPage.master" Language="C#" AutoEventWireup="true" Inherits="rtwin.overtime_config" CodeFile="overtime_config.aspx.cs" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
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
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%"><asp:Label id="Label4" runat="server" Font-Bold="True" Text="<%$ Resources:head1 %>"></asp:Label><BR /><BR /><asp:GridView id="GvParamLembur" runat="server" width="370px" DataSourceID="dsParamLembur" OnRowDataBound="GvParamLembur_RowDataBound" OnDataBound="GvParamLembur_DataBound" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_LEMBUR" GridLines="Vertical"><Columns>
<asp:TemplateField SortExpression="KODE_LEMBUR" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("KODE_LEMBUR") %>'></asp:Label>
                            
</EditItemTemplate>
<FooterTemplate>
                            
</FooterTemplate>

<ItemStyle Height="17px"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("KODE_LEMBUR") %>' __designer:wfdid="w144"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="HARI_LEMBUR" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
                                <asp:Label ID="Label3" runat="server" Text='<%# Eval("HARI_LEMBUR") %>'></asp:Label>
                            
</EditItemTemplate>
<FooterTemplate>
                            
</FooterTemplate>

<HeaderStyle Width="200px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:Label ID="Label21" runat="server" Text='<%# Bind("HARI_LEMBUR") %>'></asp:Label>
                            
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="FAKTOR" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
&nbsp;<asp:TextBox id="TxtWaktuFlexi" runat="server" Text='<%# BIND("FAKTOR") %>' width="50px" __designer:wfdid="w146" MaxLength="3"></asp:TextBox><BR /><asp:RangeValidator id="RangeValidator1" runat="server" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="TxtWaktuFlexi" EnableClientScript="True" __designer:wfdid="w147" SetFocusOnError="True" Type="Integer" MinimumValue="0" MaximumValue="720">*</asp:RangeValidator><asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="TxtWaktuFlexi" EnableClientScript="True" __designer:wfdid="w148" SetFocusOnError="True">*</asp:RequiredFieldValidator> <cc1:MaskedEditExtender id="mexTxtWaktuFlexi" runat="server" __designer:wfdid="w149" TargetControlID="TxtWaktuFlexi" MaskType="Number" Mask="999" AutoComplete="False"></cc1:MaskedEditExtender>
</EditItemTemplate>
<FooterTemplate>
                            
</FooterTemplate>

<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>

<HeaderStyle Width="70px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label12" runat="server" Text='<%# Bind("FAKTOR") %>' __designer:wfdid="w145"></asp:Label> 
</ItemTemplate>

<FooterStyle Width="310px"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
                                <asp:ImageButton ID="ImageButton2" runat="server" AlternateText="<%$ Resources:ImgUpdate %>"
                                    CommandName="Update" ImageUrl="~/Images/edit.gif" /><asp:ImageButton ID="ImageButton3"
                                        runat="server" AlternateText="<%$ Resources:ImgCancel %>" CausesValidation="False"
                                        CommandName="Cancel" ImageUrl="~/Images/delete.gif" />
                            
</EditItemTemplate>
<FooterTemplate>
                                <asp:ImageButton ID="ImageButton4" runat="server" AlternateText="<%$ Resources:ImgUpdate %>"
                                    CommandName="Insert" ImageUrl="~/Images/edit.gif" /><asp:ImageButton ID="ImageButton5"
                                        runat="server" AlternateText="<%$ Resources:ImgCancel %>" CausesValidation="False"
                                        CommandName="Cancel" ImageUrl="~/Images/delete.gif" />
                            
</FooterTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
                                <asp:ImageButton ID="ImageButton1" runat="server" AlternateText="<%$ Resources:ImgEdit %>"
                                    CommandName="Edit" ImageUrl="~/Images/iedit.gif" />
                            
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
</Columns>
<PagerTemplate>
                        <asp:ImageButton ID="BtnFirst" runat="server" ImageAlign="Middle" ImageUrl="~/images/buttonFirst.gif" CommandArgument="First" CommandName="Page" />&nbsp;
                        <asp:ImageButton ID="BtnPrev" runat="server" ImageAlign="Middle" ImageUrl="~/images/buttonPrev.gif" CommandArgument="Prev" CommandName="Page" />
                        <asp:Label ID="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label>
                        <asp:TextBox ID="txtHalaman" runat="server" AutoPostBack="True" Columns="3" MaxLength="3"
                            OnTextChanged="txtHalaman_TextChanged"></asp:TextBox>
                        <asp:Label ID="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label>
                        <asp:Label ID="lblJumlahHalaman" runat="server" Font-Size="Small" Text="Label"></asp:Label>&nbsp;
                        <asp:ImageButton ID="BtnNext" runat="server" ImageAlign="Middle" ImageUrl="~/images/buttonNext.gif" CommandArgument="Next" CommandName="Page" />&nbsp;
                        <asp:ImageButton ID="BtnLast" runat="server" style="vertical-align: middle" ImageUrl="~/images/buttonLast.gif" CommandArgument="Last" CommandName="Page" />
                    
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsParamLembur" runat="server" OnUpdated="dsParamLembur_Updated" ConnectionString="<%$ ConnectionStrings:StrCn %>" DeleteCommand="DELETE FROM [taParamLembur] WHERE [KODE_LEMBUR] = @KODE_LEMBUR" InsertCommand="INSERT INTO taParamLembur(KODE_LEMBUR, JAM_KE, SAMPAI_JAM_KE, FAKTOR) VALUES (@KODE_LEMBUR, 1, 99, @FAKTOR)" SelectCommand="SELECT KODE_LEMBUR, CASE WHEN KODE_LEMBUR = '1' THEN 'Hari Kerja' ELSE (CASE WHEN KODE_LEMBUR = '2' THEN 'Hari Libur' ELSE 'Hari Libur Nasional' END) END AS HARI_LEMBUR, FAKTOR FROM taParamLembur" UpdateCommand="UPDATE [taParamLembur] SET [FAKTOR] = @FAKTOR WHERE [KODE_LEMBUR] = @KODE_LEMBUR">
                    <DeleteParameters>
                        <asp:Parameter Name="KODE_LEMBUR" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="FAKTOR" Type="String" />
                        <asp:Parameter Name="KODE_LEMBUR" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="@KODE_LEMBUR" />
                        <asp:Parameter Name="@FAKTOR" />
                    </InsertParameters>
                </asp:SqlDataSource> &nbsp;<BR /><BR /><TABLE style="WIDTH: 450px"><TBODY><TR><TD><asp:Label id="Label7" runat="server" Font-Bold="True" Text="<%$ Resources:head3 %>"></asp:Label></TD><TD></TD></TR><TR><TD><asp:Label id="ExceptionDetails2" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label></TD><TD></TD></TR><TR><TD><asp:Label id="Label8" runat="server" Text="<%$ Resources:param1 %>"></asp:Label></TD><TD>: <asp:TextBox id="txtCol1Item0" runat="server" Columns="5" MaxLength="5" __designer:wfdid="w191"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator id="valtxtCol1Item0" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtCol1Item0" __designer:dtid="844424930132107" EnableClientScript="True" __designer:wfdid="w192" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexCol1Item0" runat="server" __designer:wfdid="w127" Mask="99:99" MaskType="Time" TargetControlID="txtCol1Item0"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="Label9" runat="server" Text="<%$ Resources:param2 %>"></asp:Label></TD><TD>:&nbsp;<asp:TextBox id="txtCol1Item1" runat="server" Columns="5" MaxLength="5" __designer:wfdid="w193"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator id="valtxtCol1Item1" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtCol1Item1" __designer:dtid="844424930132107" EnableClientScript="True" __designer:wfdid="w194" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexCol1Item1" runat="server" __designer:wfdid="w128" Mask="99:99" MaskType="Time" TargetControlID="txtCol1Item1"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="Label5" runat="server" Text="<%$ Resources:param3 %>" __designer:wfdid="w206"></asp:Label></TD><TD>: <asp:TextBox id="txtCol1Item2" runat="server" Columns="5" MaxLength="5" __designer:wfdid="w195"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator id="valtxtCol1Item2" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtCol1Item2" __designer:dtid="844424930132107" EnableClientScript="True" __designer:wfdid="w196" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexCol1Item2" runat="server" __designer:wfdid="w129" Mask="99:99" MaskType="Time" TargetControlID="txtCol1Item2"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="Label6" runat="server" Text="<%$ Resources:param4 %>" __designer:wfdid="w207"></asp:Label></TD><TD>: <asp:TextBox id="txtCol1Item3" runat="server" Columns="5" MaxLength="5" __designer:wfdid="w197"></asp:TextBox>&nbsp;<asp:RegularExpressionValidator id="valtxtCol1Item3" runat="server" CssClass="fontR" ErrorMessage="<%$ Resources:Resource, salahInputWaktu %>" ControlToValidate="txtCol1Item3" __designer:dtid="844424930132107" EnableClientScript="True" __designer:wfdid="w198" SetFocusOnError="True" ValidationExpression="^([0-1][0-9]|[2][0-3]):([0-5][0-9])$">*</asp:RegularExpressionValidator> <cc1:MaskedEditExtender id="mexCol1Item3" runat="server" __designer:wfdid="w130" Mask="99:99" MaskType="Time" TargetControlID="txtCol1Item3"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="Label10" runat="server" Text="<%$ Resources:param5 %>" __designer:wfdid="w208"></asp:Label></TD><TD>: <asp:TextBox id="txtCol1Item4" runat="server" Text='<%# Bind("MAKS_HARI_TERIMA_MAKAN") %>' Columns="3" MaxLength="3" __designer:wfdid="w199"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item4" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item4" EnableClientScript="True" __designer:wfdid="w200" SetFocusOnError="True" MaximumValue="100" MinimumValue="0" Type="Integer">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item4" runat="server" __designer:wfdid="w141" Mask="999" MaskType="Number" TargetControlID="txtCol1Item4" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="Label11" runat="server" Text="<%$ Resources:param6 %>" __designer:wfdid="w209"></asp:Label></TD><TD>: <asp:TextBox id="txtCol1Item5" runat="server" Text='<%# Bind("MAKS_HARI_TERIMA_MAKAN") %>' Columns="3" MaxLength="3" __designer:wfdid="w201"></asp:TextBox>&nbsp;<asp:RangeValidator id="valtxtCol1Item5" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtCol1Item5" EnableClientScript="True" __designer:wfdid="w202" SetFocusOnError="True" MaximumValue="100" MinimumValue="0" Type="Integer">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol1Item5" runat="server" __designer:wfdid="w142" Mask="999" MaskType="Number" TargetControlID="txtCol1Item5" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Label id="Label13" runat="server" Text="<%$ Resources:param7 %>" __designer:wfdid="w210"></asp:Label></TD><TD>: <asp:Label id="lblRp" runat="server" Text="Rp." __designer:wfdid="w203"></asp:Label>&nbsp;<asp:TextBox id="txtCol1Item6" runat="server" Text='<%# Bind("TARIF_MAKAN") %>' Columns="7" MaxLength="7" __designer:wfdid="w204"></asp:TextBox>&nbsp;<asp:CompareValidator id="valtxtCol1Item6" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol1Item6" EnableClientScript="True" __designer:wfdid="w205" Type="Integer" ValueToCompare="0" Operator="GreaterThanEqual">*</asp:CompareValidator> <cc1:MaskedEditExtender id="mexCol1Item6" runat="server" __designer:wfdid="w143" Mask="9999999" MaskType="Number" TargetControlID="txtCol1Item6" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR><TR><TD><asp:Button id="Button1" onclick="Button1_Click" runat="server" Text="<%$ Resources:ImgUpdate %>"></asp:Button></TD><TD></TD></TR></TBODY></TABLE><cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" __designer:wfdid="w645" targetcontrolid="Button1" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" __designer:wfdid="w646" targetcontrolid="Button1" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender><BR /><asp:Label id="Label14" runat="server" Font-Bold="True" Text="Lembur Otomatis" __designer:wfdid="w166"></asp:Label><BR /><BR /><asp:GridView id="GVCabang" runat="server" DataSourceID="dsCabang" OnRowDataBound="GVCabang_RowDataBound" OnDataBound="GVCabang_DataBound" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_CABANG" __designer:wfdid="w27" Width="700px"><Columns>
<asp:TemplateField SortExpression="KODE_CABANG" HeaderText="KODE"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Eval("KODE_CABANG") %>' __designer:wfdid="w88"></asp:Label> 
</EditItemTemplate>

<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Eval("KODE_CABANG") %>' __designer:wfdid="w192"></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_CABANG" HeaderText="NAMA SATUAN KERJA"><EditItemTemplate>
<asp:Label id="lblCol1Edit" runat="server" Text='<%# Eval("NAMA_CABANG") %>' __designer:wfdid="w57"></asp:Label> 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Left"></ItemStyle>

<HeaderStyle Width="200px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Eval("NAMA_CABANG") %>' __designer:wfdid="w49"></asp:Label> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Left"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField SortExpression="LEMBUR_OTOMATIS" HeaderText="LEMBUR OTOMATIS"><EditItemTemplate>
<asp:CheckBox id="chkCol2Edit" runat="server" __designer:wfdid="w89" Checked='<%# Bind("LEMBUR_OTOMATIS") %>'></asp:CheckBox> 
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:CheckBox id="chkCol2Item" runat="server" __designer:wfdid="w184" Checked='<%# Eval("LEMBUR_OTOMATIS") %>' Enabled="False"></asp:CheckBox> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField SortExpression="LEMBUR_LIBUR" HeaderText="LEMBUR LIBUR"><EditItemTemplate>
<asp:CheckBox id="chkCol3Edit" runat="server" __designer:wfdid="w89" Checked='<%# Bind("LEMBUR_LIBUR") %>'></asp:CheckBox>
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:CheckBox id="chkCol3Item" runat="server" __designer:wfdid="w178" Checked='<%# Eval("LEMBUR_LIBUR") %>' Enabled="False"></asp:CheckBox>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="PERHITUNGAN_LEMBUR" HeaderText="PERHITUNGAN"><EditItemTemplate>
<asp:DropDownList id="ddlCol4Edit" runat="server" __designer:wfdid="w194" SelectedValue='<%# Bind("PERHITUNGAN_LEMBUR") %>'><asp:ListItem Selected="True" Value="1">Lembur Awal</asp:ListItem>
<asp:ListItem Value="2">Lembur Akhir</asp:ListItem>
<asp:ListItem Value="3">Lembur Awal &amp; Akhir</asp:ListItem>
</asp:DropDownList>
</EditItemTemplate>

<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:DropDownList id="ddlCol4Item" runat="server" __designer:wfdid="w193" Enabled="False" SelectedValue='<%# Eval("PERHITUNGAN_LEMBUR") %>'><asp:ListItem Selected="True" Value="1">Lembur Awal</asp:ListItem>
<asp:ListItem Value="2">Lembur Akhir</asp:ListItem>
<asp:ListItem Value="3">Lembur Awal &amp; Akhir</asp:ListItem>
</asp:DropDownList>
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="UBAH"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/Images/edit.gif" CommandName="Update" __designer:wfdid="w67" AlternateText="Ubah"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/Images/delete.gif" CommandName="Cancel" __designer:wfdid="w68" AlternateText="Batal"></asp:ImageButton>
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" ImageUrl="~/Images/iedit.gif" CommandName="Edit" __designer:wfdid="w66" AlternateText="Ubah"></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" __designer:wfdid="w70" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" __designer:wfdid="w71" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w72"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" __designer:wfdid="w73" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w74"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w75"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" __designer:wfdid="w76" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" __designer:wfdid="w77" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<RowStyle HorizontalAlign="Center"></RowStyle>
<EmptyDataTemplate>
&nbsp; 
</EmptyDataTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsCabang" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT KODE_CABANG, NAMA_CABANG, LEMBUR_OTOMATIS, LEMBUR_LIBUR, PERHITUNGAN_LEMBUR FROM taCabang WHERE KODE_CABANG <> '---'" UpdateCommand="UPDATE taCabang SET LEMBUR_OTOMATIS = @LEMBUR_OTOMATIS, LEMBUR_LIBUR = @LEMBUR_LIBUR, PERHITUNGAN_LEMBUR = @PERHITUNGAN_LEMBUR WHERE (KODE_CABANG = @KODE_CABANG)" __designer:wfdid="w2"><UpdateParameters>
<asp:Parameter Name="LEMBUR_OTOMATIS"></asp:Parameter>
<asp:Parameter Name="LEMBUR_LIBUR"></asp:Parameter>
<asp:Parameter Name="PERHITUNGAN_LEMBUR"></asp:Parameter>
<asp:Parameter Name="KODE_CABANG"></asp:Parameter>
</UpdateParameters>
</asp:SqlDataSource></TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
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
                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Font-Size="Small" Text="<%$ Resources:lblConfirm %>"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" style="height: 26px">
                    <asp:Button ID="btnOK" runat="server" Text="OK" />&nbsp;<asp:Button ID="btnCancel"
                        runat="server" Text="<%$ Resources:imgCancel %>" /></td>
            </tr>
        </table>
        <div style="text-align: right">
            &nbsp;</div>
    </asp:Panel>
    <asp:Label ID="lblConfigUpdated" runat="server" Text="<%$ Resources:lblConfigUpdated %>" Visible="False"></asp:Label><asp:Label ID="lblConfigNotUpdated" runat="server" Text="<%$ Resources:lblConfigNotUpdated %>" Visible="False"></asp:Label><asp:Label ID="lblNotSaved" runat="server" Text="<%$ Resources:Resource, lblNotSaved %>"
        Visible="False" width="724px"></asp:Label><br />
</asp:Content>
			