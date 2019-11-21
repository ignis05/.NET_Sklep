<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="as_webforms_sklep.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="MainForm.aspx">Powrót do Main.</asp:LinkButton>
        <br />
        <asp:Label ID="lTest" runat="server" ForeColor="Red"></asp:Label>
        <asp:GridView ID="gvUsers" AutoGenerateColumns="false" runat="server" OnRowCommand="gvUsers_RowCommand" DataKeyNames="id">
            <Columns>
            <asp:BoundField DataField="id" HeaderText="ID"/>
            <asp:BoundField DataField="username" HeaderText="Username"/>
            <asp:BoundField DataField="access_level" HeaderText="Access Level"/>
            <asp:TemplateField HeaderText="Delete">
                <ItemTemplate>
                    <asp:LinkButton ID="btDeleteUser" Text='<%# Convert.ToInt32(Eval("id")) == 0 ? "" : "Delete" %>' runat="server" CommandName="DeleteUser" AllowPaging="True" CommandArgument='<%# Eval("id") %>'/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Update">
                <ItemTemplate>
                    <asp:LinkButton ID="btUpdateUser" runat="server" Text='<%# ProcessAccessLevel(Eval("access_level")) %>'  CommandName="UpdateUser" AllowPaging="True" CommandArgument='<%#Eval("id")+","+ Eval("access_level")%>'/>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        </asp:GridView>
        <asp:GridView ID="gvProducts" runat="server">
        </asp:GridView>
        <asp:GridView ID="gvOrders" AutoGenerateColumns="false" runat="server" OnRowCommand="gvOrders_RowCommand" DataKeyNames="id" OnRowDataBound="Orders_RowDataBound">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="ID"/>
                <asp:BoundField DataField="user" HeaderText="User"/>
                <asp:BoundField DataField="date" HeaderText="Date"/>
                <asp:TemplateField HeaderText="State">
                    <ItemTemplate>
                        <asp:DropDownList ID="orderStateList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="updateOrderState"> </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:HiddenField ID="hiddenID" runat="server" Value='<%# Eval("id") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
           </Columns>
        </asp:GridView>
    </form>
</body>
</html>
