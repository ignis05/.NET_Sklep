<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BasketForm.aspx.cs" Inherits="as_webforms_sklep.BasketForm" %>

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
                    <p><%# Eval("productId") %></p>
                    <asp:TextBox ID="tbAmount" runat="server" type="number" value='<%# Eval("amount") %>' min="1" step="1"></asp:TextBox>
                    <br />
                    <asp:Button ID="bChangeProduct" CommandName="changeInBasket" CommandArgument='<%# Eval("productId") %>' runat="server" Text="Zmień ilość" />
                    <asp:Button ID="bRemoveProduct" CommandName="removeFromBasket" CommandArgument='<%# Eval("productId") %>' runat="server" Text="Usuń koszyka" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </form>
</body>
</html>
