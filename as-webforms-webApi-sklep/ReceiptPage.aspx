<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReceiptPage.aspx.cs" Inherits="as_webforms_webApi_sklep.ReceiptPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #form1{
            text-align:center;
            color:gray;
            align-items:center;
            font-size:30px;
            
        }
        #aaa{
            text-decoration:none;
            width:400px;
            display:block;
            height:100px;
            color:gray;
            margin:20px auto;
            line-height:100px;
            font-size:35px;
            border:2px solid gray;
        }
        body{
            background:rgb(237,237,237)
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Wykonano zamówienie. Dziękujemy za skorzystanie z naszych usług.<br />
            <a href="MainForm.aspx" id="aaa">Powrót do strony głównej</a>
        </div>
    </form>
</body>
</html>
