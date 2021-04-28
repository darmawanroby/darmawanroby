<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" Title="Sistem Kehadiran Kerja Pegawai" AutoEventWireup="true" Inherits="rtwin.grant_department" CodeFile="grant_department.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table >
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align:middle" alt="" />&nbsp; <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><br /><br /><asp:Label id="lblUser" runat="server"></asp:Label><br /><br /><table class="border_table" cellspacing="0" cellpadding="0" width="90%" border="0"><tbody><tr><td style="WIDTH: 300px; HEIGHT: 13px" align="left"><asp:GridView id="GvOtoritasDepartemen" runat="server" DataSourceID="dsOtoritasDepartemen" OnRowCommand="GvOtoritasDepartemen_RowCommand" OnRowDataBound="GvOtoritasDepartemen_RowDataBound" OnDataBound="GvOtoritasDepartemen_DataBound" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="KODE_DEPARTEMEN"><Columns>
<asp:TemplateField SortExpression="KODE_DEPARTEMEN" HeaderText="<%$ Resources:Column0 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>
<FooterTemplate>
&nbsp; 
</FooterTemplate>

<HeaderStyle width="100px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label1" runat="server" Text='<%# Bind("KODE_DEPARTEMEN") %>' __designer:wfdid="w304"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="NAMA_DEPARTEMEN" HeaderText="<%$ Resources:Column1 %>"><EditItemTemplate>
&nbsp; 
</EditItemTemplate>
<FooterTemplate>
&nbsp; 
</FooterTemplate>

<HeaderStyle width="200px"></HeaderStyle>
<ItemTemplate>
<asp:Label id="Label2" runat="server" Text='<%# Bind("NAMA_DEPARTEMEN") %>' __designer:wfdid="w301"></asp:Label> 
</ItemTemplate>
</asp:TemplateField>
<asp:TemplateField SortExpression="STATUS" HeaderText="<%$ Resources:Column2 %>"><EditItemTemplate>
&nbsp;<br />
</EditItemTemplate>
<FooterTemplate>
&nbsp;<br />
</FooterTemplate>

<ItemStyle horizontalalign="Center"></ItemStyle>

<HeaderStyle width="60px" horizontalalign="Center"></HeaderStyle>
<ItemTemplate>
<asp:CheckBox id="chkSelect" runat="server" checked='<%# Bind("HAK") %>' __designer:wfdid="w303"></asp:CheckBox> 
</ItemTemplate>
</asp:TemplateField>
</Columns>
<PagerTemplate>
<asp:ImageButton id="BtnFirst" runat="server" ImageUrl="~/images/buttonFirst.gif" ImageAlign="Middle" CommandName="Page" CommandArgument="First" __designer:wfdid="w305"></asp:ImageButton>&nbsp; <asp:ImageButton id="BtnPrev" runat="server" ImageUrl="~/images/buttonPrev.gif" ImageAlign="Middle" CommandName="Page" CommandArgument="Prev" __designer:wfdid="w306"></asp:ImageButton> <asp:Label id="lblPage" runat="server" Text="<%$ Resources:Resource, lblHalaman %>" __designer:wfdid="w307"></asp:Label> <asp:TextBox id="txtHalaman" runat="server" AutoPostBack="True" OnTextChanged="txtHalaman_TextChanged" MaxLength="3" Columns="3" __designer:wfdid="w308"></asp:TextBox> <asp:Label id="lblOf" runat="server" Text="<%$ Resources:Resource, lblDari %>" __designer:wfdid="w309"></asp:Label> <asp:Label id="lblJumlahHalaman" runat="server" Text="Label" Font-Size="Small" __designer:wfdid="w310"></asp:Label>&nbsp; <asp:ImageButton id="BtnNext" runat="server" ImageUrl="~/images/buttonNext.gif" ImageAlign="Middle" CommandName="Page" CommandArgument="Next" __designer:wfdid="w311"></asp:ImageButton>&nbsp; <asp:ImageButton id="BtnLast" runat="server" ImageUrl="~/images/buttonLast.gif" ImageAlign="AbsMiddle" CommandName="Page" CommandArgument="Last" __designer:wfdid="w312"></asp:ImageButton> 
</PagerTemplate>

<HeaderStyle forecolor="Yellow" horizontalalign="Center"></HeaderStyle>
</asp:GridView><br /><asp:Button id="btnUpdate" onclick="btnUpdate_Click" runat="server" Text="<%$ Resources:imgUpdate %>"></asp:Button><br /><asp:Label id="lblKetAdmin" runat="server" Visible="False" CssClass="fontR" SkinID="fontR" Text="<%$ Resources:lblKetAdmin %>"></asp:Label><br /><asp:SqlDataSource id="dsOtoritasDepartemen" runat="server" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT KODE_DEPARTEMEN, NAMA_DEPARTEMEN, HAK FROM q_OtoritasDepartemen  &#13;&#10;WHERE (USERNAME = @USERNAME) " DeleteCommand="DELETE FROM taOtoritasDepartemen WHERE USERNAME=@USERNAME AND KODE_DEPARTEMEN=@KODE_DEPARTEMEN" UpdateCommand="INSERT INTO taOtoritasDepartemen(USERNAME,KODE_DEPARTEMEN) VALUES(@USERNAME,@KODE_DEPARTEMEN)" OnDeleted="dsOtoritasDepartemen_Deleted" OnUpdated="dsOtoritasDepartemen_Updated">
                        <SelectParameters>
                            <asp:SessionParameter Name="USERNAME" SessionField="strUser" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:SessionParameter Name="USERNAME" SessionField="strUser" />
                            <asp:Parameter Name="KODE_DEPARTEMEN" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:SessionParameter Name="USERNAME" SessionField="strUser" />
                            <asp:Parameter Name="KODE_DEPARTEMEN" />
                        </UpdateParameters>
                    </asp:SqlDataSource><br /></td></tr></tbody></table>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgresstable" cellspacing="0" cellpadding="0" width="200"><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tr><td><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign="bottom" align="right"></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
            <asp:HyperLink ID="lblBack" runat="server" NavigateUrl="~/users.aspx" Text="<%$ Resources:lblBack %>"></asp:HyperLink><br />
    <asp:Label ID="lblCannotEditApproved" runat="server" Text="<%$ Resources:Resource, lblCannotEditApproved %>"
                Visible="False"></asp:Label><br />
    <br />
</asp:Content>
			