using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CategorySectionController : Controller {

        private Ecommerce_socksRepository repository;

        public CategorySectionController (Ecommerce_socksRepository repo) {
            this.repository = repo;
        }

        public IActionResult Index(int category_id, int? subcategory_id) {
            List<Product_Complete> products = repository.GetProduct_CompletesByCategory(category_id);
            Category category = this.repository.GetCategory(category_id);
            ViewData["Category"] = category;
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
