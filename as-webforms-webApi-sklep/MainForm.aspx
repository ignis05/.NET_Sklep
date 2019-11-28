<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="MainForm.aspx.cs" Inherits="as_webforms_sklep.MainForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Sklep</title>
    <link href="~/assets/css/MainPage/productStyle.css" rel="stylesheet" />
    <link href="~/assets/css/MainPage/headerStyle.css" rel="stylesheet" />
    <link href="~/assets/css/MainPage/mainStyle.css" rel="stylesheet" />
    <link href="~/assets/css/MainPage/footerStyle.css" rel="stylesheet" />
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: Verdana, Geneva, Tahoma, sans-serif;
        }

        body {
            background: black;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div id="title">
                <img src="assets/img/headimglow.jpg" />
            </div>
            <div id="menu">
                <div id="menu-list-box">
                    <ul id="menu-list">
                        <li>Produkty </li>
                        <li>
                            <asp:LinkButton ID="lbToRegister" runat="server" PostBackUrl="~/RegisterForm.aspx" Visible="True">Rejestracja</asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="lbToAdmin" runat="server" PostBackUrl="~/AdminPanel.aspx" Visible="False">Panel admina</asp:LinkButton></li>
                        <li>
                            <asp:LinkButton ID="lbToLogin" runat="server" PostBackUrl="~/LoginForm.aspx">Zaloguj się</asp:LinkButton></li>
                    </ul>
                </div>
                <div id="user-status">
                    <asp:LinkButton ID="lbToBasket" CssClass="cart-bt" runat="server" PostBackUrl="~/BasketForm.aspx">Koszyk</asp:LinkButton>
                    <asp:Label ID="lLoggedIn" CssClass="logged-as" runat="server" Text="Nie jesteś zalogowany."></asp:Label>
                    <asp:Button ID="bLogout" CssClass="logout-bt" runat="server" OnClick="bLogout_Click" Text="Wyloguj" />
                </div>
            </div>
        </header>

        <main>
            <div id="categories">
                <ul>
                    <asp:ListView ID="lvCategories" runat="server">
                        <ItemTemplate>
                            <li><a href="<%# "?category=" + Eval("name") %>"> <%# Eval("name") %></a></li>
                        </ItemTemplate>
                    </asp:ListView>
                </ul>
            </div>
            <div id="products">
                <asp:Repeater ID="rProducts" runat="server" OnItemCommand="basketHandler">
                    <ItemTemplate>
                        <div class="product">
                            <div class="prod-img-box">
                                <img
                                    class="prod-img"
                                    src="<%# Eval("img_path") %>"
                                    alt="image-placeholder.jpg" />
                            </div>
                            <div class="prod-info">
                                <div class="prod-title">
                                    <%# Eval("name") %>
                                </div>
                                <div class="prod-spec-box">
                                    <div class="prod-spec">
                                        <p class="spec-title">Specyfikacja</p>
                                        <p class="spec-text">Kategoria: <%# as_webforms_sklep.DatabaseHandler.selectQuery("SELECT name FROM product_categories WHERE id LIKE '" + Eval("category").ToString() + "'").Rows[0]["name"] %></p>
                                        <p class="spec-text">Nazwa: <%# Eval("name") %></p>
                                        <p class="spec-text">
                                            Opis: <%# Eval("description") %>
                                        </p>
                                        <p class="spec-text">Dostawca: <%# Eval("supplier") %></p>
                                    </div>
                                    <div class="prod-buy-box">
                                        <div class="prod-price"><u>Cena:</u><%# Eval("price") %></div>
                                        <div class="prod-buy">
                                            <asp:TextBox ID="tbPrice" runat="server" type="hidden" value='<%# Eval("price") %>'></asp:TextBox>
                                            <asp:TextBox ID="tbAmount" CssClass="prod-but-amount" runat="server" type="number" value="1" min="1" step="1"></asp:TextBox>
                                            <asp:Button ID="bAddProduct" CssClass="prod-buy-button" CommandName="addToBasket" CommandArgument='<%# Eval("id") %>' runat="server" Text="Dodaj do koszyka" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </main>

        <footer>
            <div id="flexfooter">
                <div id="sitemap">
                    <div id="konto">
                        <p>Konto</p>
                        <asp:LinkButton ID="lbToRegister2" runat="server" PostBackUrl="~/RegisterForm.aspx" Visible="False">Rejestracja</asp:LinkButton>
                        <asp:LinkButton ID="lbToAdmin2" runat="server" PostBackUrl="~/AdminPanel.aspx" Visible="False">Panel admina</asp:LinkButton>
                        <asp:LinkButton ID="lbToLogin2" runat="server" PostBackUrl="~/LoginForm.aspx">Zaloguj się</asp:LinkButton>
                        <asp:LinkButton ID="lbToBasket2" runat="server" PostBackUrl="~/BasketForm.aspx">Koszyk</asp:LinkButton>
                    </div>
                    <div id="sklep">
                        <p>Sklep</p>
                        <asp:LinkButton ID="lbToMainPage" runat="server" PostBackUrl="~/MainForm.aspx">Strona główna</asp:LinkButton>
                        <asp:LinkButton ID="lbToContact" runat="server" PostBackUrl="~/MainForm.aspx">Kontakt</asp:LinkButton>
                    </div>
                </div>
                <div id="info">
                    <p>Kontakt</p>
                    <span>Telefon: +48 123 456 789</span>
                    <span>Mail: sklepinternetowy@sklep.pl</span>
                    <span>Adres: ul. Sklepowa 4/20, 32-137 Koszyce</span>
                </div>
            </div>
            <div id="copyright">© by papaj</div>
        </footer>
    </form>
</body>
</html>
