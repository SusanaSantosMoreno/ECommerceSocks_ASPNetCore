using ECommerceSocks_ASPNetCore.Helpers;
using EcommerceSocksAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Services;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CategorySectionController : Controller {

        private Ecommerce_socksService service;
        private IMemoryCache memoryCache;
        private CachingService cachingService;

        public CategorySectionController (Ecommerce_socksService service, 
            IMemoryCache memoryCache, CachingService caching) {
            this.service = service;
            this.memoryCache = memoryCache;
            this.cachingService = caching;
        }

        public async Task<IActionResult> Index(int category_id, int? subcategory_id, int? favorite,
            String? stylesFilter, String? printsFilter, String? colorsFilter) {

            List<Product_Complete> products =
                await this.service.FilterProductCompleteAsync(category_id, subcategory_id.ToString(), 
                stylesFilter, printsFilter, colorsFilter);

            Category category = await this.service.GetCategoryAsync(category_id);
            ViewData["Category"] = category;
            List<Subcategory> subcategories = await this.service.GetSubcategoriesAsync();
            ViewData["Subcategories"] = subcategories;

            List<String> styles = new List<String>();
            if (this.memoryCache.Get("Styles") == null) {
                styles = await this.service.GetProductsStylesAsync();
                this.memoryCache.Set("Styles", ToolkitService.SerializeJsonObject(styles));
            } else {
                styles = ToolkitService.DeserializeJsonObject<List<String>>(this.memoryCache.Get("Styles").ToString());
            }
            ViewData["Styles"] = styles;
            List<String> print = await this.service.GetProductsPrintAsync();
            ViewData["Print"] = print;
            List<String> color = await this.service.GetProductsColorAsync();
            ViewData["Color"] = color;

            if (favorite != null) {
                this.cachingService.saveFavoritesCache((int)favorite);
            }
            return View(products);
        }

        [HttpPost]
        public async Task<IActionResult> Index(int category_id, int subcategory_id, String? stylesFilter, 
            String? printsFilter, String? colorsFilter) {

            List<Product_Complete> products = await this.service.FilterProductCompleteAsync(category_id, subcategory_id.ToString(), 
                stylesFilter, printsFilter, colorsFilter);

            List<Subcategory> subcategories = await this.service.GetSubcategoriesAsync();
            ViewData["Subcategories"] = subcategories;
            List<String> styles = await this.service.GetProductsStylesAsync();
            ViewData["Styles"] = styles;
            List<String> print = await this.service.GetProductsPrintAsync();
            ViewData["Print"] = print;
            List<String> color = await this.service.GetProductsColorAsync();
            ViewData["Color"] = color;
            return View(products);
        }
    }
}
