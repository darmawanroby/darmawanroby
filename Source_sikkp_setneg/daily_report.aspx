<%@ Page ClientTarget="uplevel" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="daily_report.aspx.cs" Inherits="rtwin.daily_report" title="Sistem Informasi Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>
<%@ Register Assembly="CrystalDecisions.Web, Version=10.2.3600.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
    <table border="0" cellpadding="0" cellspacing="0" class="border_table" width="100%">
        <tr>
            <td valign="top">
                &nbsp;&nbsp;<CR:CrystalReportViewer ID="crHarian" runat="server" AutoDataBind="True"
                    EnableParameterPrompt="False" HasCrystalLogo="False" HasRefreshButton="True"
                    ReuseParameterValuesOnRefresh="True" ShowAllPageIds="True"/>
            </td>
        </tr>
    </table>
</asp:Content>

