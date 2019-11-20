<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MainForm.aspx.cs" Inherits="as_webforms_sklep.MainForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }

        .auto-style2 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <table align="center" class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="lLoggedIn" runat="server" Text="Nie jesteś zalogowany."></asp:Label>
                        &nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Button ID="bLogout" runat="server" OnClick="bLogout_Click" Text="Wyloguj" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="lbToAdmin" runat="server" PostBackUrl="AdminPanel.aspx" Visible="False">Do panelu admina.</asp:LinkButton>
                        <asp:LinkButton ID="lbToLogin" runat="server" PostBackUrl="~/LoginForm.aspx">Zaloguj się</asp:LinkButton>
                    </td>
                </tr>
            </table>

        </div>
        <asp:Repeater ID="rProducts" runat="server" OnItemCommand="basketHandler">
            <ItemTemplate>
                <div style="border: 2px solid black">
                    <p><%# Eval("id") %></p>
                    <p><%# Eval("name") %></p>
                    <p><%# Eval("description") %></p>
                    <p><%# Eval("price") %></p>
                    <p><%# Eval("supplier") %></p>
                    <asp:TextBox ID="tbAmount" runat="server" type="number" value="1" min="1" step="1"></asp:TextBox>
                    <br />
                    <asp:Button ID="bAddProduct" CommandName="addToBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Dodaj do koszyka" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
