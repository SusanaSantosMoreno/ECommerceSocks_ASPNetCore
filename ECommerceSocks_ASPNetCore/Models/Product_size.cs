using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    [Table("Product_size")]
    public class Product_size {

        [Key]
        [Column("Product_id")]
        public int Product_id { get; set; }
        [Column("Size_id")]
        public int Size_id { get; set; }

        public Product_size() {}

        public Product_size( int product_id, int size_id ) {
            Product_id = product_id;
            Size_id = size_id;
        }
    }
}
