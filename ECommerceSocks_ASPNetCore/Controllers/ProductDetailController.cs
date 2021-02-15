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

        private IRepositoryEcommerce_socks repository;
        private PathProvider provider;
        private CachingService cachingService;

        public ProductDetailController (IRepositoryEcommerce_socks repo, PathProvider provider, 
            CachingService caching) {
            this.repository = repo;
            this.cachingService = caching;
            this.provider = provider;
        }
        public IActionResult Index (int product_id, int? favorite) {
            if (favorite != null) {
                this.cachingService.saveFavoritesCache((int)favorite);
            }
            Product_Complete product = this.repository.GetProduct_Complete(product_id);
            List<Product_Complete> products = product.Product_category != 4 ? this.repository.
                GetProduct_CompletesByCategory((int)product.Product_category) : 
                this.repository.GetProduct_Completes();
            ViewData["Products"] = products;
            List<Product_sizes> productSizes = this.repository.GetProduct_Sizes_Views(product.Product_id);
            ViewData["ProductSize"] = productSizes;
            List<String> imgs = this.provider.FindFiles("Product_" + product.Product_id, @"images/products");
            ViewData["Images"] = imgs;
            return View(product);
        }

        [HttpPost]
        public IActionResult Index (int product_id, int size_id) {
            //Add products to cart
            List<Cart> cart = new List<Cart>();
            cart = this.cachingService.GetCartCache();

            if (cart.Count > 0) {//existen productos, comprobamos que el nuestro exista
                foreach (Cart c in cart) {
                    if (c.Product_id == product_id) {
                        //si tenemos el mismo producto, comprobamos la talla
                        if (c.Size_id != size_id) {//si es distinta, se añade al carrito
                            this.cachingService.SaveCartCache(product_id, size_id, 1);
                        } else {//si existe el mismo producto con la misma talla, aumentamos su cantidad
                            this.cachingService.EditCartCache(product_id, size_id);
                        }
                    } else {
                        this.cachingService.SaveCartCache(product_id, size_id, 1);
                    }
                }
            } else {
                this.cachingService.SaveCartCache(product_id, size_id, 1);
            }
            return RedirectToAction("Index", new { product_id = product_id });
        }
    }
}
