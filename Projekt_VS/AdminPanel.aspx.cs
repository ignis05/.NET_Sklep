using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data;

namespace as_webforms_sklep
{
    public partial class WebForm1 : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["usertoken"] == null || UserHandler.getAccessLevel(Session["usertoken"].ToString()) != "ADMIN")
            {
                lTest.Text = "Nie jesteś adminem.";
            } else
            {
                gvUsers.DataSource = DatabaseHandler.selectTable("users");
                gvUsers.DataBind();

                gvProducts.DataSource = DatabaseHandler.selectTable("product_info");
                gvProducts.DataBind();

                gvOrders.DataSource = DatabaseHandler.selectTable("orders");
                gvOrders.DataBind();
            }
        }
    }
}