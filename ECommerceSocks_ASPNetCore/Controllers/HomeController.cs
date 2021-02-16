using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class HomeController : Controller {

        private IRepositoryEcommerce_socks repository;
        private CachingService cachingService;
        private PathProvider pathProvider;
        private MailService mailService;

        public HomeController(IRepositoryEcommerce_socks repo, CachingService caching,
            PathProvider provider, MailService mail) {
            this.repository = repo;
            this.cachingService = caching;
            this.pathProvider = provider;
            this.mailService = mail;
        }

        // GET HOME
        public IActionResult Index (int? favorite) {
            if(favorite != null) {
                this.cachingService.saveFavoritesCache((int)favorite);
            }
            List<Product_Complete> lastProduct = this.repository.GetFirstProduct_Complete(12);
            List<Category> categories = this.repository.GetCategories();
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
