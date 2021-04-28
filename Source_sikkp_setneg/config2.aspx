<%@ Page MasterPageFile ="~/MasterPage.master" Language="C#" AutoEventWireup="true" Inherits="rtwin.config2" CodeFile="config2.aspx.cs" title="Sistem Kehadiran Kerja Pegawai Kementerian Sekretariat Negara Republik Indonesia" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    
<asp:Content ID="Content2" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                        <td class="backgroundTitle" style="width: 200px">
                            <img style="vertical-align: middle" height="27" src="images/back_title.gif" alt="" />&nbsp;
                            <asp:Label ID="LblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                        </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><BR /><BR /><asp:FormView id="FvVariable" runat="server" DataSourceID="dsVariable" DefaultMode="Edit"><EditItemTemplate>
<TABLE width=600><TBODY><TR><TD style="WIDTH: 200px"><asp:Label id="lblTglLaporan" runat="server" Text="<%$ Resources:lblTglLaporan %>"></asp:Label></TD><TD style="WIDTH: 400px"><asp:TextBox id="txtTglLaporan" runat="server" Text='<%# Bind("TGL_LAPORAN") %>' MaxLength="2" Columns="2"></asp:TextBox> <asp:RangeValidator id="RangeValidator1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:lblRange %>" ControlToValidate="txtTglLaporan" EnableClientScript="True" Type="Integer" SetFocusOnError="True" MinimumValue="1" MaximumValue="31">*</asp:RangeValidator> <cc1:MaskedEditExtender id="mexTglLaporan" runat="server" TargetControlID="txtTglLaporan" MaskType="Number" Mask="99" AutoComplete="False"></cc1:MaskedEditExtender></TD></TR></TBODY></TABLE><BR /><asp:button id="btnOK" tabIndex=4 runat="server" Text="<%$ Resources:tblUpdate %>" CommandName="Update"></asp:button> 
</EditItemTemplate>
</asp:FormView> <asp:SqlDataSource id="dsVariable" runat="server" OnUpdating="dsVariable_Updating" ConnectionString="<%$ ConnectionStrings:strCn %>" SelectCommand="SELECT TGL_LAPORAN FROM taVariabel" UpdateCommand="UPDATE taVariabel SET TGL_LAPORAN = @TGL_LAPORAN" OnUpdated="dsVariable_Updated"><UpdateParameters>
<asp:Parameter Name="TGL_LAPORAN"></asp:Parameter>
</UpdateParameters>
</asp:SqlDataSource>
            &nbsp;
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgressTable" cellspacing="0" cellpadding="0" width="200"><tbody><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tbody><tr><td style="WIDTH: 39px"><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></tbody></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign="bottom" align="right"></td></tr></tbody></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:Label ID="lblRange" runat="server" Text="<%$ Resources:lblRange %>"
        Visible="False"></asp:Label><br />
    <asp:Label ID="lblConfigUpdated" runat="server" Text="<%$ Resources:lblConfigUpdated %>" Visible="False"></asp:Label><asp:Label ID="lblConfigNotUpdated" runat="server" Text="<%$ Resources:lblConfigNotUpdated %>" Visible="False"></asp:Label><br />
</asp:Content>
			