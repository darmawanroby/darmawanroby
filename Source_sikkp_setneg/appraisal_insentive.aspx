<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage.master" Inherits="rtwin.appraisal_insentive" CodeFile="appraisal_insentive.aspx.cs" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
      <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:250px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" AsyncPostBackTimeOut="36000" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" EnableClientScript="True" __designer:wfdid="w92"></asp:ValidationSummary> <asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" __designer:wfdid="w93" EnableViewState="False"></asp:Label> <TABLE class="border_table" cellSpacing=0 cellPadding=0 width="100%"><TBODY><TR><TD style="WIDTH: 100px"><BR /><TABLE cellSpacing=0 width=500 border=0><TBODY>
<tr>
    <td width="100px">
        <asp:Label ID="Label6" runat="server" Text="<%$ Resources:lblNIP %>"></asp:Label>
    </td>
    <td>
        <asp:TextBox ID="TxtNIP" width="150px" runat="server"></asp:TextBox><br />
        <asp:Label ID="LabelNama" runat="server"></asp:Label>
    </td>
    <td>&nbsp;
        <asp:LinkButton ID="lnkFilterItem0" runat="server" CausesValidation="False" 
            onclick="lnkCol2Footer_Click">Lookup</asp:LinkButton>
    </td>
</tr>
<tr><td>&nbsp;</td>
</tr>
<TR>
    <td style="height: 24px" align="left" vAlign="middle" width="15">

                     <asp:Label ID="Label4" runat="server" Font-Size="10pt" 
                         Text="<%$ Resources:lblBulan %>"></asp:Label>

                     </td>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                   <TD style="WIDTH: 100px; height: 24px;" vAlign=top align=left>
                    <asp:DropDownList ID="DropBulan" runat="server" AutoPostBack="True" 
                        ontextchanged="DropBulan_TextChanged">
                    </asp:DropDownList>
                </TD>
    <TD style="height: 24px">
                    <asp:Label ID="Label5" runat="server" Font-Size="10pt" 
                        Text="<%$ Resources:lblTahun %>"></asp:Label>
                </TD>
        <td style="height: 24px" align="left" valign="top">
            
            <asp:DropDownList ID="ddlTahun" runat="server">
            </asp:DropDownList>
            
        </td>
                <TD width="15" style="height: 24px">
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Proses" />
                </TD>

                                                                                                                                                                                                                                                                                                                                                                                                                                                                   </TR>
                </TBODY></TABLE></TD></TR></TBODY></TABLE><TABLE class="border_table" cellSpacing=0 cellPadding=0 width="90%" border=0><TBODY><TR><TD style="WIDTH: 100%" align=left>&nbsp; <BR /><BR /> <asp:LinkButton id="lnkLookupTriger" runat="server" __designer:wfdid="w138"></asp:LinkButton> <cc1:ModalPopupExtender id="LookupMPE" runat="server" __designer:wfdid="w112" BackgroundCssClass="modalBackground" Drag="True" PopupControlID="PNL_Lookup" targetcontrolid="lnkLookupTriger"></cc1:ModalPopupExtender> </TD></TR></TBODY></TABLE>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server" __designer:wfdid="w10"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..." __designer:wfdid="w11"></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign=bottom align=right></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:SqlDataSource ID="dsLevel" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>"
        SelectCommand="SELECT [KODE_LEVEL], [NAMA_LEVEL] FROM [taUserLevel] WHERE KODE_LEVEL >= @KODE_LEVEL ORDER BY KODE_LEVEL">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="1" Name="KODE_LEVEL" SessionField="GradeID" />
        </SelectParameters>
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
                    <asp:Label ID="lblConfirm" runat="server" Font-Bold="True" Font-Size="Small" Text="<%$ Resources:confirm %>"></asp:Label>
                </td>
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
        border-left: black 2px solid; width: 300px; padding-top: 20px; border-bottom: black 2px solid;
        background-color: white; width:600px">
        <div style="text-align: left">
            <asp:UpdatePanel id="UpdatePanel2" runat="server">
                <contenttemplate>
<asp:Label id="lblLookupTitle" runat="server" Font-Bold="True" Text="<%$ Resources:Resource, lblPilihPegawai %>" Font-Size="Small" __designer:wfdid="w122"></asp:Label> 
<HR />
 <asp:TextBox id="txtLookupCariPegawai" runat="server" AutoPostBack="True" __designer:wfdid="w124" Columns="30" OnTextChanged="btnLookupCari_Click"></asp:TextBox>&nbsp;<asp:Button id="btnLookupCari" onclick="btnLookupCari_Click" runat="server" Text="<%$ Resources:Resource, lblCari %>" CausesValidation="False" __designer:wfdid="w125"></asp:Button><br /><br /><table><tbody><tr><td colspan="2"><asp:GridView id="GvLookupPegawai" runat="server" OnSelectedIndexChanged="GvLookupPegawai_SelectedIndexChanged" width="570px" DataSourceID="dsLookup" __designer:wfdid="w126" OnDataBound="GvLookupPegawai_DataBound" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="NIP"><Columns>
<asp:TemplateField SortExpression="NIP" HeaderText="NIP"><EditItemTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("NIP") %>'></asp:Label>
                                                
</EditItemTemplate>

<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("NIP") %>' __designer:wfdid="w271"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:BoundField DataField="PIN" SortExpression="PIN" HeaderText="PIN">
<HeaderStyle width="100px"></HeaderStyle>
</asp:BoundField>
<asp:TemplateField SortExpression="NAMA" HeaderText="<%$ Resources:Resource, lblNama %>"><EditItemTemplate>
<asp:TextBox id="TextBox1" runat="server" Text='<%# Bind("NAMA") %>' __designer:wfdid="w42"></asp:TextBox> 
</EditItemTemplate>

<HeaderStyle width="300px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label2" runat="server" Text='<%# Bind("NAMA") %>' __designer:wfdid="w41"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField HeaderText="<%$ Resources:Resource, lblPilih %>" ShowHeader="False">
<HeaderStyle width="70px"></HeaderStyle>
<ItemTemplate>
<asp:LinkButton id="LinkButton1" runat="server" Text="<%$ Resources:Resource, lblPilih %>" CausesValidation="False" __designer:wfdid="w269" CommandName="Select"></asp:LinkButton> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="btnfirst" runat="server" CausesValidation="False" __designer:wfdid="w168" ImageUrl="~/images/buttonfirst.gif" CommandName="Page" CommandArgument="First"></asp:ImageButton> &nbsp;<asp:ImageButton id="btnprev" runat="server" CausesValidation="False" __designer:wfdid="w169" ImageUrl="~/images/buttonprev.gif" CommandName="Page" CommandArgument="Prev"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w170"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" __designer:wfdid="w171" OnTextChanged="txtHalamanLookup_TextChanged" Columns="3" MaxLength="3"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w172"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" __designer:wfdid="w173"></asp:Label> &nbsp;<asp:ImageButton id="btnnext" runat="server" CausesValidation="False" __designer:wfdid="w174" ImageUrl="~/images/buttonnext.gif" CommandName="Page" CommandArgument="Next"></asp:ImageButton> <asp:ImageButton id="btnlast" runat="server" CausesValidation="False" __designer:wfdid="w175" ImageUrl="~/images/buttonlast.gif" CommandName="Page" CommandArgument="Last"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow"></HeaderStyle>
</asp:GridView> <asp:SqlDataSource id="dsLookup" runat="server" __designer:wfdid="w127" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT [NIP], [PIN], [NAMA], [KODE_CABANG], [KODE_DEPARTEMEN] FROM [taKaryawan] ORDER BY [NIP]"></asp:SqlDataSource> </td></tr><tr><td style="HEIGHT: 26px" valign=middle colspan="2"><asp:ImageButton id="imgLookupCancel" onclick="imgLookupCancel_Click" runat="server" CausesValidation="False" __designer:wfdid="w128" AlternateText="<%$ Resources:Resource, lblClose %>" ImageUrl="~/images/exit4_16.png"></asp:ImageButton>&nbsp;<asp:LinkButton id="lnkLookupClose" onclick="lnkLookupClose_Click" runat="server" Text="<%$ Resources:Resource, lblClose %>" CausesValidation="False" __designer:wfdid="w270"></asp:LinkButton></td></tr></tbody></table>
</contenttemplate>
            </asp:UpdatePanel>
            &nbsp;</div>
    </asp:Panel>
    <asp:Label ID="lblIDNotFound" runat="server" Text="<%$ Resources:Resource, lblIDNotFound %>" Visible="False"></asp:Label>
                    <asp:Label ID="lblCannotUpdate" runat="server" Text="<%$ Resources:Resource, lblCannotUpdate %>"
                        Visible="False"></asp:Label><asp:Label ID="lblNotSaved" runat="server"
                            Text="<%$ Resources:Resource, lblNotSaved %>" Visible="False" width="704px"></asp:Label><br />
                              
</asp:Content>
			