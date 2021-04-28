<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="upload_salary.aspx.cs" Inherits="upload_salary" Title="Sistem Kehadiran Kerja Pegawai Sekretariat Negara" Culture="auto:id-ID" UICulture="auto"  %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
     <table id="TABLEHEADER" width="90%">
         <tr>
            <td align="left" valign="top" >
                <table align="left">
                    <tr>
                    <td bgcolor="#00428C" height="28px" class="backgroundTitle" style="width: 250px" >
                        <img src="images/back_title.gif" height="27px" align="absmiddle">&nbsp; 
                        <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lbltitle %>" />
                    </td>
                    </tr>
                </table>
               </td>
        </tr>
                    <tr>
                        <td style="width: 209px">
  
    <asp:Label ID="lblError" runat="server" CssClass="fontR" Visible="False" SkinID="fontR"></asp:Label></td>
                    </tr>
   </table>
    <br />
    <table cellpadding="0" cellspacing="0" class="border_table" width="100%">
        <tr>
            <td style="width: 100px">
                <br />
<asp:FileUpload ID="fileuploadExcel" runat="server" /><br />
                <br />
<asp:Button ID="btnImport" runat="server" Text="<%$ Resources:lblImport %>" OnClick="btnImport_Click" /></td>
        </tr>
    </table>
    <br />
    <table cellpadding="0" cellspacing="0" class="border_table" width="100%">
        <tr>
            <td style="width: 200px; height: 199px;">
<asp:GridView ID="grvExcelData" runat="server">
</asp:GridView>
                &nbsp;
                <br />
    <asp:Button ID="btnSave" runat="server" CausesValidation="False" Text="<%$ Resources:lblSave %>"
        Visible="False" OnClick="btnSave_Click" /><br />
                </td>
        </tr>
    </table>
    <br />
    <asp:Label ID="Label2" runat="server" Text="<%$ Resources:lblFailure %>" Visible="False" />
    <asp:Label ID="Label1" runat="server" Text="<%$ Resources:lblFileNull %>" Visible="False" />
    <asp:Label ID="Label3" runat="server" Text="<%$ Resources:lblSalahTipe %>" Visible="False" /><br />
</asp:Content>

