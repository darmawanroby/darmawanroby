<%@ Page ClientTarget="uplevel" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="allowance_report.aspx.cs" Inherits="rtwin.detail_report" title="Sistem Kehadiran Kerja Pegawai" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" class="border_table" width="100%">
        <tr>
            <td valign="top">
                &nbsp;&nbsp;<CR:CrystalReportViewer ID="crPeriode" runat="server" AutoDataBind="True"
                    EnableParameterPrompt="False" HasCrystalLogo="False" HasRefreshButton="True"
                    height="1106px" ReuseParameterValuesOnRefresh="True" ShowAllPageIds="True" width="876px" DisplayGroupTree="False" />
                <br />
    <asp:Label ID="lblMessage" runat="server" CssClass="fontR" SkinID="fontR"></asp:Label><br />
                &nbsp;</td>
        </tr>
    </table>
</asp:Content>

