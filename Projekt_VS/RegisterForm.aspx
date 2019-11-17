<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterForm.aspx.cs" Inherits="as_webforms_sklep.RegisterForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            height: 30px;
        }
    </style>
</head>
<body>
    <script type="text/javascript">
        function ValidatePW(source, arguments) {
            arguments.IsValid = arguments.Value.length >= 8
        }
    </script>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td class="auto-style2">Login:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbUsername" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="tbUsername" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                    <td class="auto-style2"></td>
                    <td class="auto-style2"></td>
                </tr>
                <tr>
                    <td class="auto-style2">Hasło:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="tbPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:CustomValidator ID="PasswordValidator" runat="server" ControlToValidate="tbPassword" ErrorMessage="Hasło musi mieć co najmniej 8 znaków." ForeColor="Red" ClientValidationFunction="ValidatePW"></asp:CustomValidator>
                    </td>
                    <td class="auto-style2"></td>
                    <td class="auto-style2"></td>
                </tr>
                <tr>
                    <td>Powtórz hasło:</td>
                    <td>
                        <asp:TextBox ID="tbPasswordRepeat" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRepeatPassword" runat="server" ControlToValidate="tbPasswordRepeat" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="RepeatPasswordValidator" runat="server" ControlToCompare="tbPassword" ControlToValidate="tbPasswordRepeat" ErrorMessage="Hasła muszą być takie same." ForeColor="Red"></asp:CompareValidator>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">Adres email:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbEmail" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbEmail" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="EmailValidator" runat="server" ControlToValidate="tbEmail" ErrorMessage="Wpisz poprawny adres email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                    </td>
                    <td class="auto-style2"></td>
                    <td class="auto-style2"></td>
                </tr>
                <tr>
                    <td>Imię:</td>
                    <td>
                        <asp:TextBox ID="tbFirstName" runat="server"></asp:TextBox>
                    </td>
                    <td>Nazwisko:</td>
                    <td>
                        <asp:TextBox ID="tbLastName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>Adres rozliczeniowy:</td>
                    <td>
                        <asp:TextBox ID="tbAddress" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="bRegister" runat="server" Text="Zarejestruj się" OnClick="bRegister_Click" />
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="* Pola wymagane"></asp:Label>
                        <br />
                        <asp:Label ID="lMsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>
                        <asp:Button ID="bGotToLogIn" runat="server" Text="Logowanie" CausesValidation="False" OnClick="bGotToLogIn_Click" UseSubmitBehavior="False" />
                    </td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
