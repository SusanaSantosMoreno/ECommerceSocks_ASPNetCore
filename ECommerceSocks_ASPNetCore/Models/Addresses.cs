using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    
    [Table("Addresses")]
    public class Addresses {

        [Key]
        [Column("Addresses_id")]
        public int Addresses_id { get; set; }

        [Column("Addresses_user")]
        public Users Addresses_user { get; set; }

        [Column("Addresses_name")]
        public String Addresses_name { get; set; }

        [Column("Addresses_street")]
        public String Addresses_street { get; set; }

        [Column("Addresses_cp")]
        public String Addresses_cp { get; set; }

        [Column("Addresses_country")]
        public String Addresses_country { get; set; }

        [Column("Addresses_province")]
        public String Addresses_province { get; set; }

        [Column("Addresses_city")]
        public String Addresses_city { get; set; }

        public Addresses() { }

        public Addresses( int addresses_id, Users addresses_user, 
            string addresses_name, string addresses_street, 
            string addresses_cp, string addresses_country, 
            string addresses_province, string addresses_city ) {

            this.Addresses_id = addresses_id;
            this.Addresses_user = addresses_user;
            this.Addresses_name = addresses_name;
            this.Addresses_street = addresses_street;
            this.Addresses_cp = addresses_cp;
            this.Addresses_country = addresses_country;
            this.Addresses_province = addresses_province;
            this.Addresses_city = addresses_city;
        }
    }
}
