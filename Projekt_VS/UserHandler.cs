using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace as_webforms_sklep
{
    public static class UserHandler
    {
        private static Dictionary<string, int> userTokens = new Dictionary<string, int>();

        public static string tryToLogIn(string username, string passwordHash)
        {
            var queryResp = DatabaseHandler.selectQuery("SELECT id FROM users WHERE username LIKE '" + username + "' AND password_hash LIKE '" + passwordHash + "'");
            if(queryResp.Rows.Count == 1)
            {
                int userId = int.Parse(queryResp.Rows[0]["id"].ToString());
                string token = Convert.ToBase64String(Guid.NewGuid().ToByteArray());
                userTokens[token] = userId;

                return token;
            } else
                return "fail";
        }

        public static bool tryToLogOut(string token)
        {
            if (userTokens.ContainsKey(token))
            {
                userTokens.Remove(token);
                return true;
            }
            else
                return false;
        }
    }
}