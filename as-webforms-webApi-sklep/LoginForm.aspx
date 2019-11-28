<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="as_webforms_sklep.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Logowanie</title>
    <link href="~/assets/css/RegisterPage/registerPage.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="site">
                <div class="login-form">
                    <div class="form-line">
                        <div class="text-container">
                            <div>Login:</div>
                            <div class="warning-container">
                                <asp:TextBox ID="tbUsername" runat="server" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-line">
                        <div class="text-container">
                            <div>Hasło:</div>
                            <div class="warning-container">
                                <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                    <div class="form-line-tall">
                        <div class="small-container"><asp:Button ID="bLogIn" runat="server" Text="Zaloguj" OnClick="bLogIn_Click" BackColor="#666666" BorderColor="#333333" BorderStyle="Ridge" ForeColor="White"/></div>
                        <div class="small-container"><asp:Button ID="bGoToRegister" runat="server" Text="Rejestracja" OnClick="bGoToRegister_Click" BackColor="#666666" BorderColor="#333333" BorderStyle="Ridge" ForeColor="White"/></div>
                        <div class="small-container"><asp:Button ID="btToMainForm" runat="server" OnClick="btToMainForm_Click" Text="Strona główna" BackColor="#666666" BorderColor="#333333" BorderStyle="Ridge" ForeColor="White"/></div>
                        <div class="small-container"><asp:Label ID="lMsg" runat="server" ForeColor="Red"></asp:Label></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
