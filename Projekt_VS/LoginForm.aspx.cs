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
            string pwHash = CalculateMD5Hash(tbPassword.Text);
            string token = UserHandler.tryToLogIn(tbUsername.Text, pwHash);
            if(token == "fail")
            {
                lTestToken.Text = "Nie udało się zalogować";
            } else
            {
                Session["usertoken"] = token;
                lTestToken.Text = "Token: " + token;
            }
        }

        // Ukradzione z jakiegoś blogu
        public string CalculateMD5Hash(string input)
        {
            // step 1, calculate MD5 hash from input
            MD5 md5 = MD5.Create();
            byte[] inputBytes = Encoding.UTF8.GetBytes(input);
            byte[] hash = md5.ComputeHash(inputBytes);

            // step 2, convert byte array to hex string
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString().ToLower();
        }
    }
}