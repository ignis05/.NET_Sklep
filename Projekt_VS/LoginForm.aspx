<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="as_webforms_sklep.LoginForm" %>

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
    <form id="form1" runat="server">
        <div>
            <table align="left" class="auto-style1">
                <tr>
                    <td>
                        <asp:Label ID="lUsername" runat="server" Text="Login:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbUsername" runat="server"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lPassword" runat="server" Text="Hasło:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbPassword" runat="server" TextMode="Password"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        &nbsp;</td>
                    <td class="auto-style2">
                        <asp:Button ID="bLogIn" runat="server" Text="Zaloguj" OnClick="bLogIn_Click" />
                    </td>
                    <td class="auto-style2"></td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        &nbsp;</td>
                    <td class="auto-style2">
                        <asp:Label ID="lMsg" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                    <td class="auto-style2"></td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        &nbsp;</td>
                    <td class="auto-style2">
                        <asp:Button ID="bGoToRegister" runat="server" Text="Rejestracja" OnClick="bGoToRegister_Click" />
                    </td>
                    <td class="auto-style2"></td>
                </tr>
                <tr>
                    <td class="auto-style2">
                        &nbsp;</td>
                    <td class="auto-style2">
                        <asp:Button ID="btToMainForm" runat="server" OnClick="btToMainForm_Click" Text="Strona główna" />
                    </td>
                    <td class="auto-style2">&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
