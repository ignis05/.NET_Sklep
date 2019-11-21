using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace as_webforms_sklep
{
    public partial class BasketForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["basket"] == null)
            {
                Debug.WriteLine("Create new basket");
                Session["basket"] = new List<BasketItem>();
            }

            if (!IsPostBack)
            {
                rBasket.DataSource = createProductList();
                rBasket.DataBind();
            }

            calculateTotalPrice();
        }

        protected DataTable createProductList()
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

            DataTable dt = new DataTable();
            foreach (BasketItem basketItem in basketList)
            {
                DataTable tempDt = DatabaseHandler.selectQuery("SELECT * FROM product_info WHERE id = " + basketItem.productId);
                tempDt.Columns.Add("amount", typeof(int));
                tempDt.Rows[0]["amount"] = basketItem.amount;

                dt.Merge(tempDt);
            }

            return dt;
        }

        protected void calculateTotalPrice()
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

            double totalPrice = 0;
            foreach (BasketItem basketItem in basketList)
            {
                totalPrice += basketItem.amount * basketItem.price;
            }

            lTotalPrice.Text = "Cena wszystkich przedmiotów w koszyku to: " + totalPrice.ToString("N2") + " zł";
        }

        protected void basketHandler(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "changeInBasket")
            {
                Debug.WriteLine("changeInBasket");
                List<BasketItem> basketList;
                if (Session["basket"] == null)
                {
                    basketList = new List<BasketItem>();
                }
                else
                {
                    basketList = (List<BasketItem>)Session["basket"];
                }

                BasketItem basketItem = basketList.Find(item => item.productId == (e.CommandArgument.ToString()));

                int amountToSet = 0;
                TextBox tbAmount = (TextBox)e.Item.FindControl("tbAmount");
                try
                {
                    amountToSet = int.Parse(tbAmount.Text);
                }
                catch (FormatException)
                {
                    amountToSet = basketItem.amount;
                }

                basketItem.amount = amountToSet;

                calculateTotalPrice();
            }
            else if (e.CommandName == "removeFromBasket")
            {
                Debug.WriteLine("removeFromBasket");
                List<BasketItem> basketList;
                if (Session["basket"] == null)
                {
                    basketList = new List<BasketItem>();
                }
                else
                {
                    basketList = (List<BasketItem>)Session["basket"];
                }

                BasketItem basketItem = basketList.Find(item => item.productId == (e.CommandArgument.ToString()));

                basketList.Remove(basketItem);
                rBasket.DataSource = createProductList();
                rBasket.DataBind();

                calculateTotalPrice();
            }
        }
    }
}