using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace as_webforms_sklep
{
    public partial class LoginForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void bLogIn_Click(object sender, EventArgs e)
        {
            string token = UserHandler.tryToLogIn(tbUsername.Text, tbPassword.Text);
            if(token == "fail")
            {
                lTestToken.Text = "Nie udało się zalogować";
            } else
            {
                Session["usertoken"] = token;
                lTestToken.Text = "Token: " + token;
            }
        }
    }
}