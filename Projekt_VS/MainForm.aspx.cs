using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace as_webforms_sklep
{
    public partial class MainForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["usertoken"] == null)
            {
                Response.Redirect("LoginForm.aspx");
            } else
                Label1.Text = "<p>Zalogowano jako <b>" + UserHandler.getUsername(Session["usertoken"].ToString()) + "</b></p>";
        }
    }
}