<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="level.aspx.cs" Inherits="rtwin.level" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td align="left" valign="top">
                <table style="text-align:left">
                    <tr>
                        <td class="backgroundTitle" style="width: 200px">
                            <img style="vertical-align: middle" height="27" src="images/back_title.gif" alt="" />&nbsp;
                            <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 100%; height: 13px">
                <asp:Label ID="lblError" runat="server" CssClass="fontR" SkinID="fontR"></asp:Label>
            </td>
        </tr>
    </table>
    <br />
    <asp:RadioButton ID="radAdmin" runat="server" GroupName="level"
        Text="Administrator" /><br />
    <asp:RadioButton ID="radKeuangan" runat="server" GroupName="level"
        Text="Operator Keuangan" /><br />
    <asp:RadioButton ID="radValidator" runat="server" GroupName="level"
        Text="Validator Kepegawaian" /><br />
    <asp:RadioButton ID="radOperator" runat="server" GroupName="level"
        Text="Operator Kepegawaian" /><br />
    <asp:RadioButton ID="radViewer" runat="server" GroupName="level"
        Text="Viewer Laporan" /><br />
    <asp:RadioButton ID="radUser" runat="server" GroupName="level"
        Text="User" /><br />
    <br />
    <asp:Button ID="btnChangeLevel" runat="server" Text="<%$ Resources:lblGanti %>" width="70px" OnClick="btnChangeLevel_Click" /><br />
    <br />
    <a class="link" href="Default.aspx">Home</a><br />
    
    <br />

</asp:Content>


