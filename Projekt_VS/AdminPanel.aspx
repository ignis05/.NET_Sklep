<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="as_webforms_sklep.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="MainForm.aspx">Powrót do Main.</asp:LinkButton>
        <br />
        <asp:Label ID="lTest" runat="server" ForeColor="Red"></asp:Label>
        <asp:GridView ID="gvUsers" runat="server">
        </asp:GridView>
        <asp:GridView ID="gvProducts" runat="server">
        </asp:GridView>
        <asp:GridView ID="gvOrders" runat="server">
        </asp:GridView>
    </form>
</body>
</html>
