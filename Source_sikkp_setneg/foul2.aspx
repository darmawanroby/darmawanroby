<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="foul2.aspx.cs" Inherits="rtwin.foul2" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" Culture="auto:id-ID" UICulture="auto" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:300px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><DIV id="hideForm" runat="server"><TABLE style="WIDTH: 100%" id="tableFilter" class="border_table" cellSpacing=0 cellPadding=0 border=0 runat="server"><TBODY><TR><TD style="WIDTH: 100%"><BR /><TABLE cellPadding=1 width=750 border=0><TBODY><TR><TD style="WIDTH: 200px" vAlign=top align=left><asp:Label id="lblTglAwal" runat="server" Text="<%$ Resources:Label1 %>" width="100px"></asp:Label></TD><TD style="WIDTH: 200px" vAlign=top align=left>
    <asp:DropDownList ID="ddlTahun" runat="server">
    </asp:DropDownList></TD><TD style="WIDTH: 50px" vAlign=top align=center></TD><TD style="WIDTH: 200px" vAlign=top align=left>
                            &nbsp; &nbsp;
                        </TD><TD style="WIDTH: 100px" vAlign=top><asp:Button id="btnRefresh" onclick="btnRefresh_Click" runat="server" Text="<%$ Resources:btnRefresh %>"></asp:Button></TD></TR><TR><TD><asp:Label id="lblNIP" runat="server" Text="<%$ Resources:Column0 %>" width="80px"></asp:Label><asp:Label id="lblPIN" runat="server" Text="PIN"></asp:Label></TD><TD style="HEIGHT: 13px" colSpan=4><asp:TextBox id="txtFilterItem2" runat="server" Text='<%# Bind("NIP") %>' AutoPostBack="True" width="100px"></asp:TextBox> <asp:LinkButton id="lnkFilterItem2" onclick="lnkFilterItem2_Click" runat="server" CausesValidation="False">Lookup</asp:LinkButton></TD></TR><TR><TD><asp:Label id="lblBiro" runat="server" Text="<%$ Resources:lblBiro %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem3" runat="server" OnSelectedIndexChanged="ddlFilterItem3_DataBound_SelectedChange" AutoPostBack="True" DataSourceID="dsBiro" DataValueField="KODE_DEPUTI" DataTextField="NAMA_DEPUTI" OnDataBound="ddlFilterItem3_DataBound_SelectedChange"></asp:DropDownList></TD></TR><TR><TD><asp:Label id="lblBagian" runat="server" Text="<%$ Resources:lblBagian %>"></asp:Label></TD><TD colSpan=4><asp:DropDownList id="ddlFilterItem4" runat="server" DataSourceID="dsBagian" DataValueField="KODE_BIRO" DataTextField="NAMA_BIRO"></asp:DropDownList></TD></TR>
</TBODY></TABLE></TD></TR></TBODY></TABLE></DIV><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%" border=0><TBODY><TR><TD style="WIDTH: 100%" vAlign=top rowSpan=2>
    &nbsp;
    <BR /><asp:GridView id="GvAkumulasi" runat="server" DataSourceID="dsAkumulasi" OnDataBound="GvAkumulasi_DataBound" OnRowDataBound="GvAkumulasi_RowDataBound" EmptyDataText="<%$ Resources:lblEmptyData %>" DataKeyNames="PIN,NIP" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True" OnRowEditing="GvAkumulasi_RowEditing" OnRowCommand="GvAkumulasi_RowCommand">
<EmptyDataRowStyle CssClass="fontR"></EmptyDataRowStyle>
<Columns>
    <asp:TemplateField HeaderText="NIP" SortExpression="NIP">
        <EditItemTemplate>
            <asp:Label ID="Label1" runat="server"></asp:Label>
        </EditItemTemplate>
        <HeaderStyle HorizontalAlign="Center" Width="100px" />
        <ItemTemplate>
            <asp:LinkButton ID="lnkCol0Item" runat="server" CommandName="Show" Text='<%# Eval("PIN") %>'></asp:LinkButton>
        </ItemTemplate>
    </asp:TemplateField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Column1 %>">
<HeaderStyle Width="140px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol1Item" runat="server" Text='<%# Bind("NAMA") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="JML_JAM_LAMBAT_CPTPLG" HeaderText="<%$ Resources:Column2a %>"><EditItemTemplate>
                                &nbsp;
                            
</EditItemTemplate>

<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="80px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol2Item" runat="server" Text='<%# Bind("JML_JAM_LAMBAT_CPTPLG") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="KONVERSI_MANGKIR" HeaderText="<%$ Resources:Column3a %>">
<ItemStyle HorizontalAlign="Center"></ItemStyle>

<HeaderStyle Width="60px" HorizontalAlign="Center"></HeaderStyle>
<ItemTemplate>
<asp:Label id="lblCol3Item" runat="server" Text='<%# Bind("KONVERSI_MANGKIR") %>'></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
                        <asp:TemplateField HeaderText="<%$ Resources:ImgSisip %>">
                            <HeaderStyle Width="50px" HorizontalAlign="Center"/>
                            <ItemTemplate>
                                <asp:ImageButton ID="imgSisip" runat="server" CausesValidation="False" CommandName="TambahPelanggaran"
                                    ImageUrl="~/images/sisip.png" AlternateText="<%$ Resources:ImgSisip %>" />
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
 </Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" MaxLength="3" Columns="3" OnTextChanged="txtHalaman_TextChanged"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle ForeColor="Yellow" HorizontalAlign="Center"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsAkumulasi" runat="server" SelectCommand="SELECT NIP, NAMA, JML_JAM_LAMBAT_CPTPLG, KONVERSI_MANGKIR, PIN FROM q_LambatCepatPulang" ConnectionString="<%$ ConnectionStrings:strCn %>" UpdateCommand="UPDATE taHukumanDisiplin SET TGL_AKHIR = @TGL_AKHIR, KODE_POTONGAN = @KODE_POTONGAN, TGL_PENETAPAN = @TGL_PENETAPAN, DOKUMEN_DISIPLIN = @DOKUMEN_DISIPLIN WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" InsertCommand="INSERT INTO taHukumanDisiplin(NIP, TGL_AWAL, TGL_AKHIR, KODE_POTONGAN, TGL_PENETAPAN, DOKUMEN_DISIPLIN) VALUES (@NIP, @TGL_AWAL, @TGL_AKHIR, @KODE_POTONGAN, @TGL_PENETAPAN, @DOKUMEN_DISIPLIN)" OnDeleted="dsAkumulasi_Deleted" DeleteCommand="DELETE FROM taHukumanDisiplin WHERE (NIP = @NIP) AND (TGL_AWAL = @TGL_AWAL)" OnUpdating="dsAkumulasiEdit_Updating" OnUpdated="dsAkumulasiEdit_Updated" OnInserting="dsAkumulasiEdit_Inserting" OnInserted="dsAkumulasiEdit_Inserted"><DeleteParameters>
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
                </asp:SqlDataSource> &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;<BR />
    <BR /><asp:LinkButton id="lnkLookupTriger" runat="server"></asp:LinkButton><cc1:ModalPopupExtender id="LookupMPE" runat="server" targetcontrolid="lnkLookupTriger" PopupControlID="PNL_Lookup" Drag="True" BackgroundCssClass="modalBackground"></cc1:ModalPopupExtender></TD></TR><TR></TR></TBODY></TABLE>
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



