<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="alert.aspx.cs" Inherits="rtwin.alert"  title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td align="left" valign="top">
                <table style="text-align:left">
                    <tr>
                        <td class="backgroundTitle" style="width: 200px">
                            <img style="vertical-align: middle" height="27" src="images/back_title.gif" alt="" />&nbsp;
                            <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="Data Status"></asp:Label>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td align="left" style="width: 100%; height: 13px">
            </td>
        </tr>
    </table>
    <table border="0" cellpadding="0" cellspacing="0" class="border_table" width="100%">
	    <tr>
	        <td style="width: 100%">
		        <br />
                <asp:Label ID="lblAlert" runat="server" Font-Bold="False" Text="Alert"></asp:Label>
                <br />
            </td>
        </tr>
    </table><br />
    <a class="link" href="Default.aspx">Home</a><br />
</asp:Content>

