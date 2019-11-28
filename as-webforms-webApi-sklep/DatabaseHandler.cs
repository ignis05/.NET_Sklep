using System;
using System.Collections.Generic;
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
            int affectedRecords = transaction.executeCommand("UPDATE product_info SET " + column + "='" + value + "' WHERE id='" + id + "'");
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

        public static bool addProduct(string category, string name, string imp_path, string description, string price, string supplier)
        {
            var transaction = new Transaction();
            int affectedRecords = transaction.executeCommand("INSERT INTO product_info (category, name, img_path, description, price, supplier) VALUES ('" + category + "', '" + name + "', '" + imp_path + "', '" + description + "', '" + price + "', '" + supplier + "')");
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

        public static bool createOrder(string userToken, List<BasketItem> basket)
        {
            int userId = UserHandler.getUserId(userToken);
            var orderIdQuery = selectQuery("SELECT MAX(id) as maxid FROM orders");
            int orderId;
            if (orderIdQuery.Rows.Count > 0)
                orderId = int.Parse(orderIdQuery.Rows[0]["maxid"].ToString()) + 1;
            else
                orderId = 0;

            var dt = DateTime.Now;
            string datetime = string.Format("{0}-{1}-{2} {3}:{4}:{5}", dt.Year, dt.Month, dt.Day, dt.Hour, dt.Minute, dt.Second);
            var transaction = new Transaction();
            int orderRecords = transaction.executeCommand("INSERT INTO orders (id, user, datetime, state) VALUES ('" + orderId.ToString() + "', '" + userId.ToString() + "', '" + datetime + "', '0')");

            int orderContentRecords = 0;
            foreach (var item in basket)
            {
                orderContentRecords += transaction.executeCommand("INSERT INTO order_contents (order_id, product_id, quantity) VALUES('" + orderId.ToString() + "', '" + item.ProductId + "', '" + item.Amount.ToString() + "')");
            }

            if(orderRecords == 1 && orderContentRecords == basket.Count)
            {
                transaction.commit();
                return true;
            } else
            {
                transaction.rollback();
                return false;
            }
        }
    }
}