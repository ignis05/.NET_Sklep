<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="BasketForm.aspx.cs" Inherits="as_webforms_sklep.BasketForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        #window{
            text-align:center;
            width:360px;
            float:left;
            margin:0 auto;
            align-items:center
        }
        #form1{
            text-align:center;
        }
        #bOrder{
            clear:both
        }
        body{
            color:gray;
            background:rgb(237,237,237)
        }
        #lbToMain{
            text-decoration:none;
            color:gray
        }
        #rBasket{
            align-items:center
        }
        p{
            margin:1px 0 1px 0
        }
        .button{
            margin:3px;
            background:	rgb(235, 230, 230);
            padding:4px;
        }
        td{
            font-size:30px
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
                <tr>
                    <td>
                        <asp:Button ID="bOrder" runat="server" OnClick="bOrder_Click" Text="Złóż zamówienie" />
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
        <asp:Repeater ID="rBasket" runat="server" OnItemCommand="basketHandler">
            <ItemTemplate>
                <div style="border: 2px solid gray" id="window">
                    <img class="product_img" src="<%# Eval("img_path") %>" style="width: 360px; height: 360px; border-bottom: 2px solid gray;" />
                    <p class="product_category"><b>Kategoria: </b> <%# as_webforms_sklep.DatabaseHandler.selectQuery("SELECT name FROM product_categories WHERE id LIKE '" + Eval("category").ToString() + "'").Rows[0]["name"] %></p>
                    <p class="product_name"><b>Nazwa: </b><%# Eval("name") %></p>
                    <p class="product_description"><b>Opis: </b><%# Eval("description") %></p>
                    <p class="product_price"><b>Cena: </b><%# Eval("price") %></p>
                    <p class="product_supplier"><b>Dostawca: </b><%# Eval("supplier") %></p>
                    <asp:TextBox ID="tbAmount" runat="server" type="number" value='<%# Eval("amount") %>' min="1" step="1"></asp:TextBox>
                    <br />
                    <asp:Button ID="bChangeProduct" CssClass="button" CommandName="changeInBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Zmień ilość" />
                    <asp:Button ID="bRemoveProduct" CssClass="button" CommandName="removeFromBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Usuń z koszyka" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
        Email:
                                <asp:TextBox ID="tbEmail" runat="server" TextMode="Email" BackColor="#666666" BorderColor="#333333" ForeColor="White" Enabled="False"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbEmail" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="tbEmail" ErrorMessage="Wpisz poprawny adres email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                    <br />
        
    </form>
</body>
</html>
