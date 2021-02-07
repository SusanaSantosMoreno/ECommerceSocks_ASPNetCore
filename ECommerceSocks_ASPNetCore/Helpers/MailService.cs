using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Helpers {
    public class MailService {

        IConfiguration configuration;

        public MailService(IConfiguration conf) {
            this.configuration = conf;
        }

        private MailMessage ConfigureMail(String receiver, String subject, String message) {
            MailMessage mailMessage = new MailMessage();
            mailMessage.From = new MailAddress(this.configuration["mail"]);
            mailMessage.To.Add(new MailAddress(receiver));
            mailMessage.Subject = subject;
            mailMessage.Body = message;
            mailMessage.IsBodyHtml = true;
            mailMessage.Priority = MailPriority.Normal;
            return mailMessage;
        }

        private void ConfigureSmtp(MailMessage mailMessage) {
            SmtpClient smtpClient = new SmtpClient();
            smtpClient.Host = this.configuration["host"];
            smtpClient.Port = int.Parse(this.configuration["port"]);
            smtpClient.EnableSsl = bool.Parse(this.configuration["ssl"]);
            smtpClient.UseDefaultCredentials = bool.Parse(this.configuration["defaultCredentials"]);
            NetworkCredential userCredential = 
                new NetworkCredential(this.configuration["mail"], this.configuration["mailPassword"]);
            smtpClient.Credentials = userCredential;
            smtpClient.Send(mailMessage);
        }

        public void SendMail(String receiver, String subject, String message) {
            MailMessage mail = this.ConfigureMail(receiver, subject, message);
            this.ConfigureSmtp(mail);
        }

        public void SendMail (String receiver, String subject, String message, String filePath) {
            MailMessage mail = this.ConfigureMail(receiver, subject, message);
            Attachment attachment = new Attachment(filePath);
            mail.Attachments.Add(attachment);
            this.ConfigureSmtp(mail);
        }
    }
}
