<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="BasketForm.aspx.cs" Inherits="as_webforms_sklep.BasketForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td>
                        <asp:Label ID="lTotalPrice" runat="server" Text="Cena wszystkich przedmiotów w koszyku to:"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:LinkButton ID="lbToMain" runat="server" PostBackUrl="~/MainForm.aspx">Wróć do sklepu</asp:LinkButton>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
        <asp:Repeater ID="rBasket" runat="server" OnItemCommand="basketHandler">
            <ItemTemplate>
                <div style="border: 2px solid black">
                    <img class="product_img" src="<%# Eval("img_path") %>" style="width: 360px; height: 360px; border: 2px solid black;" />
                    <p><%# Eval("id") %></p>
                    <p class="product_category"><%# as_webforms_sklep.DatabaseHandler.selectQuery("SELECT name FROM product_categories WHERE id LIKE '" + Eval("category").ToString() + "'").Rows[0]["name"] %></p>
                    <p class="product_name"><%# Eval("name") %></p>
                    <p class="product_description"><%# Eval("description") %></p>
                    <p class="product_price"><%# Eval("price") %></p>
                    <p class="product_supplier"><%# Eval("supplier") %></p>
                    <asp:TextBox ID="tbAmount" runat="server" type="number" value='<%# Eval("amount") %>' min="1" step="1"></asp:TextBox>
                    <br />
                    <asp:Button ID="bChangeProduct" CommandName="changeInBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Zmień ilość" />
                    <asp:Button ID="bRemoveProduct" CommandName="removeFromBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Usuń z koszyka" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <asp:Button ID="bOrder" runat="server" OnClick="bOrder_Click" Text="Złóż zamówienie" />
    </form>
</body>
</html>
