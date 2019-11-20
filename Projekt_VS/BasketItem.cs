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

        public string productId { get { return _productId; } set { _productId = value; } }
        public int amount { get { return _amount; } set { _amount = value; } }

        public BasketItem(string pid, int am)
        {
            productId = pid;
            amount = am;
        }
    }
}