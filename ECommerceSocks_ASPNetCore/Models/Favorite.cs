﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    [Table("Favorite")]
    public class Favorite {

        [Key]
        [Column("Favorite_id")]
        public int Favorite_id { get; set; }
        [Column("Favorite_product")]
        public int Favorite_product { get; set; }
        [Column("Favorite_pack")]
        public int Favorite_pack { get; set; }
        [Column("Favorite_user")]
        public int Favorite_user { get; set; }

        public Favorite() { }

        public Favorite( int favorite_id, int favorite_product, 
            int favorite_pack, int favorite_user ) {
            Favorite_id = favorite_id;
            Favorite_product = favorite_product;
            Favorite_pack = favorite_pack;
            Favorite_user = favorite_user;
        }
    }
}