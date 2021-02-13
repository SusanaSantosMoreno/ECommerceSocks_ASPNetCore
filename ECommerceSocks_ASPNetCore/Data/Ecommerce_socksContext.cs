using ECommerceSocks_ASPNetCore.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Data {
    public class Ecommerce_socksContext : DbContext{

        public Ecommerce_socksContext(DbContextOptions options): base(options) { }

        public DbSet<Addresses> addresses { get; set; }
        public DbSet<Category> categories { get; set; }
        public DbSet<Collections> collections { get; set; }
        public DbSet<Discount> discounts { get; set; }
        public DbSet<Favorite> favorites { get; set; }
        public DbSet<Order_details> order_details { get; set; }
        public DbSet<Orders> orders { get; set; }
        public DbSet<Product> products { get; set; }
        public DbSet<Product_size> product_sizes { get; set; }
        public DbSet<Size> size { get; set; }
        public DbSet<Subcategory> subcategories { get; set; }
        public DbSet<Users> users { get; set; }
        public DbSet<Product_sizes> product_sizes_view { get; set; }
        public DbSet<Product_Complete> products_Complete { get; set; }
    }
}
