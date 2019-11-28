<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoginForm.aspx.cs" Inherits="as_webforms_sklep.LoginForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 300px;
        }
        .auto-style2 {
            height: 30px;
            text-align:center
        }
        .a{
            width:1px
        }
        .b{
            width:299px
        }
        .table{
            border:1px solid gray;
            width:300px;
            margin:0 auto;
            color:gray
        }
        body{
            background:rgb(237,237,237)
        }
        .rzeczy{
            text-align:center;
            width:300px;
            margin:0 auto

        }
        .rzeczy *{
            margin:5px
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="table">
            <table align="center" class="auto-style1 ">
                <tr>
                    <td>
                        <asp:Label ID="lUsername" runat="server" Text="Login:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbUsername" runat="server" Width="240px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="lPassword" runat="server" Text="Hasło:"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="tbPassword" runat="server" TextMode="Password" Width="240px"></asp:TextBox>
                    </td>
                </tr>
            </table>
            <div class="rzeczy">
                <asp:Button ID="bLogIn" runat="server" Text="Zaloguj" OnClick="bLogIn_Click" /><br />
                <asp:Button ID="btToMainForm" runat="server" OnClick="btToMainForm_Click" Text="Strona główna" /><br />
                <asp:Button ID="bGoToRegister" runat="server" Text="Rejestracja" OnClick="bGoToRegister_Click" /><br />
                <asp:Label ID="lMsg" runat="server" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
