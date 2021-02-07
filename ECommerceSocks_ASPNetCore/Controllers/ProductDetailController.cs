using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
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
            Product_Complete product = this.repository.GetProduct_Complete(product_id);
            List<Product_Complete> products = this.repository.
                GetProduct_CompletesByCategory((int)product.Product_category);
            ViewData["Products"] = products;
            List<Product_sizes> productSizes = this.repository.GetProduct_Sizes_Views(product.Product_id);
            ViewData["ProductSize"] = productSizes;
            return View(product);
        }

        [HttpPost]
        public IActionResult Index (int product_id, int size_id) {
            //ADD PRODUCT TO SESSION CART
            Product_Complete product = this.repository.GetProduct_Complete(product_id);
            Product_sizes product_size = this.repository.GetProduct_Size_View(product_id, size_id);
            Cart cart = new Cart(product, product_size, 1);
            if (this.HttpContext.Session.GetString("SesionCart") != null) {
                List<Cart> sessionCartItems = JsonConvert.DeserializeObject<List<Cart>>(this.HttpContext.Session.GetString("SesionCart"));
                sessionCartItems.Add(cart);
                this.HttpContext.Session.SetString("SesionCart", JsonConvert.SerializeObject(sessionCartItems));
            } else {
                List<Cart> cart_items = new List<Cart>();
                cart_items.Add(cart);
                this.HttpContext.Session.SetString("SesionCart", JsonConvert.SerializeObject(cart_items));
            }
            return RedirectToAction("Index", new { product_id = product.Product_id });
        }
    }
}
