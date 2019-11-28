using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;

namespace as_webforms_sklep.services
{
    public class EmailService
    {

        internal static void ProductBought(string email)
        {
            using (MailMessage mm = new MailMessage("projektsklepkoszalka@gmail.com", email))
            {
                mm.Subject = "Dziękujemy za zakup w naszym sklepie";
                mm.Body = "Dziękujemy za zakup w naszym sklepie, transakcja została wykonana pomyślnie ";
                mm.IsBodyHtml = false;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("projektsklepkoszalka@gmail.com", "zaq1@WSX");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
        }
        internal static void UserRegisterConfirmation(string email, string username)
        {
            using (MailMessage mm = new MailMessage("projektsklepkoszalka@gmail.com", email))
            {
                var id = DatabaseHandler.selectQuery("SELECT id FROM users WHERE username LIKE '" + username + "'");
                var idTrue = "";
                if (id.Rows.Count == 1)
                    idTrue = id.Rows[0]["id"].ToString();
                Debug.WriteLine(idTrue);
                Debug.WriteLine(username);
                mm.Subject = "Account Activation";
                string body = "Hello " + username + ",";
                body += "<br /><br />Please click the following link to activate your account";
                body += "<br /><a href = 'http://localhost:54291/Verify.aspx/?ActivationCode=" + idTrue + "'> Click here to activate your account. </a>";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("projektsklepkoszalka@gmail.com", "zaq1@WSX");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }

        }
    }
}