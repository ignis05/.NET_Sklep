<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="as_webforms_sklep.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Panel Administracyjny</title>
        <style>
            #form1 *{
                text-align:center;
                margin:0 auto;
                color:gray
            }
            #LinkButton1{
                display:block;
                text-decoration:none;
                color:gray;
                font-size:30px;
                margin-bottom:40px
            }
            body{
                background:rgb(237,237,237)
            }
            #gvUsers, #gvProducts, #gvNewProduct, #gvOrders{
                margin-bottom:40px
            }
        </style>
	</head>
	<body>
		<form id="form1" runat="server">
			<asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="MainForm.aspx">Powrót do Main.</asp:LinkButton>
			<asp:Label ID="lTest" runat="server" ForeColor="Red"></asp:Label>
            <h1>Zarządzanie użytkownikami</h1>
				<asp:GridView ID="gvUsers" AutoGenerateColumns="false" runat="server" OnRowCommand="gvUsers_RowCommand" DataKeyNames="id">
											<Columns>
												<asp:BoundField DataField="id" HeaderText="ID" />
												<asp:BoundField DataField="username" HeaderText="Username" />
												<asp:BoundField DataField="access_level" HeaderText="Access Level" />
												<asp:TemplateField HeaderText="Delete">
													<ItemTemplate>
														<asp:LinkButton
															ID="btDeleteUser"
															Text='<%# Convert.ToInt32(Eval("id")) == 0 ? "" : "Delete" %>'
															runat="server"
															CommandName="DeleteUser"
															AllowPaging="True"
															CommandArgument='<%# Eval("id") %>'
														/>
													</ItemTemplate>
												</asp:TemplateField>
												<asp:TemplateField HeaderText="Update">
													<ItemTemplate>
														<asp:LinkButton
															ID="btUpdateUser"
															runat="server"
															Text='<%# ProcessAccessLevel(Eval("access_level")) %>'
															CommandName="UpdateUser"
															AllowPaging="True"
															CommandArgument='<%#Eval("id")+","+ Eval("access_level")%>'
														/>
													</ItemTemplate>
												</asp:TemplateField>
											</Columns>
										</asp:GridView>
                            <h1>Zarządzanie produktami</h1>
									<asp:GridView
										ID="gvProducts"
										runat="server"
										AutoGenerateColumns="false"
										OnRowCommand="gvProducts_RowCommand"
										DataKeyNames="id"
										OnRowDataBound="Products_RowDataBound">
										<Columns>
											<asp:BoundField DataField="id" HeaderText="ID" />
											<asp:TemplateField HeaderText="Category">
												<ItemTemplate>
													<asp:DropDownList ID="productsCatList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="updateProductCat"> </asp:DropDownList>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Name">
												<ItemTemplate>
													<asp:TextBox runat="server" ID="tbProductName" Text='<%#Eval("name") %>' AutoPostBack="true" OnTextChanged="tbProduct_Update"></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Description">
												<ItemTemplate>
													<asp:TextBox
														runat="server"
														ID="tbProductDescription"
														Text='<%#Eval("description") %>'
														AutoPostBack="true"
														OnTextChanged="tbProduct_Update"
													></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Price">
												<ItemTemplate>
													<asp:TextBox
														runat="server"
														ID="tbProductPrice"
														Text='<%#Eval("price") %>'
														AutoPostBack="true"
														OnTextChanged="tbProduct_Update"
													></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Supplier">
												<ItemTemplate>
													<asp:TextBox
														runat="server"
														ID="tbProductSupplier"
														Text='<%#Eval("supplier") %>'
														AutoPostBack="true"
														OnTextChanged="tbProduct_Update"
													></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateField>
                                            <asp:TemplateField HeaderText="Image">
												<ItemTemplate>
													<asp:TextBox
														runat="server"
														ID="tbProductImg_Path"
														Text='<%#Eval("img_path") %>'
														AutoPostBack="true"
														OnTextChanged="tbProduct_Update"
													></asp:TextBox>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
                            <h1>Dodanie produktu</h1>
                                        <table border="1" id="gvNewProduct">
                                            <tr>
                                                <th>Kategoria</th>
                                                <th>Nazwa</th>
                                                <th>Opis</th>
                                                <th>Cena</th>
                                                <th>Dostawca</th>
                                                <th>Obrazek</th>
                                                <th>-</th>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:DropDownList runat="server" ID="addCat"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="addName"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="addDesc"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="addPrice"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="addSupp"/>
                                                </td>
                                                <td>
                                                    <asp:TextBox runat="server" ID="addImg"/>
                                                </td>
                                                <td>
                                                    <asp:Button runat="server" Text="+" ID="addBT" OnClick="addBT_Click"/>
                                                </td>
                                            </tr>
                                        </table>
                            <h1>Zarządzanie zamówieniami</h1>
									<asp:GridView
										ID="gvOrders"
										AutoGenerateColumns="false"
										runat="server"
										OnRowCommand="gvOrders_RowCommand"
										DataKeyNames="id"
										OnRowDataBound="Orders_RowDataBound">
										<Columns>
											<asp:BoundField DataField="id" HeaderText="ID" />
											<asp:BoundField DataField="user" HeaderText="User" />
											<asp:BoundField DataField="datetime" HeaderText="Date" />
											<asp:TemplateField HeaderText="State">
												<ItemTemplate>
													<asp:DropDownList ID="orderStateList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="updateOrderState"> </asp:DropDownList>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
			    
		    </form>
	    </body>
    </html>
