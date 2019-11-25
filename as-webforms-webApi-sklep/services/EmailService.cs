using System;
using System.Collections.Generic;
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
                mm.Subject = "Thank";
                mm.Body = "Jest zajebiście, transakcja wykonana pomyślnie, tu będzie link";
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
                mm.Subject = "Thank";
                mm.Body = "Witaj " + username;
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
    }
}