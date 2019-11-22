<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="as_webforms_sklep.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
		<title>Panel Administracyjny</title>

		<link rel="stylesheet prefetch" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" />
		<link rel="stylesheet prefetch" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" />
		<link rel="stylesheet prefetch" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,200,300,700" />
		<link rel="stylesheet" href="css/admin_panel.css" />

		<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
		<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/tabs.js"></script>
	</head>
	<body>
		<form id="form1" runat="server">
			<asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl="MainForm.aspx">Powrót do Main.</asp:LinkButton>
			<br />
			<asp:Label ID="lTest" runat="server" ForeColor="Red"></asp:Label>
			<div class="container">
				<section id="fancyTabWidget" class="tabs t-tabs">
					<ul class="nav nav-tabs fancyTabs" role="tablist">
						<li class="tab fancyTab active">
							<div class="arrow-down"><div class="arrow-down-inner"></div></div>
							<a id="tab0" href="#tabBody0" role="tab" aria-controls="tabBody0" aria-selected="true" data-toggle="tab" tabindex="0"><span class="hidden-xs">Users</span></a>
							<div class="whiteBlock"></div>
						</li>

						<li class="tab fancyTab">
							<div class="arrow-down"><div class="arrow-down-inner"></div></div>
							<a id="tab1" href="#tabBody1" role="tab" aria-controls="tabBody1" aria-selected="true" data-toggle="tab" tabindex="0"
								><span class="hidden-xs">Products</span></a
							>
							<div class="whiteBlock"></div>
						</li>

						<li class="tab fancyTab">
							<div class="arrow-down"><div class="arrow-down-inner"></div></div>
							<a id="tab2" href="#tabBody2" role="tab" aria-controls="tabBody2" aria-selected="true" data-toggle="tab" tabindex="0"><span class="hidden-xs">Orders</span></a>
							<div class="whiteBlock"></div>
						</li>
					</ul>
					<div id="myTabContent" class="tab-content fancyTabContent" aria-live="polite">
						<div class="tab-pane  fade active in" id="tabBody0" role="tabpanel" aria-labelledby="tab0" aria-hidden="false" tabindex="0">
							<div>
								<div class="row">
									<div class="col-md-12">
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
									</div>
								</div>
							</div>
						</div>
						<div class="tab-pane  fade" id="tabBody1" role="tabpanel" aria-labelledby="tab1" aria-hidden="true" tabindex="0">
							<div class="row">
								<div class="col-md-12">
									<asp:GridView
										ID="gvProducts"
										runat="server"
										AutoGenerateColumns="false"
										OnRowCommand="gvProducts_RowCommand"
										DataKeyNames="id"
										OnRowDataBound="Products_RowDataBound"
										OnRow
									>
										<Columns>
											<asp:BoundField DataField="id" HeaderText="ID" />
											<asp:TemplateField>
												<ItemTemplate>
													<asp:HiddenField ID="hiddenID" runat="server" Value='<%# Eval("id") %>' />
												</ItemTemplate>
											</asp:TemplateField>
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
										</Columns>
									</asp:GridView>
								</div>
							</div>
						</div>
						<div class="tab-pane  fade" id="tabBody2" role="tabpanel" aria-labelledby="tab2" aria-hidden="true" tabindex="0">
							<div class="row">
								<div class="col-md-12">
									<asp:GridView
										ID="gvOrders"
										AutoGenerateColumns="false"
										runat="server"
										OnRowCommand="gvOrders_RowCommand"
										DataKeyNames="id"
										OnRowDataBound="Orders_RowDataBound"
									>
										<Columns>
											<asp:BoundField DataField="id" HeaderText="ID" />
											<asp:BoundField DataField="user" HeaderText="User" />
											<asp:BoundField DataField="date" HeaderText="Date" />
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
								</div>
							</div>
						</div>
					</div>
				</section>
			</div>
		</form>
	</body>
</html>
