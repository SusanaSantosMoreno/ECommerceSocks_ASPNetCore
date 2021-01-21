using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {

    [Table("Users")]
    public class Users {

        [Key]
        [Column("Users_id")]
        public int Users_id { get; set; }

        [Column("Users_name")]
        public String Users_name { get; set; }
        
        [Column("Users_email")]
        public String Users_email { get; set; }

        [Column("Users_password")]
        public String User_password { get; set; }

        [Column("Users_nationality")]
        public String User_nationality { get; set; }

        [Column("Users_phone")]
        public String User_phone { get; set; }

        [Column("Users_birthDate")]
        public DateTime User_birthDate { get; set; }

        public ICollection<Addresses> Users_Addresses { get; set; }


        public Users() {}

        public Users( int users_id, string users_name, string users_email, 
            string user_password, string user_nationality, string user_phone, 
            DateTime user_birthDate, ICollection<Addresses> addresses) {
            this.Users_id = users_id;
            this.Users_name = users_name;
            this.Users_email = users_email;
            this.User_password = user_password;
            this.User_nationality = user_nationality;
            this.User_phone = user_phone;
            this.User_birthDate = user_birthDate;
            this.Users_Addresses = addresses;
        }
    }
}
