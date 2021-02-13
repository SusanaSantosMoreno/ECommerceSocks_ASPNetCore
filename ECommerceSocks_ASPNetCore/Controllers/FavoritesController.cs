using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class FavoritesController : Controller {

        private IRepositoryEcommerce_socks repository;
        private CachingService cachingService;

        public FavoritesController (IRepositoryEcommerce_socks repo, CachingService caching) {
            this.repository = repo;
            this.cachingService = caching;
        }

        public IActionResult Index (int? disfav) {
            List<int> favorites = new List<int>();
            if(disfav != null) {
                favorites = this.cachingService.removeFavoriteCache((int)disfav);
            } else {
                favorites = this.cachingService.getFavoritesCache();
            }
            
            List<Product_Complete> favProducts = new List<Product_Complete>();
            foreach(int fav in favorites) {
                favProducts.Add(this.repository.GetProduct_Complete(fav));
            }
            return View(favProducts);
        }
    }
}
