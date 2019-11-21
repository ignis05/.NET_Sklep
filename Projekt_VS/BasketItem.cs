using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace as_webforms_sklep
{
    public class BasketItem
    {
        private string _productId;
        private int _amount;
        private double _price;

        public string productId { get { return _productId; } set { _productId = value; } }
        public int amount { get { return _amount; } set { _amount = value; } }
        public double price { get { return _price; } set { _price = value; } }

        public BasketItem(string pid, int am, double pr)
        {
            productId = pid;
            amount = am;
            price = pr;
        }
    }
}