using ECommerceSocks_ASPNetCore.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Helpers {
    public class CachingService {

        public IMemoryCache memoryCache;
        private IHttpContextAccessor httpContext;

        public CachingService(IMemoryCache cache, IHttpContextAccessor http) {
            this.memoryCache = cache;
            this.httpContext = http;
        }

        public void saveFavoritesCache (int productId) {
            if(this.IsFavorite(productId) == false) {
                List<int> favorites = new List<int>();
                int favs = 0;
                if (this.memoryCache.Get("Favorites") != null) {
                    favorites = ToolkitService.DeserializeJsonObject<List<int>>
                        (this.memoryCache.Get("Favorites").ToString());
                }
                favorites.Add(productId);
                favs += favorites.Count;
                httpContext.HttpContext.Session.SetInt32("favs", favs);
                this.memoryCache.Set("Favorites", ToolkitService.SerializeJsonObject(favorites));
            }
        }    

        public bool IsFavorite(int productId) {
            bool isfav = false;
            List<int> favorites = new List<int>();
            if (this.memoryCache.Get("Favorites") != null) {
                favorites = ToolkitService.DeserializeJsonObject<List<int>>
                    (this.memoryCache.Get("Favorites").ToString());
            }
            foreach(int fav in favorites) {
                if(fav == productId) {
                    isfav = true;
                    break;
                }
            }
            return isfav;
        }

        public List<int> getFavoritesCache () {
            List<int> favorites = new List<int>();
            if (this.memoryCache.Get("Favorites") != null) {
                favorites = ToolkitService.DeserializeJsonObject<List<int>>
                    (this.memoryCache.Get("Favorites").ToString());
            }
            return favorites;
        }

        public List<int> RemoveFavoriteCache(int productId) {
            List<int> favorites = new List<int>();
            if (this.memoryCache.Get("Favorites") != null) {
                favorites = ToolkitService.DeserializeJsonObject<List<int>>
                    (this.memoryCache.Get("Favorites").ToString());
            }
            favorites.RemoveAll(x => x == productId);
            httpContext.HttpContext.Session.SetInt32("favs", favorites.Count);
            this.memoryCache.Set("Favorites", ToolkitService.SerializeJsonObject(favorites));
            return favorites;
        }

        public void CleanFavoritesCache () {
            this.memoryCache.Remove("Favorites");
            httpContext.HttpContext.Session.Remove("favs");
        }

        public void SaveCartCache(int product_id, int size_id, int amount) {
            List<Cart> cart = new List<Cart>();
            if (this.memoryCache.Get("Cart") != null) {
                cart = ToolkitService.DeserializeJsonObject<List<Cart>>
                    (this.memoryCache.Get("Cart").ToString());
            }
            cart.Add(new Cart(product_id, size_id, amount));
            httpContext.HttpContext.Session.SetInt32("cartItems", cart.Count);
            this.memoryCache.Set("Cart", ToolkitService.SerializeJsonObject(cart));
        }

        public List<Cart> GetCartCache () {
            List<Cart> cart = new List<Cart>();
            if (this.memoryCache.Get("Cart") != null) {
                cart = ToolkitService.DeserializeJsonObject<List<Cart>>
                    (this.memoryCache.Get("Cart").ToString());
            }
            return cart;
        }

        public List<Cart> RemoveCartCache(int product_id, int size_id) {
            List<Cart> cart = new List<Cart>();
            if (this.memoryCache.Get("Cart") != null) {
                cart = ToolkitService.DeserializeJsonObject<List<Cart>>
                    (this.memoryCache.Get("Cart").ToString());
            }
            cart.RemoveAll(x => x.Product_id == product_id && x.Size_id == size_id);
            httpContext.HttpContext.Session.SetInt32("cartItems", cart.Count);
            this.memoryCache.Set("Cart", ToolkitService.SerializeJsonObject(cart));
            return cart;
        }

        public List<Cart> EditCartCache(int product_id, int size_id) {
            List<Cart> cart = this.GetCartCache();
            foreach(Cart c in cart) {
                if(c.Product_id == product_id && c.Size_id == size_id) {
                    //si existe aumentamos su cantidad
                    c.Amount = c.Amount + 1;
                }
            }
            this.memoryCache.Set("Cart", ToolkitService.SerializeJsonObject(cart));
            return cart;
        }

        public List<Cart> EditCartCache (int product_id, int size_id, int amount) {
            List<Cart> cart = this.GetCartCache();
            foreach (Cart c in cart) {
                if (c.Product_id == product_id && c.Size_id == size_id) {
                    //si existe aumentamos su cantidad
                    c.Amount = amount;
                }
            }
            this.memoryCache.Set("Cart", ToolkitService.SerializeJsonObject(cart));
            return cart;
        }

        public void CleanCartCache () {
            this.memoryCache.Remove("Cart");
            httpContext.HttpContext.Session.Remove("cartItems");
        }
    }
}
