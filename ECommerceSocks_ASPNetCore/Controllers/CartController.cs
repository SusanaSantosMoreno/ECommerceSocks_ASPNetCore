using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CartController : Controller {

        IRepositoryEcommerce_socks repository;
        CachingService cachingService;

        public CartController (IRepositoryEcommerce_socks repo, CachingService caching) {
            this.repository = repo;
            this.cachingService = caching;
        }

        public IActionResult Index (int? product_removed, int? size_removed) {
            if(product_removed != null && size_removed != null) {
                this.cachingService.RemoveCartCache((int)product_removed, (int)size_removed);
            }
            List<Cart> cart = new List<Cart>();
            cart = this.cachingService.GetCartCache();
            List<Cart_Complete> cartComplete = new List<Cart_Complete>();
            foreach (Cart c in cart) {
                cartComplete.Add(new Cart_Complete(this.repository.GetProduct_Complete(c.Product_id),
                    this.repository.GetProduct_Size_View(c.Product_id, c.Size_id), c.Amount));
            }
            return View(cartComplete);
        }

        [HttpPost]
        public IActionResult Index(int product_id, int size_id, int amount) {
            this.cachingService.EditCartCache(product_id, size_id, amount);
            return RedirectToAction("Index");
        }
    }
}
