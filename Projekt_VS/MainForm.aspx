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
        <asp:Repeater ID="rProducts" runat="server" OnItemCommand="rProducts_addProduct">
            <ItemTemplate>
                <div class="product_div" style="border: 2px solid black">
                    <img class="product_img" src="<%# Eval("img_path") %>" style="width: 360px; height: 360px; border: 2px solid black;" />
                    <p><%# Eval("id") %></p>
                    <p class="product_category"><%# as_webforms_sklep.DatabaseHandler.selectQuery("SELECT name FROM product_categories WHERE id LIKE '" + Eval("category").ToString() + "'").Rows[0]["name"] %></p>
                    <p class="product_name"><%# Eval("name") %></p>
                    <p class="product_description"><%# Eval("description") %></p>
                    <p class="product_price"><%# Eval("price") %></p>
                    <p class="product_supplier"><%# Eval("supplier") %></p>
                    <asp:Button ID="bAddProduct" CommandName="addToBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Dodaj do koszyka" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
