using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class HomeController : Controller {

        private Ecommerce_socksRepository repository;

        public HomeController( Ecommerce_socksRepository repo ) {
            this.repository = repo;
        }

        // GET HOME
        public IActionResult Index () {
            List<Product> lastProduct = this.repository.GetFirstProduct(9);
            List<Category> categories = this.repository.GetCategories();
            ViewData ["Categories"] = categories;
            return View(lastProduct);
        }
    }
}
