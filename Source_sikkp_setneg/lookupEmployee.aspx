<%@ Page Language="C#" AutoEventWireup="true" CodeFile="lookupEmployee.aspx.cs" Inherits="rtwin.lookupEmployee" UICulture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Daftar Pegawai</title>
    <link href="Rekabio.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="label1" runat="server" Text="Cari Nama:"></asp:Label>
        <asp:TextBox ID="TextBox1" runat="server" AutoPostBack="True"></asp:TextBox>&nbsp;
        <input id="btnOke" class="lblStandar" style="width: 34px; height: 19px" type="button"
            value="Cari" runat="server" />
        <br />
        <br />
        <asp:GridView ID="GvPegawai" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="NIP" 
EmptyDataText="There are no data records to display." 
GridLines="None" AllowSorting="False" CssClass="GridView">
            <FooterStyle Font-Bold="True" ForeColor="White" />
            <Columns>
                <asp:BoundField DataField="NIP" HeaderText="NIP" ReadOnly="True" SortExpression="NIP" />
                <asp:BoundField DataField="PIN" HeaderText="PIN" SortExpression="PIN" />
                <asp:BoundField DataField="NAMA" HeaderText="NAMA" SortExpression="NAMA" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HyperLink id="hlReturnLookupValue" runat="server">Pilih</asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <RowStyle CssClass="Item" />
            <SelectedRowStyle CssClass="Selected" />
            <PagerStyle CssClass="PagerStryle" />
            <HeaderStyle CssClass="HeaderStyle" />
            <AlternatingRowStyle CssClass="Alternate" />
        </asp:GridView>
    </div>
    </form>
</body>
</html>