using System.Data;
using System.Diagnostics;
using MySql.Data.MySqlClient;

namespace as_webforms_sklep
{
    public static class DatabaseHandler
    {
        private const string connString =
               "SERVER=inf16.tl.krakow.pl;" +
               "DATABASE=manowak;" +
               "UID=manowak;" +
               "PASSWORD=manowak;";

        private static MySqlConnection connect()
        {
            var conn = new MySqlConnection(connString);

            try
            {
                conn.Open();
                Debug.WriteLine("Connected to database.");
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

        // Wszystkie modyfikacje danych chyba najlepiej robić transakcjami
        public class Transaction
        {
            private MySqlConnection conn;

            public Transaction()
            {
                conn = connect();
                new MySqlCommand("BEGIN", conn).ExecuteNonQuery();
            }

            public int executeCommand(string cmd)
            {
                return new MySqlCommand(cmd, conn).ExecuteNonQuery();
            }

            public void commit()
            {
                new MySqlCommand("COMMIT", conn).ExecuteNonQuery();
                conn.Close();
            }

            public void rollback()
            {
                new MySqlCommand("ROLLBACK", conn).ExecuteNonQuery();
                conn.Close();
            }
        }

        public static bool updateOrder(string id, string state)
        {
            var transaction = new Transaction();
            int affectedRecords = transaction.executeCommand("UPDATE orders SET state='" + state + "' WHERE id='" + id + "'");
            if(affectedRecords == 1)
            {
                transaction.commit();
                return true;
            } else
            {
                transaction.rollback();
                return false;
            }
        }

        public static bool updateProductCategory(string id, string category)
        {
            var transaction = new Transaction();
            int affectedRecords = transaction.executeCommand("UPDATE product_info SET category='" + category + "' WHERE id='" + id + "'");
            if (affectedRecords == 1)
            {
                transaction.commit();
                return true;
            }
            else
            {
                transaction.rollback();
                return false;
            }
        }

        public static bool updateProductCol(string id, string column, string value)
        {
            var transaction = new Transaction();
            int affectedRecords = transaction.executeCommand("UPDATE product_info SET "+column+"='"+value+"' WHERE id='" + id + "'");
            if (affectedRecords == 1)
            {
                transaction.commit();
                return true;
            }
            else
            {
                transaction.rollback();
                return false;
            }
        }
    }
}