<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="pph_status.aspx.cs" Inherits="rtwin.pph_status" title="Sistem Kehadiran Kerja Pegawai" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <table border="0" cellpadding="0" cellspacing="0" class="border_table" width="100%">
        <tr>
            <td style="width: 100%;">
                <asp:ScriptManager id="ScriptManager1" runat="server">
                </asp:ScriptManager>
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><BR />&nbsp;<BR /><BR /> 
                        <asp:GridView id="GvPPHStatus" runat="server" DataSourceID="dsPPHSTatus" 
                            OnRowEditing="GvPPHStatus_RowEditing" OnRowDataBound="grdijin_RowDataBound" 
                            OnRowCommand="grdijin_RowCommand" OnDataBound="grdijin_DataBound" 
                            AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" 
                            DataKeyNames="TAHUN" EnableModelValidation="True">
<FooterStyle VerticalAlign="Top"></FooterStyle>
<Columns>
<asp:TemplateField SortExpression="TAHUN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Eval("TAHUN") %>' __designer:wfdid="w67"></asp:Label>
</EditItemTemplate>

<HeaderStyle Width="75px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Eval("TAHUN") %>' __designer:wfdid="w1"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField SortExpression="BULAN" HeaderText="<%$ Resources:Column1 %>">
    <EditItemTemplate>
        <asp:Label ID="lblCol1Edit" runat="server" __designer:wfdid="w118" 
            Text='<%# Bind("BULAN") %>'></asp:Label>
    </EditItemTemplate>
<FooterTemplate>
    &nbsp; 
</FooterTemplate>

<HeaderStyle Width="75px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("BULAN") %>' __designer:wfdid="w118"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField SortExpression="WAKTU_UPLOAD" 
        HeaderText="<%$ Resources:Column2 %>">

<HeaderStyle Width="150px" HorizontalAlign="Center"></HeaderStyle>
    <EditItemTemplate>
        <asp:Label ID="lblCol2Edit" runat="server" __designer:wfdid="w123" 
            Text='<%# Bind("WAKTU_UPLOAD") %>'></asp:Label>
    </EditItemTemplate>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("WAKTU_UPLOAD") %>' 
        __designer:wfdid="w123"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField SortExpression="TIPE_PAJAK" 
        HeaderText="<%$ Resources:Column3 %>"><EditItemTemplate>
<asp:DropDownList id="ddlCol3Edit" runat="server" __designer:wfdid="w48" SelectedValue='<%# Bind("PAJAK_TAHUNAN") %>'>
    <asp:ListItem Value="0" Selected="True">Bulanan</asp:ListItem>
<asp:ListItem Value="1">Tahunan</asp:ListItem>
</asp:DropDownList> 
</EditItemTemplate>

<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("TIPE_PAJAK") %>' 
        __designer:wfdid="w126"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField SortExpression="BULAN_AWAL" HeaderText="<%$ Resources:Column4 %>"><EditItemTemplate>
    <asp:DropDownList ID="ddlCol4Edit" runat="server" __designer:wfdid="w48" 
        SelectedValue='<%# Bind("BULAN_AWAL") %>' AppendDataBoundItems="True">
        <asp:ListItem Value="1">Januari</asp:ListItem>
        <asp:ListItem Value="2">Februari</asp:ListItem>
        <asp:ListItem Value="3">Maret</asp:ListItem>
        <asp:ListItem Value="4">April</asp:ListItem>
        <asp:ListItem Value="5">Mei</asp:ListItem>
        <asp:ListItem Value="6">Juni</asp:ListItem>
        <asp:ListItem Value="7">Juli</asp:ListItem>
        <asp:ListItem Value="8">Agustus</asp:ListItem>
        <asp:ListItem Value="9">September</asp:ListItem>
        <asp:ListItem Value="10">Oktober</asp:ListItem>
        <asp:ListItem Value="11">November</asp:ListItem>
        <asp:ListItem Value="12">Desember</asp:ListItem>
    </asp:DropDownList>
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol4Footer" runat="server" __designer:wfdid="w351" MaxLength="3" Columns="3"></asp:TextBox> <asp:RangeValidator id="valCol4Footer" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" ControlToValidate="txtCol4Footer" EnableClientScript="True" __designer:wfdid="w352" SetFocusOnError="True" MinimumValue="0" MaximumValue="100" Type="Integer">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexCol4Footer" runat="server" __designer:wfdid="w426" AutoComplete="False" Mask="999" MaskType="Number" TargetControlID="txtCol4Footer"></cc1:MaskedEditExtender>
</FooterTemplate>

<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol4Item" runat="server" Text='<%# Bind("BULAN_AWAL") %>' __designer:wfdid="w348"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField SortExpression="TAHUN_AWAL" HeaderText="<%$ Resources:Column5 %>"><EditItemTemplate>
    <asp:TextBox ID="txtCol5Edit" runat="server" __designer:wfdid="w351" 
        Columns="4" MaxLength="4" Text='<%# Bind("TAHUN_AWAL") %>'></asp:TextBox>
    <cc1:MaskedEditExtender ID="mexCol5Edit" runat="server" 
        __designer:wfdid="w426" AutoComplete="False" Mask="9999" MaskType="Number" 
        TargetControlID="txtCol5Edit">
    </cc1:MaskedEditExtender>
    <asp:RangeValidator ID="valCol5Edit" runat="server" __designer:wfdid="w352" 
        ControlToValidate="txtCol5Edit" CssClass="fontR" EnableClientScript="True" 
        ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" MaximumValue="9999" 
        MinimumValue="2015" SetFocusOnError="True" SkinID="fontR" Type="Integer">*</asp:RangeValidator>
</EditItemTemplate>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol5Item" runat="server" Text='<%# Bind("TAHUN_AWAL") %>' 
        __designer:wfdid="w312"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField SortExpression="BULAN_AKHIR" HeaderText="<%$ Resources:Column6 %>">
    <EditItemTemplate>
        <asp:DropDownList ID="ddlCol6Edit" runat="server" __designer:wfdid="w48" 
            SelectedValue='<%# Bind("BULAN_AKHIR") %>'>
            <asp:ListItem Value="1" Selected="True">Januari</asp:ListItem>
            <asp:ListItem Value="2">Februari</asp:ListItem>
            <asp:ListItem Value="3">Maret</asp:ListItem>
            <asp:ListItem Value="4">April</asp:ListItem>
            <asp:ListItem Value="5">Mei</asp:ListItem>
            <asp:ListItem Value="6">Juni</asp:ListItem>
            <asp:ListItem Value="7">Juli</asp:ListItem>
            <asp:ListItem Value="8">Agustus</asp:ListItem>
            <asp:ListItem Value="9">September</asp:ListItem>
            <asp:ListItem Value="10">Oktober</asp:ListItem>
            <asp:ListItem Value="11">November</asp:ListItem>
            <asp:ListItem Value="12">Desember</asp:ListItem>
        </asp:DropDownList>
    </EditItemTemplate>

<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol6Item" runat="server" Text='<%# Bind("BULAN_AKHIR") %>' __designer:wfdid="w2"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField SortExpression="TAHUN_AKHIR" HeaderText="<%$ Resources:Column7 %>"><EditItemTemplate>
    <asp:TextBox ID="txtCol7Edit" runat="server" __designer:wfdid="w351" 
        Columns="4" MaxLength="4" Text='<%# Bind("TAHUN_AKHIR") %>'></asp:TextBox>
    <cc1:MaskedEditExtender ID="mexCol7Edit" runat="server" 
        __designer:wfdid="w426" AutoComplete="False" Mask="9999" MaskType="Number" 
        TargetControlID="txtCol7Edit">
    </cc1:MaskedEditExtender>
    <asp:RangeValidator ID="valCol7Edit" runat="server" __designer:wfdid="w352" 
        ControlToValidate="txtCol7Edit" CssClass="fontR" EnableClientScript="True" 
        ErrorMessage="<%$ Resources:Resource, lblSalahInput %>" MaximumValue="9999" 
        MinimumValue="2015" SetFocusOnError="True" SkinID="fontR" Type="Integer">*</asp:RangeValidator>
</EditItemTemplate>

<HeaderStyle Width="100px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol7Item" runat="server" Text='<%# Bind("TAHUN_AKHIR") %>' 
        __designer:wfdid="w232"></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Center" />
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column8 %>"><EditItemTemplate>
&nbsp;<asp:ImageButton id="imgUpdate" runat="server" ImageUrl="~/images/edit.gif" __designer:wfdid="w62" CommandName="Update" ToolTip="<%$ Resources:ImgUpdate %>"></asp:ImageButton> <asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" ImageUrl="~/images/delete.gif" __designer:wfdid="w63" CommandName="Cancel" ToolTip="<%$ Resources:ImgCancel%>"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
                    &nbsp;<asp:ImageButton ID="imgInsert" runat="server" CommandName="Insert" ImageUrl="~/images/edit.gif" ToolTip="<%$ Resources:ImgInsert %>" />
                    <asp:ImageButton ID="imgCancelInsert" runat="server" ImageUrl="~/images/delete.gif" ToolTip="<%$ Resources:ImgCancel %>" CausesValidation="False" CommandName="Cancel_Insert" />
                
</FooterTemplate>

<ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
                    <asp:ImageButton ID="imgEdit" runat="server" CommandName="Edit" ImageUrl="~/images/iedit.gif" ToolTip="<%$ Resources:ImgEdit %>" />
                                
</ItemTemplate>

<FooterStyle Width="50px"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column14 %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" ImageUrl="~/images/idelete.gif" ToolTip="<%$ Resources:ImgDel %>" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender><cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender>
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
            <asp:ImageButton ID="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif"
                CommandArgument="First" CommandName="Page" />
            &nbsp;<asp:ImageButton ID="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif"
                CommandArgument="Prev" CommandName="Page" />
            <asp:Label ID="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label>
            <asp:TextBox ID="txtHalaman" runat="server" AutoPostBack="True" Columns="3" MaxLength="3"
                OnTextChanged="txtHalaman_TextChanged"></asp:TextBox>
            <asp:Label ID="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label>
            <asp:Label ID="lblJumlahHalaman" runat="server" Text="Label"></asp:Label>
            &nbsp;<asp:ImageButton ID="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif"
                CommandArgument="Next" CommandName="Page" />
            <asp:ImageButton ID="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandArgument="Last" CommandName="Page" />
        
</PagerTemplate>

<EditRowStyle VerticalAlign="Top"></EditRowStyle>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsPPHSTatus" runat="server" OnUpdated="dsijin_Updated" OnInserting="dsijin_Inserting" OnInserted="dsijin_Inserted" OnDeleted="dsijin_Deleted" ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taPPHStatus WHERE (TAHUN = @TAHUN)" InsertCommand="INSERT INTO taPPHStatus(TAHUN, BULAN, WAKTU_UPLOAD, PAJAK_TAHUNAN, BULAN_AWAL, TAHUN_AWAL, BULAN_AKHIR, TAHUN_AKHIR) VALUES (@TAHUN, @BULAN, @WAKTU_UPLOAD, @PAJAK_TAHUNAN, @BULAN_AWAL, @TAHUN_AWAL, @BULAN_AKHIR, @TAHUN_AKHIR)" SelectCommand="SELECT TAHUN, BULAN, WAKTU_UPLOAD, PAJAK_TAHUNAN, BULAN_AWAL, TAHUN_AWAL, BULAN_AKHIR, TAHUN_AKHIR, CASE WHEN PAJAK_TAHUNAN = 0 THEN 'Bulanan' ELSE 'Tahunan' END AS TIPE_PAJAK FROM taPPHStatus ORDER BY TAHUN DESC, BULAN DESC" UpdateCommand="UPDATE taPPHStatus SET PAJAK_TAHUNAN = @PAJAK_TAHUNAN, BULAN_AWAL = @BULAN_AWAL, TAHUN_AWAL = @TAHUN_AWAL, BULAN_AKHIR = @BULAN_AKHIR, TAHUN_AKHIR = @TAHUN_AKHIR WHERE (TAHUN = @TAHUN AND BULAN = @BULAN)"><DeleteParameters>
<asp:Parameter Name="TAHUN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter DefaultValue="" Name="TAHUN"></asp:Parameter>
<asp:Parameter Name="BULAN"></asp:Parameter>
<asp:Parameter Name="WAKTU_UPLOAD"></asp:Parameter>
<asp:Parameter Name="PAJAK_TAHUNAN"></asp:Parameter>
<asp:Parameter Type="Int32" DefaultValue="" Name="BULAN_AWAL"></asp:Parameter>
<asp:Parameter Type="Int32" DefaultValue="" Name="TAHUN_AWAL"></asp:Parameter>
<asp:Parameter Type="Int32" DefaultValue="" Name="BULAN_AKHIR"></asp:Parameter>
<asp:Parameter Type="Int32" DefaultValue="" Name="TAHUN_AKHIR"></asp:Parameter>
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="TAHUN"></asp:Parameter>
<asp:Parameter Name="BULAN"></asp:Parameter>
<asp:Parameter Name="WAKTU_UPLOAD"></asp:Parameter>
<asp:Parameter Name="PAJAK_TAHUNAN"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="BULAN_AWAL"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="TAHUN_AWAL"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="BULAN_AKHIR"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="TAHUN_AKHIR"></asp:Parameter>
</InsertParameters>
</asp:SqlDataSource>  
</contenttemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="100" DynamicLayout="False">
                    <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing=0 cellpadding=0 width=200><tr><td class="headermessage" align=center><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align=center><table id="table2" cellspacing=4 cellpadding=3 border=0><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></table></asp:Panel> 
</progresstemplate>
                </asp:UpdateProgress><asp:Panel ID="PNLKonfirmasi" runat="server" Style="border-right: black 2px solid;
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
            </td>
        </tr>
        <tr>
            <td>
                &nbsp; &nbsp;
            </td>
        </tr>
    </table>
            <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
        Visible="False"></asp:Label><asp:Label
                ID="lblNotSaved" runat="server" Text="<%$ Resources:Resource, lblNotSaved %>"
                Visible="False"></asp:Label>
    
</asp:Content>

