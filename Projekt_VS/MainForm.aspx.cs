using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace as_webforms_sklep
{
    public partial class MainForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["usertoken"] == null)
            {
                //Response.Redirect("LoginForm.aspx");
                lLoggedIn.Text = "<p>Nie jesteś zalogowany</p>";
                lbToAdmin.Visible = false;
                lbToLogin.Visible = true;
                bLogout.Visible = false;
            }
            else if (UserHandler.getAccessLevel(Session["usertoken"].ToString()) == "ADMIN")
            {
                lLoggedIn.Text = "<p>Zalogowano jako <b>" + UserHandler.getUsername(Session["usertoken"].ToString()) + "</b></p>";
                lbToAdmin.Visible = true;
                lbToLogin.Visible = false;
                bLogout.Visible = true;
            }
            else
            {
                lLoggedIn.Text = "<p>Zalogowano jako <b>" + UserHandler.getUsername(Session["usertoken"].ToString()) + "</b></p>";
                lbToAdmin.Visible = false;
                lbToLogin.Visible = false;
                bLogout.Visible = true;
            }

            if (!IsPostBack)
            {
                rProducts.DataSource = DatabaseHandler.selectTable("product_info");
                rProducts.DataBind();
            }

            if (Session["basket"] == null)
            {
                Debug.WriteLine("Create new basket");
                Session["basket"] = new List<BasketItem>();
            }
        }

        protected void bLogout_Click(object sender, EventArgs e)
        {
            if (Session["usertoken"] != null)
            {
                UserHandler.tryToLogOut(Session["usertoken"].ToString());
                Session["usertoken"] = null;
                Response.Redirect("MainForm.aspx");
            }
        }

        protected void basketHandler(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "addToBasket")
            {
                List<BasketItem> basketList;
                if (Session["basket"] == null)
                {
                    basketList = new List<BasketItem>();
                }
                else
                {
                    basketList = (List<BasketItem>)Session["basket"];
                }

                int amountToAdd = 1;
                TextBox tbAmount = (TextBox)e.Item.FindControl("tbAmount");
                try
                {
                    amountToAdd = int.Parse(tbAmount.Text);
                }
                catch (FormatException)
                {
                    amountToAdd = 1;
                }

                BasketItem basketItem = basketList.Find(item => item.productId == (e.CommandArgument.ToString()));

                if (basketItem == null)
                {
                    basketItem = new BasketItem(e.CommandArgument.ToString(), amountToAdd);
                    basketList.Add(basketItem);
                }
                else
                {
                    basketItem.amount = basketItem.amount + amountToAdd;
                }

                Debug.WriteLine("productId: " + basketItem.productId.ToString());
                Debug.WriteLine("amount: " + basketItem.amount.ToString());
                Debug.WriteLine("=====");
            }
        }
    }
}