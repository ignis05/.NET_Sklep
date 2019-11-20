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
            // Tak tylko dla sprawdzenia czy działa
            if(Session["usertoken"] == null)
            {
                Response.Redirect("LoginForm.aspx");
            }
            else if(UserHandler.getAccessLevel(Session["usertoken"].ToString()) != "ADMIN")
            {
                lTest.Text = "Nie jesteś adminem.";
            }
            else
            {
                gvUsers.DataSource = DatabaseHandler.selectTable("users");
                gvUsers.DataBind();

                gvProducts.DataSource = DatabaseHandler.selectTable("product_info");
                gvProducts.DataBind();

                gvOrders.DataSource = DatabaseHandler.selectTable("orders");
                gvOrders.DataBind();
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteUser")
            {
                Debug.WriteLine(e.CommandArgument.ToString());
                DatabaseHandler.deleteUser(e.CommandArgument.ToString());
                gvUsers.DataSource = DatabaseHandler.selectTable("users");
                gvUsers.DataBind();
            }
            else if (e.CommandName == "UpdateUser")
            {
                Debug.WriteLine(e.CommandArgument.ToString());
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                string id = commandArgs[0];
                string access = commandArgs[1];
                DatabaseHandler.updateAccess(id,access == "1" ? "0" : "1");
                gvUsers.DataSource = DatabaseHandler.selectTable("users");
                gvUsers.DataBind();
            }
        }


        public static string ProcessAccessLevel(object myValue)
        {
            if (myValue == null)
            {
                return "error";
            }
            else
            {
                if (Convert.ToInt32(myValue) == 1)
                    return "Demote";
                else
                    return "Promote";
            }

        }
    }
}