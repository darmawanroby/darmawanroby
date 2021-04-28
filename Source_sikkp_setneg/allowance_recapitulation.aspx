<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="allowance_recapitulation.aspx.cs" Inherits="rtwin.allowrekap" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia"  Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
<table border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td class="backgroundTitle" style="width: 350px">
                <img src="images/back_title.gif" height="27px" style="vertical-align:middle" alt=""/>&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="0" class="border_table" cellspacing="0" width="100%">
        <tr>
            <td align="left" style="width: 90%">
                <asp:ScriptManager id="ScriptManager1" runat="server"></asp:ScriptManager>
                <asp:UpdatePanel id="UpdatePanel1" runat="server">
                    <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label> <BR />
                    <!--    <asp:ImageButton style="POSITION: static" id="ImgBtnAdd" onclick="ImgBtnAdd_Click" runat="server" meta:resourceKey="ImgAdd" AlternateText="<%$ Resources:ImgAdd %>" ImageUrl="images/ipost.gif"></asp:ImageButton> -->
                        
                        <asp:LinkButton id="lnkBtnInsert" runat="server" Text="<%$ Resources:ImgAdd %>"></asp:LinkButton>
                        <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="lnkBtnInsert" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender> <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="lnkBtnInsert" CancelControlID="Button2" OkControlID="Button1" PopupControlID="PNLKonfirmasi2" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
                        
                        
                         <BR /><BR />
                        <asp:GridView id="GvAllowanceRecap" runat="server" width="650px" DataSourceID="dsAllowanceRecap" OnRowCommand="GvAllowanceRecap_RowCommand" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_RAPEL" GridLines="Vertical" OnDataBound="GvGolongan_DataBound" OnRowEditing="GvAllowanceRecap_RowEditing" EnableModelValidation="True">
<EmptyDataRowStyle Width="300px"></EmptyDataRowStyle>
<Columns>
<asp:TemplateField SortExpression="TGL_RAPEL" HeaderText="<%$ Resources:Column0 %>">
     
<ItemStyle Height="17px" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>

<HeaderStyle Width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol0Item" runat="server" Text='<%# Bind("KODE_RAPEL") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>

<asp:TemplateField SortExpression="BULAN_AWAL" HeaderText="<%$ Resources:Column1 %>">
    
    

<HeaderStyle Width="150px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("BULAN_AWAL") %>'></asp:Label> 
</ItemTemplate>
    <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
</asp:TemplateField>

    <asp:TemplateField HeaderText="<%$ Resources:Column2 %>" SortExpression="BULAN_AKHIR">
     
        <ItemStyle HorizontalAlign="Left" VerticalAlign="Middle" />
        <HeaderStyle Width="150px" />
        <ItemTemplate>
            <asp:Label ID="lblCol1aItem" runat="server" Text='<%# Bind("BULAN_AKHIR") %>'></asp:Label>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField SortExpression="TAHUN" HeaderText="<%$ Resources:Column3 %>">
   
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>

<HeaderStyle Width="50px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("TAHUN") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
    
    <asp:TemplateField HeaderText="<%$ Resources:Column4 %>" SortExpression="PAJAK_GOLONGAN">
       
        <ItemTemplate>
             
<asp:ImageButton id="imgDelete" runat="server" CausesValidation="False" AlternateText="<%$ Resources:ImgDel %>" ImageUrl="~/Images/idelete.gif" CommandName="Delete"></asp:ImageButton> <cc1:ConfirmButtonExtender id="ConfirmButtonExtender1" runat="server" targetcontrolid="imgDelete" displaymodalpopupid="ModalPopupExtender1"></cc1:ConfirmButtonExtender>
             <cc1:ModalPopupExtender id="ModalPopupExtender1" runat="server" targetcontrolid="imgDelete" CancelControlID="btnCancel" OkControlID="btnOK" PopupControlID="PNLKonfirmasi" backgroundcssclass="modalBackground"></cc1:ModalPopupExtender> 
</ItemTemplate>
         
        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
    </asp:TemplateField>

<asp:TemplateField HeaderText="<%$ Resources:Column5 %>">
    
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:ImageButton id="rekapIndividu" runat="server" ImageUrl="~/Images/printer.gif" AlternateText="Cetak Rekap Individu" CommandName="CetakIndividu"></asp:ImageButton> 
</ItemTemplate>

<FooterStyle HorizontalAlign="Center"></FooterStyle>
</asp:TemplateField>

<asp:TemplateField HeaderText="<%$ Resources:Column6 %>">
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>

<HeaderStyle Width="50px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
 <asp:ImageButton id="rekapAll" runat="server" ImageUrl="~/Images/printer.gif" AlternateText="Cetak Rekap" CommandName="CetakRekap"></asp:ImageButton>
</ItemTemplate>
</asp:TemplateField>
    <asp:TemplateField HeaderText="Rekap Per Unit">
        <ItemTemplate>
            <asp:ImageButton ID="rekapSatker" runat="server" 
                AlternateText="Cetak Rekap Satker" CommandName="CetakRekapSatker" 
                ImageUrl="~/Images/printer.gif" />
        </ItemTemplate>
    </asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> 
                        
                        
                        <asp:SqlDataSource id="dsAllowanceRecap" runat="server"  ConnectionString="<%$ ConnectionStrings:strCn %>" DeleteCommand="DELETE FROM taRapelTKLog Where KODE_RAPEL =@KODE_RAPEL" InsertCommand="" SelectCommand="SELECT KODE_RAPEL,dbo.NamaBulan(BULAN_AWAL) AS BULAN_AWAL, dbo.NamaBulan(BULAN_AKHIR) AS BULAN_AKHIR,TAHUN from taRapelTKLog order by WAKTU_SIMPAN ASC" UpdateCommand="UPDATE taGolongan SET NAMA_GOLONGAN = @NAMA_GOLONGAN, TARIF_MAKAN = @TARIF_MAKAN, TARIF_LEMBUR = @TARIF_LEMBUR, TARIF_UANG_MAKAN_LEMBUR = @TARIF_UANG_MAKAN_LEMBUR, PAJAK_GOLONGAN = @PAJAK_GOLONGAN WHERE (KODE_GOLONGAN = @KODE_GOLONGAN)"><DeleteParameters>
<asp:Parameter Name="KODE_RAPEL"></asp:Parameter>
</DeleteParameters>
<UpdateParameters>
<asp:Parameter Name="KODE_GOLONGAN" DefaultValue=""></asp:Parameter>
<asp:Parameter Name="NAMA_GOLONGAN"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="PAJAK_GOLONGAN"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_MAKAN" />
<asp:Parameter DefaultValue="0" Name="TARIF_LEMBUR"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_UANG_MAKAN_LEMBUR" />
</UpdateParameters>
<InsertParameters>
<asp:Parameter Name="KODE_GOLONGAN"></asp:Parameter>
<asp:Parameter Name="NAMA_GOLONGAN"></asp:Parameter>
<asp:Parameter DefaultValue="0" Name="PAJAK_GOLONGAN"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_MAKAN" />
<asp:Parameter DefaultValue="0" Name="TARIF_LEMBUR"></asp:Parameter>
    <asp:Parameter DefaultValue="0" Name="TARIF_UANG_MAKAN_LEMBUR" />
</InsertParameters>
</asp:SqlDataSource>
                        
                   
</contenttemplate>
                </asp:UpdatePanel>
                <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
                    DisplayAfter="100" DynamicLayout="False">
                    <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgresstable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign="bottom" align="right"></td></tr></tbody></table></asp:Panel> 
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

                  <asp:Panel ID="PNLKonfirmasi2" runat="server" Style="border-right: black 2px solid;
                    padding-right: 20px; border-top: black 2px solid; display: none; padding-left: 20px;
                    padding-bottom: 20px; border-left: black 2px solid; width: 300px; padding-top: 20px;
                    border-bottom: black 2px solid; background-color: white">
                    <asp:Label ID="Label4" runat="server" Font-Bold="True" Font-Size="Small"
                        Text="<%$ Resources:Resource, lblConfirmation %>"></asp:Label>
                    <hr />
                    <table>
                        <tr>
                            <td colspan="2">
                                <asp:Label ID="Label6" runat="server" Font-Bold="True" Font-Size="Small"
                                    Text="Proses Rapel Tunjangan Kinerja"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <table width="500px">
                                    <tr>
                                        <td width="100px">
                                            <asp:Label ID="Label7" runat="server" Text="Bulan Awal"></asp:Label></td>
                                        <td>
                                            <asp:DropDownList ID="ddlBulanAwal" runat="server" style="font-size:9px"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td width="100px"><asp:Label ID="Label8" runat="server" Text="Bulan Akhir"></asp:Label></td>
                                        <td>
                                            <asp:DropDownList ID="ddlBulanAkhir" runat="server" style="font-size:9px"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td width="100px"><asp:Label ID="Label9" runat="server" Text="Tahun"></asp:Label></td>
                                        <td>
                                            <asp:TextBox ID="txtTahun" runat="server" Text="" Width="40px" style="font-size:9px"></asp:TextBox></td>
                                    </tr>
                                    
                                </table>

                            </td>
                        </tr>

                        <tr>
                            <td colspan="2" style="height: 26px">
                                <asp:Button ID="Button1" runat="server" Text="Proses" OnClick="Button1_Click" UseSubmitBehavior="False" />&nbsp;
                                <asp:Button ID="Button2"
                                    runat="server" Text="<%$ Resources:ImgCancel %>" /></td>
                        </tr>
                    </table>
                    <div style="text-align: right">
                        &nbsp;</div>
                </asp:Panel>


                <asp:Label ID="lblError" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                    Visible="False"></asp:Label><br />
                <br />
            </td>
        </tr>
       
    </table>
</asp:Content>



