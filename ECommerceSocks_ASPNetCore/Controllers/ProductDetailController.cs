﻿using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class ProductDetailController : Controller {

        private Ecommerce_socksRepository repository;

        public ProductDetailController (Ecommerce_socksRepository repo) {
            this.repository = repo;
        }
        public IActionResult Index (int product_id) {
            Product product = this.repository.GetProduct(product_id);
            product.Category = this.repository.GetCategory((int)product.Product_category);
            product.Subcategory = this.repository.GetSubcategory((int)product.Product_subcategory);
            return View(product);
        }
    }
}