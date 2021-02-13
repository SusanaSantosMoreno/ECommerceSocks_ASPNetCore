using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    [Table("Favorite_user")]
    public class Order_details {

        [Key]
        [Column("Order_id")]
        public int Order_id { get; set; }
        [Column("Product_id")]
        public int Product_id { get; set; }
        [Column("Amount")]
        public int Amount { get; set; }

        public Order_details() { }

        public Order_details( int order_id, int product_id, 
            int amount ) {
            Order_id = order_id;
            Product_id = product_id;
            Amount = amount;
        }
    }
}
