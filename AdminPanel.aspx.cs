using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Diagnostics;
using System.Data;

namespace as_webforms_sklep
{
    public partial class WebForm1 : Page
    {
        MySqlConnection conn = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            Debug.WriteLine("Starting");
            connect();
            tableToGridView("users", gvUsers);
            tableToGridView("products", gvProducts);
            tableToGridView("orders", gvOrders);
        }

        void connect()
        {
            string myconnection =
               "SERVER=inf16.tl.krakow.pl;" +
               "DATABASE=gmikolajczyk;" +
               "UID=gmikolajczyk;" +
               "PASSWORD=gmikolajczyk;";

            MySqlConnection connection = new MySqlConnection(myconnection);

            try
            {
                connection.Open();
                connection.Close();
                System.Diagnostics.Debug.WriteLine("Connected");
                conn = connection;
                conn.Open();
            }
            catch (MySqlException ex)
            {
                Debug.WriteLine(ex.ToString());
            }
        }

        public int tableToGridView(string table, GridView gv)
        {
            if (conn == null) return -1;

            var sda = new MySqlDataAdapter();
            sda.SelectCommand = new MySqlCommand("SELECT * FROM " + table, conn);

            var dt = new DataTable();
            sda.Fill(dt);
            gv.DataSource = dt;
            gv.DataBind();


            return 0;
        }
    }
}