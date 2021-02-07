using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    public class Cart {

        public Product_Complete Product { get; set; }
        public Product_sizes Size { get; set; }
        public int Amount { get; set; }

        public Cart (Product_Complete product, Product_sizes size, int amount) {
            this.Product = product;
            this.Size = size;
            this.Amount = amount;
        }
    }
}
