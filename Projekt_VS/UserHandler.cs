using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace as_webforms_sklep
{
    public static class UserHandler
    {
        struct ServerSideSession {
            public bool Success { get; set; }
            public int UserId { get; set; }
            // Dane użytkownika teoretycznie powinny być szyfrowane(RODO itp.), ale nie wiem czy nam się chce. Można to tu zostawić i powiedzieć Koszale, że to coś robi.
            public string EncryptionKey { get; set; }

            public ServerSideSession(string username, string password)
            { 
                string passwordHash = CalculateMD5Hash(password);
                var queryResp = DatabaseHandler.selectQuery("SELECT id FROM users WHERE username LIKE '" + username + "' AND password_hash LIKE '" + passwordHash + "'");
                if (queryResp.Rows.Count == 1)
                {
                    int id = int.Parse(queryResp.Rows[0]["id"].ToString());
                    UserId = id;
                    EncryptionKey = password;
                    Success = true;
                } else
                {
                    UserId = -1;
                    EncryptionKey = null;
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
            } else
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
    }
}