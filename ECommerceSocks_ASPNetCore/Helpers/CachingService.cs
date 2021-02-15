using ECommerceSocks_ASPNetCore.Models;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Helpers {
    public class CachingService {

        public IMemoryCache memoryCache;

        public CachingService(IMemoryCache cache) { this.memoryCache = cache; }

        public void saveFavoritesCache (int productId) {
            List<int> favorites = new List<int>();
            if (this.memoryCache.Get("Favorites") != null) {
                favorites = ToolkitService.DeserializeJsonObject<List<int>>
                    (this.memoryCache.Get("Favorites").ToString());
            }
            favorites.Add(productId);
            this.memoryCache.Set("Favorites", ToolkitService.SerializeJsonObject(favorites));
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
            this.memoryCache.Set("Favorites", ToolkitService.SerializeJsonObject(favorites));
            return favorites;
        }

        public void CleanFavoritesCache () {
            this.memoryCache.Remove("Favorites");
        }

        public void SaveCartCache(int product_id, int size_id, int amount) {
            List<Cart> cart = new List<Cart>();
            if (this.memoryCache.Get("Cart") != null) {
                cart = ToolkitService.DeserializeJsonObject<List<Cart>>
                    (this.memoryCache.Get("Cart").ToString());
            }
            cart.Add(new Cart(product_id, size_id, amount));
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
        }
    }
}
