<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeBehind="MainForm.aspx.cs" Inherits="as_webforms_sklep.MainForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <title>Sklep</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            font-family: Tahoma, sans-serif;
        }

        body {
            background: rgb(237,237,237);
        }
        footer {
            margin-top: 5px;
            border-top: 2px solid #888;
            color: gray;
            height: 150px;
            background: rgb(237,237,237);
            min-width: 1350px;
            text-align:center;
        }

        #flexfooter {
            display: flex;
        }

        #sitemap {
            flex: 2;
            display: flex;
        }

        #sitemap div {
            margin: 14px;
        }

        #sitemap p {
            font-size: 125%;
            text-decoration: underline;
        }

        #sitemap a {
            text-decoration: none;
            color: gray;
            display: block;
        }

        #info {
            flex: 1;
        }

        #info p {
            font-size: 125%;
            text-decoration: underline;
        }

        #info span {
            display: block;
        }

        #copyright {
            text-align: center;
        }
        main {
            min-width: 1350px;
            display: flex;
            color: gray;
        }
        #categories {
            width: 15%;
            margin-right: 5px;
            border: 2px solid #888;
        }

        #products {
            width: 100%;
            display: flex;
            align-content: center;
            justify-content: center;
            flex-direction: column;
        }

        #list-cats li {
            display: block;
            padding: 10px;
            border-bottom: 1px solid #888;
            border-collapse: collapse;
            text-align:center;
            height:50px;
            line-height:50px;
            font-size:30px
        }
        header {
            color: gray;
            min-width: 1350px;
            background: rgb(237,237,237);
            display: flex;
            flex-direction: column;
            margin-bottom: 5px;
            border-bottom: 2px solid #888;
            border-top: 2px solid #888;
        }

        #title img {
            width: 100%;
            height:100%
        }

        #menu {
            padding: 5px 2px;
            height: 30px;
            display: flex;
            justify-content: space-between;
            border-top: 2px solid #888;
            border-left: 2px solid #888;
            border-right: 2px solid #888;
        }

        #menu-list {
            width: 40%;
            min-width: 650px;
        }

        #menu-list li {
            display: inline-block;
        }

        #menu-list li a {
            text-decoration: none;
            color: gray;
        }

        #user-status {
            display: flex;
            justify-content: flex-end;
            width: 40%;
            min-width: 650px;
        }

        #user-status a {
            flex:1;
            text-decoration: none;
            color: gray;
        }

        .cart-bt {
            width: auto;
            padding-right: 10px;
        }

        .logged-as {
            flex: 1;
        }

        .logout-bt {
            flex: 1;
        }

        #list-cats-box {
            display: none;
        }



        .product {
            border: 2px solid #888;
            color: gray;
            display: flex;
            width: 100%;
            min-width: 925px;
            height: 25vh;
            text-align:center
        }

        .prod-img-box {
            height: 100%;
            display: flex;
            justify-content: center;
            align-content: center;
            align-items: center;
            flex: 1;
        }

        .prod-img {
            width: 100%;
            height: 100%;
        }

        .prod-info {
            flex: 3;
            min-width: 525px;
            background: white;
            display: flex;
            flex-direction: column;
        }

        .prod-title {
            margin: 5px;
            font-size: x-large;
            font-weight: bold;
            flex: 1;
            text-align: center;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .prod-spec-box {
            flex: 7;
            display: flex;
            justify-content: stretch;
        }

        .prod-spec {
            margin-left: 5px;
            width: 50%;
        }
        .spec-titleprawdziwe {
            font-size: 170%;
            text-decoration: underline;
        }
        .spec-title {
            font-size: 110%;
        }

        .spec-text {
            padding-top: 10px;
        }

        .prod-buy-box {
            display: flex;
            flex-direction: column;
            width: 50%
        }

        .prod-price {
            padding-left: 10px;
            padding-bottom: 10px;
        }

        .prod-price u {
            font-size: 150%;
        }

        .prod-buy {
        }

        .prod-buy button {
            width: 100%;
            height: 100%;
        }
        #bLogout{
            width:80px;
            height:30px;
            color:gray;
            margin-right:20px
        }
        #title{
            height:275px
        }
        #sitemap{
            display:none
        }
        .tencos{
            margin-left:20px
        }
        #KatFilter{
            margin-left:20px;
            background-color:rgb(237,237,237);
            height:25px;
            color:gray;
            margin-top:3px
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <div id="title">
                <img src="assets/img/headerimg4.png" />
            </div>
            <div id="menu">
                <div id="menu-list-box">
                    <ul id="menu-list">
                        <li class="tencos">
                            <asp:LinkButton ID="lbToRegister" runat="server" PostBackUrl="~/RegisterForm.aspx" Visible="True">Rejestracja</asp:LinkButton></li>
                        <li >
                            <asp:LinkButton ID="lbToAdmin" runat="server" PostBackUrl="~/AdminPanel.aspx" Visible="False">Panel admina</asp:LinkButton></li>
                        <li class="tencos">
                            <asp:LinkButton ID="lbToLogin" runat="server" PostBackUrl="~/LoginForm.aspx">Zaloguj się</asp:LinkButton>
                        </li>
                        <li>
                            <asp:DropDownList ID="KatFilter" runat="server" AutoPostBack="true" OnSelectedIndexChanged="filterKat"></asp:DropDownList>
                        </li>
                    </ul>
                </div>
                <div id="user-status">
                    <asp:LinkButton ID="lbToBasket" CssClass="cart-bt" runat="server" PostBackUrl="~/BasketForm.aspx">Koszyk</asp:LinkButton>
                    <asp:Label ID="lLoggedIn" CssClass="logged-as" runat="server" Text="Nie jesteś zalogowany."></asp:Label>
                    <asp:Button ID="bLogout"  runat="server" OnClick="bLogout_Click" Text="Wyloguj" />
                </div>
            </div>
        </header>

        <main>
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
                                <div class="prod-spec-box">
                                    <div class="prod-spec">
                                        <p class="spec-titleprawdziwe"> <%# Eval("name") %></p>
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
                                            <asp:TextBox ID="tbAmount" CssClass="prod-but-amount" runat="server" type="number" value="1" min="1" step="1"></asp:TextBox><br />
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
                        <asp:LinkButton ID="lbToRegister2" runat="server" PostBackUrl="~/RegisterForm.aspx" Visible="False">Rejestracja</asp:LinkButton>
                        <asp:LinkButton ID="lbToAdmin2" runat="server" PostBackUrl="~/AdminPanel.aspx" Visible="False">Panel admina</asp:LinkButton>
                        <asp:LinkButton ID="lbToLogin2" runat="server" PostBackUrl="~/LoginForm.aspx">Zaloguj się</asp:LinkButton>
                        <asp:LinkButton ID="lbToBasket2" runat="server" PostBackUrl="~/BasketForm.aspx">Koszyk</asp:LinkButton>
                    </div>
                </div>
                <div id="info">
                    <p>Kontakt</p>
                    <span>Telefon: +48 987123546</span>
                    <span>Mail: aaa@aaa.aa</span>
                    <span>Adres: ul. Celna 5/5, 55-555 Wadowice</span>
                    <span>© by aaaaaa</span>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>
