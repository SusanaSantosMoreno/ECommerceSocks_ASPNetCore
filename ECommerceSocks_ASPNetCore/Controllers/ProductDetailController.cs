using ECommerceSocks_ASPNetCore.Helpers;
using EcommerceSocksAPI.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Services;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class ProductDetailController : Controller {

        private Ecommerce_socksService service;
        private PathProvider provider;
        private CachingService cachingService;

        public ProductDetailController (Ecommerce_socksService service, PathProvider provider, 
            CachingService caching) {
            this.service = service;
            this.cachingService = caching;
            this.provider = provider;
        }
        public async Task<IActionResult> Index (int product_id, int? favorite) {
            if (favorite != null) {
                this.cachingService.saveFavoritesCache((int)favorite);
            }
            Product_Complete product = await this.service.GetProductCompleteAsync(product_id);
            List<Product_Complete> products = product.Product_category != 4 ? await this.service.
                GetProductCompleteByCategoryAsync((int)product.Product_category) : 
                await this.service.GetProductCompleteAsync();
            ViewData["Products"] = products;
            List<Product_sizes> productSizes = await this.service.GetProduct_SizesByProductAsync(product.Product_id);
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
