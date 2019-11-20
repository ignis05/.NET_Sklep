using System;
using System.Collections.Generic;
using System.Data;
using System.Security.Cryptography;
using System.Text;

namespace as_webforms_sklep
{
    public static class UserHandler
    {
        struct ServerSideSession {
            public bool Success { get; }
            public int UserId { get; }
            // Dane użytkownika teoretycznie powinny być szyfrowane(RODO itp.), ale nie wiem czy nam się chce. Można to tu zostawić i powiedzieć Koszale, że to coś robi.
            public string EncryptionKey { get; }
            public string Username { get; }

            public ServerSideSession(string username, string password)
            { 
                string passwordHash = CalculateMD5Hash(password);
                var queryResp = DatabaseHandler.selectQuery("SELECT id FROM users WHERE username LIKE '" + username + "' AND password_hash LIKE '" + passwordHash + "'");
                if (queryResp.Rows.Count == 1)
                {
                    int id = int.Parse(queryResp.Rows[0]["id"].ToString());
                    UserId = id;
                    EncryptionKey = password;
                    Username = username;
                    Success = true;
                } else
                {
                    UserId = -1;
                    EncryptionKey = null;
                    Username = username;
                    Success = false;
                }
            }
        }

        private static string CalculateMD5Hash(string input)
        {
            MD5 md5 = MD5.Create();
            byte[] inputBytes = Encoding.UTF8.GetBytes(input);
            byte[] hash = md5.ComputeHash(inputBytes);

            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < hash.Length; i++)
            {
                sb.Append(hash[i].ToString("X2"));
            }
            return sb.ToString().ToLower();
        }

        private static Dictionary<string, ServerSideSession> sessions = new Dictionary<string, ServerSideSession>();

        // Tak, przesyłanie hasła w plain-texcie, jakiekolwiek zabezpieczenia tu są na niby. Koszała się i tak nie zorientuje.
        public static string tryToLogIn(string username, string password)
        {
            var session = new ServerSideSession(username, password);
            if(session.Success)
            {
                string token = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
                sessions[token] = session;

                return token;
            }
            else
                return "fail";
        }

        public static bool tryToLogOut(string token)
        {
            if (sessions.ContainsKey(token))
            {
                sessions.Remove(token);
                return true;
            }
            else
                return false;
        }

        public static bool tryToRegister(string username, string password, string email, string[] data)
        {
            int userAccessLevel = int.Parse(DatabaseHandler.selectQuery("SELECT id FROM access_levels WHERE name LIKE 'USER'").Rows[0]["id"].ToString());
            string userCMD = "INSERT INTO users (username, password_hash, access_level) VALUES('{0}', '{1}', '{2}')";
            string userDataCMD = "INSERT INTO user_data (user_id, email, first_name, last_name, billing_address) VALUES('{0}', '{1}', '{2}', '{3}', '{4}')";

            var transaction = new DatabaseHandler.Transaction();
            try
            {
                int userInsertSuccess = transaction.executeCommand(string.Format(userCMD, username, CalculateMD5Hash(password), userAccessLevel.ToString()));
                if (userInsertSuccess == 1)
                {
                    transaction.commit();
                    transaction = new DatabaseHandler.Transaction();
                    int userID = int.Parse(DatabaseHandler.selectQuery("SELECT id FROM users WHERE username LIKE '" + username + "'").Rows[0]["id"].ToString());
                    int dataInsertSuccess = transaction.executeCommand(string.Format(userDataCMD, userID.ToString(), email, data[0], data[1], data[2]));
                    if (dataInsertSuccess == 1)
                    {
                        transaction.commit();
                        return true;
                    }
                    else
                        transaction.rollback();
                }
                else
                    transaction.rollback();
            } catch (Exception ex)
            {
                transaction.rollback();
            }

            return false;
        }

        public static string getUsername(string token)
        {
            if (sessions.ContainsKey(token))
                return sessions[token].Username;
            else
                return "";
        }

        public static string getAccessLevel(string token)
        {
            if (sessions.ContainsKey(token))
            {
                var user = sessions[token];
                var levelIdQuery = DatabaseHandler.selectQuery("SELECT access_level FROM users WHERE id LIKE '" + user.UserId + "'");
                if (levelIdQuery.Rows.Count == 1)
                {
                    int levelId = int.Parse(levelIdQuery.Rows[0]["access_level"].ToString());
                    var accessLevelQuery = DatabaseHandler.selectQuery("SELECT name FROM access_levels WHERE id LIKE '" + levelId + "'");
                    if (accessLevelQuery.Rows.Count == 1)
                    {
                        return accessLevelQuery.Rows[0]["name"].ToString();
                    }
                }
            }

            return "ERROR";
        }

        // Dla użytku serwerowego bez sesji, np. wysyłanie maila potwierdzającego rejestrację/zamówienie
        public static DataTable getUserData(int userId)
        {
            var query = DatabaseHandler.selectQuery("SELECT * FROM user_data WHERE user_id LIKE '" + userId + "'");
            if (query.Rows.Count == 1)
                return query;
            else
                return null;
        }

        public static DataTable getUserData(string token)
        {
            if (sessions.ContainsKey(token))
                return getUserData(sessions[token].UserId);
            else
                return null;
        }

        public static bool deleteUser(string id)
        {
            var transaction = new DatabaseHandler.Transaction();
            int affectedRecords1 = transaction.executeCommand("DELETE FROM user_data WHERE user_id='" + id + "'");
            int affectedRecords2 = transaction.executeCommand("DELETE FROM users WHERE id='" + id + "'");
            // Obie operacja powinny usunąć nie mniej i nie więcej niż 1 rekord
            if(affectedRecords1 == 1 && affectedRecords2 == 1)
            {
                transaction.commit();
                return true;
            } else
            {
                transaction.rollback();
                return false;
            }
        }

        public static bool updateAccess(string id, string access)
        {
            var transaction = new DatabaseHandler.Transaction();
            int affectedRecords = transaction.executeCommand("UPDATE users SET access_level='" + access + "' WHERE id='" + id + "'");
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
    }
}