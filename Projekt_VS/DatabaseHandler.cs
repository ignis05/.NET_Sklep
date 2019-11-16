using System.Data;
using System.Diagnostics;
using MySql.Data.MySqlClient;

namespace as_webforms_sklep
{
    public static class DatabaseHandler
    {
        private const string connString =
               "SERVER=inf16.tl.krakow.pl;" +
               "DATABASE=gmikolajczyk;" +
               "UID=gmikolajczyk;" +
               "PASSWORD=gmikolajczyk;";

        private static MySqlConnection connect()
        {
            var conn = new MySqlConnection(connString);

            try
            {
                conn.Open();
                conn.Close();
                Debug.WriteLine("Connected to database.");
                conn.Open();
                return conn;
            }
            catch (MySqlException ex)
            {
                Debug.WriteLine(ex.ToString());
                return null;
            }
        }

        public static DataTable selectQuery(string query)
        {
            var conn = connect();
            var sda = new MySqlDataAdapter();
            sda.SelectCommand = new MySqlCommand(query, conn);

            var dt = new DataTable();
            sda.Fill(dt);

            conn.Close();

            return dt;
        }

        public static DataTable selectTable(string tableName)
        {
            return selectQuery("SELECT * FROM " + tableName);
        }

        // UPDATE / DELETE
        public static int updateOrDeleteQuery(string query)
        {
            var conn = connect();
            var cmd = new MySqlCommand(query);
            var result = cmd.ExecuteNonQuery();
            conn.Close();

            return result;
        }
    }
}