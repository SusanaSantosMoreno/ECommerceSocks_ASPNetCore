using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Services;
using EcommerceSocksAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CartController : Controller {

        Ecommerce_socksService service;
        CachingService cachingService;

        public CartController (Ecommerce_socksService service, CachingService caching) {
            this.service = service;
            this.cachingService = caching;
        }

        public async Task<IActionResult> Index (int? product_removed, int? size_removed) {
            if(product_removed != null && size_removed != null) {
                this.cachingService.RemoveCartCache((int)product_removed, (int)size_removed);
            }
            List<Cart> cart = new List<Cart>();
            cart = this.cachingService.GetCartCache();
            List<Cart_Complete> cartComplete = new List<Cart_Complete>();
            foreach (Cart c in cart) {
                Product_sizes size = await this.service.GetProduct_SizesByProductSizeAsync(c.Product_id, c.Size_id);
                cartComplete.Add(new Cart_Complete(await this.service.GetProductCompleteAsync(c.Product_id), size, c.Amount));
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
