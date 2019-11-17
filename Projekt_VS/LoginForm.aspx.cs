using System;
using System.Web.UI;

namespace as_webforms_sklep
{
    public partial class LoginForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void bLogIn_Click(object sender, EventArgs e)
        {
            string token = UserHandler.tryToLogIn(tbUsername.Text, tbPassword.Text);
            if(token == "fail")
            {
                lMsg.Text = "Nieprawidłowy login lub hasło.";
            } else
            {
                Session["usertoken"] = token;
                Response.Redirect("MainForm.aspx");
            }
        }

        protected void bGoToRegister_Click(object sender, EventArgs e)
        {
            Response.Redirect("RegisterForm.aspx");
        }
    }
}