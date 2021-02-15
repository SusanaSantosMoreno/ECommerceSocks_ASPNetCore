using ECommerceSocks_ASPNetCore.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Data {
    public class Ecommerce_socksContext : DbContext{

        public Ecommerce_socksContext(DbContextOptions options): base(options) { }

        public DbSet<Addresses> Addresses { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Collections> Collections { get; set; }
        public DbSet<Discount> Discounts { get; set; }
        public DbSet<Favorite> Favorites { get; set; }
        public DbSet<Order_details> Order_details { get; set; }
        public DbSet<Orders> Orders { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<Product_size> Product_sizes { get; set; }
        public DbSet<Size> Size { get; set; }
        public DbSet<Subcategory> Subcategories { get; set; }
        public DbSet<Users> Users { get; set; }
        public DbSet<Product_sizes> Product_sizes_view { get; set; }
        public DbSet<Product_Complete> Products_Complete { get; set; }
    }
}
