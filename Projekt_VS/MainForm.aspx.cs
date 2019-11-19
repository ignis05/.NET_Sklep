using System;
using System.Web.UI;

namespace as_webforms_sklep
{
    public partial class MainForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["usertoken"] == null)
            {
                //Response.Redirect("LoginForm.aspx");
                lLoggedIn.Text = "<p>Nie jesteś zalogowany</p>";
                lbToAdmin.Visible = false;
                lbToLogin.Visible = true;
                bLogout.Visible = false;
            }
            else if (UserHandler.getAccessLevel(Session["usertoken"].ToString()) != "admin")
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
    }
}