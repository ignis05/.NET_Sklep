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
            if (!Page.IsPostBack)
            {
                if (Session["usertoken"] == null)
                {
                    Response.Redirect("LoginForm.aspx");
                }
                else if (UserHandler.getAccessLevel(Session["usertoken"].ToString()) != AccessLevel.ADMIN && UserHandler.getAccessLevel(Session["usertoken"].ToString()) != AccessLevel.ROOT)
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
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteUser")
            {
                Debug.WriteLine(e.CommandArgument.ToString());

                if (UserHandler.deleteUser(e.CommandArgument.ToString()))
                    Debug.WriteLine("Deleted user with id: " + e.CommandArgument.ToString());
                else
                    Debug.WriteLine("Failed to delete user with id: " + e.CommandArgument.ToString());

                gvUsers.DataSource = DatabaseHandler.selectTable("users");
                gvUsers.DataBind();
            }
            else if (e.CommandName == "UpdateUser")
            {
                Debug.WriteLine(e.CommandArgument.ToString());
                string[] commandArgs = e.CommandArgument.ToString().Split(new char[] { ',' });
                string id = commandArgs[0];
                string access = commandArgs[1];

                if(UserHandler.updateAccess(id,access == "1" ? "0" : "1"))
                    Debug.WriteLine("Updated access for user with id: " + id + " to: " + access);
                else
                    Debug.WriteLine("Failed to update access for user with id: " + id + " to: " + access);

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
                else if (Convert.ToInt32(myValue) == 0)
                    return "Promote";
                else
                    return "";
            }
        }

        protected void gvOrders_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateState")
            {
                Debug.WriteLine(e.CommandArgument.ToString());

                if (UserHandler.deleteUser(e.CommandArgument.ToString()))
                    Debug.WriteLine("Deleted user with id: " + e.CommandArgument.ToString());
                else
                    Debug.WriteLine("Failed to delete user with id: " + e.CommandArgument.ToString());

                gvUsers.DataSource = DatabaseHandler.selectTable("users");
                gvUsers.DataBind();
            }
        }
        protected void updateOrderState(object sender, EventArgs e)
        {
            GridViewRow gvr = ((DropDownList)sender).NamingContainer as GridViewRow;
            var list = gvr.FindControl("orderStateList") as DropDownList;
            string val = list.SelectedValue;
            HiddenField hf1 = (HiddenField)gvr.FindControl("hiddenID");
            string id = hf1.Value;
            DatabaseHandler.updateOrder(id,val);
            gvUsers.DataSource = DatabaseHandler.selectTable("users");
            gvUsers.DataBind();
        }

        protected void Orders_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var ddl = e.Row.FindControl("orderStateList") as DropDownList;
                if (ddl != null)
                {
                    ddl.DataSource = new List<string>() { "0", "1", "2", "3", };
                    ddl.DataBind();
                    ddl.SelectedValue = DataBinder.Eval(e.Row.DataItem, "state").ToString();
                }
            }
        }

    }
}