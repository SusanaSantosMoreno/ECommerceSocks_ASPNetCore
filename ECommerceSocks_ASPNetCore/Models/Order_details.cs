using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    [Table("Order_details")]
    public class Order_details {

        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Column("Order_Details_id")]
        public int Order_Details_id { get; set; }
        [Column("Order_id")]
        public int Order_id { get; set; }
        [Column("Product_id")]
        public int Product_id { get; set; }
        [Column("Size_id")]
        public int Size_id { get; set; }
        [Column("Amount")]
        public int Amount { get; set; }

        public Order_details() { }

        public Order_details (int order_id, int product_id, int size_id, int amount) {
            Order_id = order_id;
            Product_id = product_id;
            Size_id = size_id;
            Amount = amount;
        }
    }
}
