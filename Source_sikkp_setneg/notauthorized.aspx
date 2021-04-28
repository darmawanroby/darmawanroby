<%@ Page MasterPageFile="~/MasterPage.master" Inherits="rtwin.notauthorized" Language="C#" CodeFile="notauthorized.aspx.cs" AutoEventWireup="false" Title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" UICulture="auto"%>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="center" valign="middle" style="height: 100px" >
                <asp:Label id="lblMessage" runat="server" Font-Size="Larger" Font-Bold="True" forecolor="Red" Text="<%$ Resources:not %>" ></asp:Label>
                <asp:Label id="lblTemp" runat="server" Text=" " ></asp:Label>
            </td>
        </tr>
    </table>
    
</asp:Content>
			