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

        public List<int> removeFavoriteCache(int productId) {
            List<int> favorites = new List<int>();
            if (this.memoryCache.Get("Favorites") != null) {
                favorites = ToolkitService.DeserializeJsonObject<List<int>>
                    (this.memoryCache.Get("Favorites").ToString());
            }
            favorites.RemoveAll(x => x == productId);
            this.memoryCache.Set("Favorites", ToolkitService.SerializeJsonObject(favorites));
            return favorites;
        }
    }
}
