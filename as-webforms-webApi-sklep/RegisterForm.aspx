<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RegisterForm.aspx.cs" Inherits="as_webforms_sklep.RegisterForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        td {
            height: 30px;
        }
        #bbb{
            width:300px;
            margin:0 auto;
            
        }
        .tablica{
            width:500px;
            margin:20px auto;
            color:gray;
            border:2px solid gray;
        }
        .auto-style2{
            width:200px;
            text-align:center;
            border:1px solid gray
        }
        .auto-style3 {
            margin-bottom: 0px;
        }
        body{
            background:rgb(237,237,237)
        }
        .warning{
            width:400px;
            height:70px;
            margin:20px auto;
            text-align:center
        }
    </style>
    <title>Rejestracja</title>
</head>
<body>
    <script type="text/javascript">
        function ValidatePW(source, arguments) {
            arguments.IsValid = arguments.Value.length >= 8
        }
    </script>
    <div class="bbb">
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1 tablica">
                <tr>
                    <td class="auto-style2 aaa1">Login:</td>
                    <td class="auto-style2 aaa2">
                        <asp:TextBox ID="tbUsername" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="tbUsername" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2 aaa1">Hasło:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" CssClass="auto-style3"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="tbPassword" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2 aaa1">Powtórz hasło:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbPasswordRepeat" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvRepeatPassword" runat="server" ControlToValidate="tbPasswordRepeat" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2 aaa1">Adres email:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbEmail" runat="server" TextMode="Email"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbEmail" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td class="aaa1 auto-style2">Imię:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbFirstName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="aaa1 auto-style2">Nazwisko:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbLastName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="aaa1 auto-style2">Adres rozliczeniowy:</td>
                    <td class="auto-style2">
                        <asp:TextBox ID="tbAddress" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td class="aaa3 auto-style2">
                        <asp:Button ID="bRegister" runat="server" Text="Zarejestruj się" OnClick="bRegister_Click" />
                    </td>
                    <td class="aaa3 auto-style2">
                        <asp:Button ID="bGotToLogIn" runat="server" Text="Logowanie" CausesValidation="False" OnClick="bGotToLogIn_Click" UseSubmitBehavior="False" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="* Pola wymagane"></asp:Label>
                        <br />
                        <asp:Label ID="lMsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                    <td class="auto-style2">
                        <asp:Button ID="btToMainForm" runat="server" OnClick="btToMainForm_Click" Text="Strona główna" />
                    </td>
                </tr>
            </table>
            <div class="warning">
                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="tbEmail" ErrorMessage="Wpisz poprawny adres email." ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator><br/>
                <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="tbPassword" ControlToValidate="tbPasswordRepeat" ErrorMessage="Hasła muszą być takie same." ForeColor="Red"></asp:CompareValidator><br/>
                <asp:CustomValidator ID="CustomValidator1" runat="server" ControlToValidate="tbPassword" ErrorMessage="Hasło musi mieć co najmniej 8 znaków." ForeColor="Red" ClientValidationFunction="ValidatePW"></asp:CustomValidator>
            </div>
        </div>
    </form>
        </div>
</body>
</html>
