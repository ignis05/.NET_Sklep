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
                lLoggedIn.Text = "Nie jesteś zalogowany";
                lbToAdmin.Visible = false;
                lbToLogin.Visible = true;
                bLogout.Visible = false;
                lbToRegister.Visible = true;
                lbToLogin2.Visible = true;
            }
            else if (UserHandler.getAccessLevel(Session["usertoken"].ToString()) == AccessLevel.ADMIN || UserHandler.getAccessLevel(Session["usertoken"].ToString()) == AccessLevel.ROOT)
            {
                lLoggedIn.Text = "Zalogowano jako <b>" + UserHandler.getUsername(Session["usertoken"].ToString()) + "</b>";
                lbToAdmin.Visible = true;
                lbToLogin.Visible = false;
                bLogout.Visible = true;
                lbToRegister.Visible = false;
                lbToLogin2.Visible = false;
            }
            else
            {
                lLoggedIn.Text = "Zalogowano jako <b>" + UserHandler.getUsername(Session["usertoken"].ToString()) + "</b>";
                lbToAdmin.Visible = false;
                lbToLogin.Visible = false;
                bLogout.Visible = true;
                lbToRegister.Visible = false;
                lbToLogin2.Visible = false;
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

            calculateBasketItemCount();
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

        protected void calculateBasketItemCount()
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

            int totalAmount = 0;
            foreach (BasketItem basketItem in basketList)
            {
                totalAmount += basketItem.amount;
            }

            lbToBasket.Text = "Koszyk (" + totalAmount.ToString() + ")";
        }

        protected void basketHandler(object source, RepeaterCommandEventArgs e)
        {
            Debug.WriteLine("YEET");
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

                double itemPrice = 0;
                TextBox tbPrice = (TextBox)e.Item.FindControl("tbPrice");
                try
                {
                    itemPrice = double.Parse(tbPrice.Text);
                }
                catch (FormatException)
                {
                    // "Literally can't go tits up" ~ /u/1R0NYMAN, 2019
                    // https://bit.ly/35uq5xv
                    Debug.WriteLine("/u/1R0NYMAN happened");
                }

                BasketItem basketItem = basketList.Find(item => item.productId == (e.CommandArgument.ToString()));

                if (basketItem == null)
                {
                    basketItem = new BasketItem(e.CommandArgument.ToString(), amountToAdd, itemPrice);
                    basketList.Add(basketItem);
                }
                else
                {
                    basketItem.amount = basketItem.amount + amountToAdd;
                }

                calculateBasketItemCount();

                Debug.WriteLine("productId: " + basketItem.productId.ToString());
                Debug.WriteLine("amount: " + basketItem.amount.ToString());
                Debug.WriteLine("=====");
            }
        }
    }
}