﻿using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CategorySectionController : Controller {

        private IRepositoryEcommerce_socks repository;
        private IMemoryCache memoryCache;

        public CategorySectionController (IRepositoryEcommerce_socks repo, IMemoryCache memoryCache) {
            this.repository = repo;
            this.memoryCache = memoryCache;
        }

        public IActionResult Index(int category_id, int? subcategory_id) {
            List<Product_Complete> products = repository.GetProduct_CompletesByCategory(category_id);
            Category category = this.repository.GetCategory(category_id);
            ViewData["Category"] = category;
            List<Subcategory> subcategories = repository.GetSubcategories();
            ViewData["Subcategories"] = subcategories;

            List<String> styles = new List<String>();
            if (this.memoryCache.Get("Styles") == null) {
                styles = this.repository.GetProductsStyles();
                this.memoryCache.Set("Styles", ToolkitService.SerializeJsonObject(styles));
            } else {
                styles = ToolkitService.DeserializeJsonObject<List<String>>(this.memoryCache.Get("Styles").ToString());
            }
            ViewData["Styles"] = styles;
            List<String> print = this.repository.GetProductsPrint();
            ViewData["Print"] = print;
            List<String> color = this.repository.GetProductColor();
            ViewData["Color"] = color;
            return View(products);
        }

        [HttpPost]
        public IActionResult Index(int category_id, int subcategory_id, List<String> stylesFilter, 
            List<String> printsFilter, List<String> colorsFilter) {

            List<Product_Complete> products = repository.FilterProduct_Completes(category_id, subcategory_id, 
                stylesFilter, printsFilter, colorsFilter);

            List<Subcategory> subcategories = repository.GetSubcategories();
            ViewData["Subcategories"] = subcategories;
            List<String> styles = this.repository.GetProductsStyles();
            ViewData["Styles"] = styles;
            List<String> print = this.repository.GetProductsPrint();
            ViewData["Print"] = print;
            List<String> color = this.repository.GetProductColor();
            ViewData["Color"] = color;
            return View(products);
        }
    }
}
