<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="connection.aspx.cs" Inherits="rtwin.connection" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara"  Culture="auto:id-ID" UICulture="auto" Debug="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">

   <table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="backgroundTitle" style="width: 200px">
                <img src="images/back_title.gif" height="27px" style="vertical-align:middle" alt=""/>&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
            </td>
        </tr>
    </table>
                             <asp:ScriptManager id="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <br /><asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" meta:resourceKey="ImgAdd" AlternateText="<%$ Resources:ImgAdd %>" ImageUrl="images/ipost.gif"></asp:ImageButton> <asp:LinkButton id="lnkBtnInsert" onclick="lnkBtnInsert_Click" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton> <br /><br />
                        <asp:GridView id="GvConnection" runat="server" width="100%" DataSourceID="dsConnection" OnRowDataBound="GvConnection_RowDataBound" OnRowCommand="GvConnection_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NO_MESIN" GridLines="Vertical" OnDataBound="GvConnection_DataBound" OnRowEditing="GvConnection_RowEditing" EnableModelValidation="True">
<EmptyDataRowStyle width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="NO_MESIN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
<asp:Label id="lblCol0Edit" runat="server" Text='<%# Bind("NO_MESIN") %>'></asp:Label> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol0Footer" runat="server" Columns="1" MaxLength="3" SkinID="textBoxJam"></asp:TextBox> <asp:RequiredFieldValidator id="valCol0Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</FooterTemplate>

<ItemStyle height="17px" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>

<HeaderStyle width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("NO_MESIN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_MESIN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
<asp:TextBox id="txtCol1Edit" runat="server" Text='<%# Bind("NAMA_MESIN") %>' Columns="20" MaxLength="50" Width="130px"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Edit" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Edit" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator> 
</EditItemTemplate>
<FooterTemplate>
<asp:TextBox id="txtCol1Footer" runat="server" Columns="20" MaxLength="30" Width="130px"></asp:TextBox> <asp:RequiredFieldValidator id="valCol1Footer" runat="server" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1Footer" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator>&nbsp; 
</FooterTemplate>

<HeaderStyle width="20%"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA_MESIN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField SortExpression="TIPE_KONEKSI" HeaderText="<%$ Resources:Column2 %>">

        <EditItemTemplate>
            <asp:DropDownList ID="DDList2Edit" runat="server" AppendDataBoundItems="True" SelectedValue='<%# BIND("TIPE_KONEKSI") %>'>
                <asp:ListItem Value="1">Direct</asp:ListItem>
                <asp:ListItem Value="2">Ethernet</asp:ListItem>
                <asp:ListItem Value="3">Modem</asp:ListItem>
                <asp:ListItem Value="4">KIOSK</asp:ListItem>
                <asp:ListItem Selected="True"></asp:ListItem>
            </asp:DropDownList>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:DropDownList ID="DDListCol2Footer" runat="server">
                <asp:ListItem Value="1">Direct</asp:ListItem>
                <asp:ListItem Value="2">Ethernet</asp:ListItem>
                <asp:ListItem Value="3">Modem</asp:ListItem>
                <asp:ListItem Value="4">KIOSK</asp:ListItem>
            </asp:DropDownList>
        </FooterTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol2Item" runat="server" Text='<%# Bind("NAMA_KONEKSI") %>'></asp:Label>
        </ItemTemplate>
        <HeaderStyle Width="15%" />

    </asp:TemplateField>
    <asp:TemplateField SortExpression="ALAMAT_KONEKSI" HeaderText="<%$ Resources:Column3 %>">

        <EditItemTemplate>
            <asp:TextBox ID="txtCol3Edit" runat="server" Columns="20" MaxLength="30" Text='<%# Bind("ALAMAT_KONEKSI") %>' Width="100px"></asp:TextBox>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:TextBox ID="txtCol3Footer" runat="server" Columns="20" MaxLength="30" Text='<%# Bind("ALAMAT_KONEKSI") %>' Width="100px"></asp:TextBox>
        </FooterTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol3Item" runat="server" Text='<%# Bind("ALAMAT_KONEKSI") %>'></asp:Label>
        </ItemTemplate>
        <HeaderStyle Width="15%" />

    </asp:TemplateField>
    <asp:TemplateField SortExpression="NO_READER" HeaderText="<%$ Resources:Column4 %>">

        <EditItemTemplate>
            <asp:TextBox ID="txtCol4Edit" runat="server" Columns="20" MaxLength="30" Text='<%# Bind("NO_READER") %>' Width="20px"></asp:TextBox>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:TextBox ID="txtCol4Footer" runat="server" Columns="20" MaxLength="30" Text='<%# Bind("NO_READER") %>' Width="20px"></asp:TextBox>
        </FooterTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol4Item" runat="server" Text='<%# Bind("NO_READER") %>'></asp:Label>
        </ItemTemplate>
        <HeaderStyle Width="8%" HorizontalAlign="Center" VerticalAlign="Middle" />

    </asp:TemplateField>
    <asp:TemplateField SortExpression="IN_OUT" HeaderText="<%$ Resources:Column5 %>">

        <EditItemTemplate>
            <asp:DropDownList ID="DDListCol5Edit" runat="server" SelectedValue='<%# BIND("IN_OUT") %>' AppendDataBoundItems="True">
                <asp:ListItem Value="1">IN</asp:ListItem>
                <asp:ListItem Value="2">Out</asp:ListItem>
                <asp:ListItem Value="3">Both</asp:ListItem>
                <asp:ListItem></asp:ListItem>
            </asp:DropDownList>
        </EditItemTemplate>
        <FooterTemplate>
            <asp:DropDownList ID="DDListCol5Footer" runat="server">
                <asp:ListItem Value="1">IN</asp:ListItem>
                <asp:ListItem Value="2">Out</asp:ListItem>
                <asp:ListItem Value="3">Both</asp:ListItem>
            </asp:DropDownList>
        </FooterTemplate>
        <ItemTemplate>
            <asp:Label ID="lblCol5Item" runat="server" Text='<%# Bind("MODE_MESIN") %>'></asp:Label>
        </ItemTemplate>
        <FooterStyle HorizontalAlign="Center" VerticalAlign="Middle" />
        <HeaderStyle Width="10%" HorizontalAlign="Center" VerticalAlign="Middle" />
        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />

    </asp:TemplateField>
    <asp:TemplateField SortExpression="MESIN_AKTIF" HeaderText="<%$ Resources:Column6 %>">

        <EditItemTemplate>
            <asp:CheckBox ID="CBoxCol5Edit" runat="server" Checked='<%# BIND("MESIN_AKTIF") %>' />
        </EditItemTemplate>
        <FooterTemplate>
            <asp:CheckBox ID="CBoxCol5Footer" runat="server" Checked='<%# BIND("MESIN_AKTIF") %>' />
        </FooterTemplate>
        <ItemTemplate>
            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# BIND("MESIN_AKTIF") %>' Enabled="False" />
        </ItemTemplate>
        <HeaderStyle Width="5%" />
        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />

    </asp:TemplateField>
    <asp:TemplateField SortExpression="MESIN_UPACARA">
        <ItemTemplate>
            <asp:CheckBox ID="CheckBox2" runat="server" 
                Checked='<%# Eval("MESIN_UPACARA") %>' Enabled="False" />
        </ItemTemplate>
        <EditItemTemplate>
            <asp:CheckBox ID="CheckBox3" runat="server" 
                Checked='<%# BIND("MESIN_UPACARA") %>' />
        </EditItemTemplate>
        <FooterTemplate>
            <asp:CheckBox ID="CheckBox4" runat="server" />
        </FooterTemplate>
    </asp:TemplateField>
    <asp:TemplateField SortExpression="NAMA_LOKASI" HeaderText="<%$ Resources:Column7 %>">

        <EditItemTemplate>
            <asp:DropDownList ID="DDListCol7Edit" runat="server" DataSourceID="dsLocation" DataTextField="NAMA_LOKASI" DataValueField="KODE_LOKASI" SelectedValue='<%# BIND("KODE_LOKASI") %>'>
            </asp:DropDownList>
        </EditItemTemplate>

        <FooterTemplate>
            <asp:DropDownList ID="DDListCol7Footer" runat="server" DataSourceID="dsLocation" DataTextField="NAMA_LOKASI" DataValueField="KODE_LOKASI" SelectedValue='<%# BIND("KODE_LOKASI") %>'>
            </asp:DropDownList>
        </FooterTemplate>

        <ItemTemplate>
            <asp:Label ID="lblCol7Item" runat="server" Text='<%# Bind("NAMA_LOKASI") %>'></asp:Label>
        </ItemTemplate>
        <HeaderStyle Width="25%" />

    </asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column8 %>"><EditItemTemplate>
<asp:ImageButton id="imgUpdate" runat="server" AlternateText="<%$ Resources:ImgUpdate %>" ImageUrl="~/Images/edit.gif" CommandName="Update"></asp:ImageButton><asp:ImageButton id="imgCancel" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel"></asp:ImageButton> 
</EditItemTemplate>
<FooterTemplate>
<asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" CommandName="Insert"></asp:ImageButton><asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel_Insert"></asp:ImageButton> 
</FooterTemplate>

<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgEdit" runat="server" AlternateText="<%$ Resources:ImgEdit %>" ImageUrl="~/Images/iedit.gif" CommandName="Edit"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle horizontalalign="Center"></FooterStyle>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Column9 %>">
<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="50px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" displaymodalpopupid="ModalPopupExtender1" targetcontrolid="imgDelete"></cc1:ConfirmButtonExtender> <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" backgroundcssclass="modalBackground" PopupControlID="PNLKonfirmasi" OkControlID="btnOK" CancelControlID="btnCancel"></cc1:ModalPopupExtender> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView> 
                        <asp:SqlDataSource id="dsConnection" runat="server" 
                            OnUpdated="dsConnection_Updated" OnDeleted="dsConnection_Deleted" 
                            OnInserted="dsConnection_Inserted" OnInserting="dsConnection_Inserting" 
                            ConnectionString="<%$ ConnectionStrings:strCn %>" 
                            DeleteCommand="DELETE FROM taKoneksi WHERE (NO_MESIN = @NO_MESIN)" 
                            InsertCommand="INSERT INTO taKoneksi(NO_MESIN, NAMA_MESIN,TIPE_KONEKSI,ALAMAT_KONEKSI,NO_READER,IN_OUT,KODE_LOKASI) VALUES (@NO_MESIN, @NAMA_MESIN,@TIPE_KONEKSI,@ALAMAT_MESIN,@NO_READER,@MODE_MESIN,@KODE_LOKASI)" SelectCommand="SELECT taKoneksi.NO_MESIN ,taKoneksi.NAMA_MESIN,taKoneksi.TIPE_KONEKSI,
case taKoneksi.TIPE_KONEKSI 
when 1 then 'Direct' when 2 then 'Ethernet' when 3 then 'Modem' when 4 then 'KIOSK' end as NAMA_KONEKSI,
taKoneksi.ALAMAT_KONEKSI ,taKoneksi.NO_READER,taKoneksi.IN_OUT,
case taKoneksi.IN_OUT 
when 1 then 'IN' when 2 then 'OUT' when 3 then 'BOTH' end as MODE_MESIN,
taKoneksi.MESIN_AKTIF ,taKoneksi.MESIN_UPACARA,taKoneksi.NO_MESIN,taKoneksi.KODE_LOKASI,taLokasi.NAMA_LOKASI
from taKoneksi
LEFT JOIN taLokasi ON taLokasi.KODE_LOKASI = taKoneksi.KODE_LOKASI" 
                            UpdateCommand="UPDATE taKoneksi SET NAMA_MESIN = @NAMA_MESIN,TIPE_KONEKSI=@TIPE_KONEKSI,ALAMAT_KONEKSI = @ALAMAT_KONEKSI,IN_OUT=@IN_OUT,NO_READER=@NO_READER,MESIN_AKTIF=@MESIN_AKTIF,MESIN_UPACARA=@MESIN_UPACARA,KODE_LOKASI=@KODE_LOKASI WHERE (NO_MESIN = @NO_MESIN)"><DeleteParameters>
<asp:Parameter Name="NO_MESIN"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="NAMA_MESIN"></asp:Parameter>
<asp:Parameter Name="NO_MESIN"></asp:Parameter>
    <asp:Parameter Name="KODE_LOKASI" />
    <asp:Parameter Name="ALAMAT_KONEKSI" />
    <asp:Parameter Name="NO_READER" />
    <asp:Parameter Name="IN_OUT" />
    <asp:Parameter Name="TIPE_KONEKSI" />
    <asp:Parameter Name="MESIN_AKTIF" />
    <asp:Parameter Name="MESIN_UPACARA" />
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="NO_MESIN"></asp:Parameter>
<asp:Parameter Name="NAMA_MESIN"></asp:Parameter>
    <asp:Parameter Name="KODE_LOKASI" />
    <asp:Parameter Name="TIPE_KONEKSI" />
    <asp:Parameter Name="ALAMAT_MESIN" />
    <asp:Parameter Name="NO_READER" />
    <asp:Parameter Name="MODE_MESIN" />
</InsertParameters>
</asp:SqlDataSource>
                        <br />
                        <asp:SqlDataSource ID="dsLocation" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"   SelectCommand="SELECT KODE_LOKASI, NAMA_LOKASI FROM taLokasi 
WHERE KODE_LOKASI &lt;&gt; '-'
ORDER BY KODE_LOKASI" UpdateCommand=" ">
                        </asp:SqlDataSource>
                        <asp:FormView id="FvInstitutions" runat="server" DataSourceID="dsConnection" DataKeyNames="NO_MESIN" EmptyDataText="<%$ Resources:lblEmptyData %>" OnItemCommand="FvInstitutions_ItemCommand" EnableModelValidation="True"><InsertItemTemplate>
<table style="WIDTH: 400px; BORDER-COLLAPSE: collapse" cellspacing="0" cellpadding="2" border="1">
    <tbody><tr><td style="WIDTH: 50px" class="HeaderStyle" align="center">
        <asp:Label id="Label1" runat="server" Text="<%$ Resources:Column9 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></td><td style="WIDTH: 300px" class="HeaderStyle" align="center"><asp:Label id="Label2" runat="server" Text="<%$ Resources:Column1 %>" forecolor="Yellow" Font-Size="XX-Small"></asp:Label></td><td style="WIDTH: 50px" class="HeaderStyle"></td></tr><tr><td class="FooterStyle"><asp:TextBox id="txtCol0FormView" runat="server" Text='<%# Bind("NO_MESIN") %>' Columns="1" MaxLength="1"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol0FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol0FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></td><td class="FooterStyle"><asp:TextBox id="txtCol1FormView" runat="server" Text='<%# Bind("NAMA_MESIN") %>' Columns="20" MaxLength="30"></asp:TextBox>&nbsp;<asp:RequiredFieldValidator id="valCol1FormView" runat="server" CssClass="fontR" forecolor="" ErrorMessage="<%$ Resources:Resource, lblFieldCannotEmpty %>" ControlToValidate="txtCol1FormView" SetFocusOnError="True" EnableClientScript="True">*</asp:RequiredFieldValidator></td><td class="FooterStyle"><asp:ImageButton id="imgInsert" runat="server" AlternateText="<%$ Resources:ImgInsert %>" ImageUrl="~/Images/edit.gif" CommandName="Insert"></asp:ImageButton>&nbsp;<asp:ImageButton id="imgCancelInsert" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgCancel %>" ImageUrl="~/Images/delete.gif" CommandName="Cancel"></asp:ImageButton></td></tr></tbody></table>
</InsertItemTemplate>
</asp:FormView> 
</contenttemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="100" DynamicLayout="False">
                    <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server" BackColor="White">
    <asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label>  
        <img id="imgProgress" alt="" src="images/loading.gif" runat="server" /> 
        </asp:Panel> 
</progresstemplate>
                    
                </asp:UpdateProgress><asp:Panel ID="PNLKonfirmasi" runat="server" Style="border-right: black 2px solid;
                    padding-right: 20px; border-top: black 2px solid; display: none; padding-left: 20px;
                    padding-bottom: 20px; border-left: black 2px solid; width: 300px; padding-top: 20px;
                    border-bottom: black 2px solid; background-color: white">
                    <asp:Label ID="lblConfirmTitle" runat="server" Font-Bold="True" Font-Size="Small"
                        Text="<%$ Resources:Resource, lblConfirmation %>"></asp:Label>
                    <hr />
                   
                                <asp:Label ID="lblConfirmDelete" runat="server" Font-Bold="True" Font-Size="Small"
                                    Text="<%$ Resources:Resource, lblConfirmDelete %>"></asp:Label> 
                       
                                <asp:Button ID="btnOK" runat="server" Text="OK" />&nbsp;<asp:Button ID="btnCancel"
                                    runat="server" Text="<%$ Resources:ImgCancel %>" /> 
                 
                    <div style="text-align: right">
                        &nbsp;</div>
                </asp:Panel>
                <asp:Label ID="lblError" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False"></asp:Label>
                        
  
</asp:Content>



