using System;
using System.Web.UI;

namespace as_webforms_sklep
{
    public partial class RegisterForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void bRegister_Click(object sender, EventArgs e)
        {
            if(IsValid)
            {
                var query = DatabaseHandler.selectQuery("SELECT username FROM users WHERE username LIKE '" + tbUsername.Text + "'");
                if(query.Rows.Count == 1)
                {
                    lMsg.Text = "Nazwa użytkownika zajęta.";
                } else
                {
                    if (UserHandler.tryToRegister(tbUsername.Text, tbPassword.Text, tbEmail.Text, new string[3] { tbFirstName.Text, tbLastName.Text, tbAddress.Text}))
                    {
                        lMsg.Text = "Pomyślnie zarejestrowano.";
                    } else
                    {
                        lMsg.Text = "Błąd podczas rejestracji.";
                    }
                }
            }
        }

        protected void bGotToLogIn_Click(object sender, EventArgs e)
        {
            Response.Redirect("LoginForm.aspx");
        }
    }
}