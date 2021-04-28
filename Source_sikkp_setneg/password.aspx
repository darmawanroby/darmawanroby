<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" Inherits="rtwin.password" CodeFile="password.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cphWithMenu" Runat="Server">
                <table style="text-align:left">
                    <tr>
                    <td class="backgroundTitle" style="width:200px">
                        <img src="images/back_title.gif" height="27px" style="vertical-align: middle" alt="" />&nbsp; <asp:Label ID="lblTitle" runat="server" CssClass="lblTitle" SkinID="lblTitle" Text="<%$ Resources:lblTitle %>"></asp:Label>
                    </td>
                    </tr>
                </table>
    <asp:ScriptManager id="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel id="UpdatePanel1" runat="server">
        <contenttemplate>
<asp:ValidationSummary id="ValidationSummary1" runat="server" CssClass="fontR" SkinID="fontR" EnableClientScript="True"></asp:ValidationSummary><asp:Label id="ExceptionDetails" runat="server" CssClass="fontR" SkinID="fontR" EnableViewState="False"></asp:Label><br /><br /><table class="border_table" cellspacing="0" cellpadding="0" width="90%" border="0"><tbody><tr><td style="WIDTH: 150px; HEIGHT: 24px" align="left"><asp:label id="lblOldPass" runat="server" Text="<%$ Resources:old %>" width="121px"></asp:label></td><td style="WIDTH: 150px; HEIGHT: 24px" align="left"><asp:textbox id="txtOldPass" tabIndex=1 runat="server" width="160px" TextMode="Password"></asp:textbox></td><td style="WIDTH: 160px; HEIGHT: 24px" align="left"><asp:RequiredFieldValidator id="RequiredFieldValidator1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:empt %>" ControlToValidate="txtOldPass" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></td></tr><tr><td style="WIDTH: 150px" align="left"><asp:label id="lblNewPassword" runat="server" Text="<%$ Resources:new %>" width="200px"></asp:label></td><td style="WIDTH: 150px" align="left"><asp:textbox id="txtNewPass" tabIndex=2 runat="server" width="160px" TextMode="Password"></asp:textbox></td><td style="WIDTH: 160px"><asp:RequiredFieldValidator id="RequiredFieldValidator2" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:empt %>" ControlToValidate="txtNewPass" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator></td></tr><tr><td style="WIDTH: 150px; HEIGHT: 13px" align="left"><asp:label id="lblNewPassword2" runat="server" Text="<%$ Resources:re-type %>" width="200px" height="13px"></asp:label></td><td style="WIDTH: 150px; HEIGHT: 13px" align="left"><asp:textbox id="txtNewPass2" tabIndex="3" runat="server" width="160px" TextMode="Password"></asp:textbox></td><td style="WIDTH: 160px; HEIGHT: 13px" align="left"><asp:RequiredFieldValidator id="RequiredFieldValidator3" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:empt %>" ControlToValidate="txtNewPass2" EnableClientScript="True" SetFocusOnError="True">*</asp:RequiredFieldValidator><asp:comparevalidator id="CompareValidator1" runat="server" CssClass="fontR" SkinID="fontR" ErrorMessage="<%$ Resources:confirm2%>" ControlToValidate="txtNewPass2" EnableClientScript="True" ControlToCompare="txtNewPass">*</asp:comparevalidator></td></tr><tr><td style="WIDTH: 150px"></td><td style="WIDTH: 150px" align="left"><br /><asp:button id="btnOK" tabIndex="4" onclick="btnOK_Click" runat="server" Text="Update"></asp:button></td><td style="WIDTH: 160px"></td></tr><tr><td style="WIDTH: 150px; HEIGHT: 13px" align="left"></td><td style="WIDTH: 150px; HEIGHT: 13px"></td><td style="WIDTH: 160px; HEIGHT: 13px"></td></tr></tbody></table>
</contenttemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress id="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1"
        DisplayAfter="100" DynamicLayout="False">
        <progresstemplate>
<asp:Panel style="Z-INDEX: 1; LEFT: 40%; POSITION: absolute; TOP: 60%" id="PNLProgress" runat="server"><table style="BORDER-RIGHT: black 1px solid; BORDER-TOP: black 1px solid; BORDER-LEFT: black 1px solid; BORDER-BOTTOM: black 1px solid; HEIGHT: 75px" id="updateProgresstable" cellspacing="0" cellpadding="0" width="200"><tr><td class="headermessage" align="center"><asp:Label id="lblmessage" runat="server" SkinID="lblMessage" Text="Please wait..."></asp:Label> </td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" align="center"><table id="table2" cellspacing="4" cellpadding="3" border="0"><tr><td style="WIDTH: 39px"><img id="imgProgress" alt="" src="images/loading.gif" runat="server" /></td></tr></table></td></tr><tr><td style="BACKGROUND-COLOR: #ffffff" valign="bottom" align="right"></td></tr></table></asp:Panel> 
</progresstemplate>
    </asp:UpdateProgress>
    <asp:Label ID="lblsukses" runat="server" Text="<%$ Resources:sukses %>" Visible="False"></asp:Label>
    <asp:Label ID="lblnotsukses" runat="server" Text="<%$ Resources:notsukses %>" Visible="False"></asp:Label>
    <asp:Label ID="lblempty" runat="server" Text="<%$ Resources:empt %>" Visible="False"></asp:Label>
    <asp:Label ID="lblread" runat="server" Text="<%$ Resources:readonly %>" Visible="False"></asp:Label>
    <asp:Label ID="lblgacocok" runat="server" Text="<%$ Resources:gacocok %>" Visible="False"></asp:Label><br />
</asp:Content>
		