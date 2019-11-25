<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterForm.aspx.cs" Inherits="as_webforms_sklep.RegisterForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rejestracja</title>
    <link href="~/assets/css/RegisterPage/registerPage.css" rel="stylesheet" />
</head>
<body>
    <script type="text/javascript">
        function ValidatePW(source, arguments) {
            arguments.IsValid = arguments.Value.length >= 8
        }
    </script>
    <form id="form1" runat="server">
        <div class="container">
            <div class="site">
                <div class="login-form">
                    <div class="form-line">
                        <div class="text-container">
                            <div>Login:</div>
                            <div class="warning-container">
                                <asp:TextBox ID="tbUsername" runat="server" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="tbUsername" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>
                    <div class="form-line">
                        <div class="text-container">
                            <div>Hasło:</div>
                            <div class="warning-container">
                                <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="tbPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <asp:CustomValidator ID="PasswordValidator" runat="server" ControlToValidate="tbPassword" ErrorMessage="Hasło musi mieć co najmniej 8 znaków." ForeColor="Red" ClientValidationFunction="ValidatePW" Display="Dynamic"></asp:CustomValidator>
                    </div>
                    <div class="form-line">
                        <div class="text-container">
                            <div>Powtórz hasło:</div>
                            <div class="warning-container">
                                <asp:TextBox ID="tbPasswordRepeat" runat="server" TextMode="Password" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvRepeatPassword" runat="server" ControlToValidate="tbPasswordRepeat" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <asp:CompareValidator ID="RepeatPasswordValidator" runat="server" ControlToCompare="tbPassword" ControlToValidate="tbPasswordRepeat" ErrorMessage="Hasła muszą być takie same." ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
                    </div>
                    <div class="form-line">
                        <div class="text-container">
                            <div>Adres e-mail:</div>
                            <div class="warning-container">
                                <asp:TextBox ID="tbEmail" runat="server" TextMode="Email" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbEmail" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="tbEmail" ErrorMessage="Wpisz poprawny adres email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" Display="Dynamic"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-line">
                        
                        <div class="text-container">
                            <div>Imię:</div>
                        <asp:TextBox ID="tbFirstName" runat="server" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                            </div>
                    </div>
                    <div class="form-line">
                        
                        <div class="text-container">
                            <div>Nazwisko:</div>
                        <asp:TextBox ID="tbLastName" runat="server" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                            </div>
                    </div>
                    <div class="form-line">
                        
                        <div class="text-container">
                            <div>Adres:</div>
                        <asp:TextBox ID="tbAddress" runat="server" BackColor="#666666" BorderColor="#333333" ForeColor="White"></asp:TextBox>
                            </div>
                    </div>
                    <div class="form-line-tall">
                        <div class="small-container"><asp:Button ID="bRegister" runat="server" Text="Zarejestruj się" OnClick="bRegister_Click" BackColor="#666666" BorderColor="#333333" BorderStyle="Ridge" ForeColor="White" /></div>
                        <div class="small-container"><asp:Button ID="bGotToLogIn" runat="server" Text="Logowanie" CausesValidation="False" OnClick="bGotToLogIn_Click" UseSubmitBehavior="False" BackColor="#666666" BorderColor="#333333" BorderStyle="Ridge" ForeColor="White" /></div>
                        <div class="small-container"><asp:Label ID="Label1" runat="server" ForeColor="Red" Text="* Pola wymagane"></asp:Label></div>
                        <div class="small-container"><asp:Label ID="lMsg" runat="server" ForeColor="Red"></asp:Label></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
