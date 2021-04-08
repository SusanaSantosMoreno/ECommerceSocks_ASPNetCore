using ECommerceSocks_ASPNetCore.Helpers;
using EcommerceSocksAPI.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Services;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class FavoritesController : Controller {

        private Ecommerce_socksService service;
        private CachingService cachingService;

        public FavoritesController (Ecommerce_socksService service, CachingService caching) {
            this.service = service;
            this.cachingService = caching;
        }

        public async Task<IActionResult> Index (int? disfav) {
            List<int> favorites = new List<int>();
            if(disfav != null) {
                favorites = this.cachingService.RemoveFavoriteCache((int)disfav);
            } else {
                favorites = this.cachingService.getFavoritesCache();
            }
            
            List<Product_Complete> favProducts = new List<Product_Complete>();
            foreach(int fav in favorites) {
                favProducts.Add(await this.service.GetProductCompleteAsync(fav));
            }
            return View(favProducts);
        }
    }
}
