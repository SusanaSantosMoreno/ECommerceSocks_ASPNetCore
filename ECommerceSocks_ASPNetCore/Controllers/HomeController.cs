using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Repositories;
using ECommerceSocks_ASPNetCore.Services;
using EcommerceSocksAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class HomeController : Controller {

        private Ecommerce_socksService service;
        private CachingService cachingService;
        private PathProvider pathProvider;
        private MailService mailService;

        public HomeController(Ecommerce_socksService service, CachingService caching,
            PathProvider provider, MailService mail) {
            this.service = service;
            this.cachingService = caching;
            this.pathProvider = provider;
            this.mailService = mail;
        }

        // GET HOME
        public async Task<IActionResult> Index (int? favorite) {
            if(favorite != null) {
                this.cachingService.saveFavoritesCache((int)favorite);
            }
            List<Product_Complete> lastProduct = await this.service.getfirstproductcom(12);
            List<Category> categories = await this.service.GetCategoriesAsync();
            ViewData ["Categories"] = categories;
            return View(lastProduct);
        }

        [HttpPost]
        public IActionResult Index (String email) {
            String template = 
                this.pathProvider.MapPath("NewsLetter_EmailTemplate.html", "templates\\emailTemplates");
            String text = System.IO.File.ReadAllText(template);
            this.mailService.SendMail(email, "Welcome to our Newsletter!", text);
            return RedirectToAction("Index");
        }
    }
}
