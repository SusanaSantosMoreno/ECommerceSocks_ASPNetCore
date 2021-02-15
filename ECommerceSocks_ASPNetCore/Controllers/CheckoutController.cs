using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CheckoutController : Controller {

        IRepositoryEcommerce_socks repository;
        CachingService cachingService;

        public CheckoutController (IRepositoryEcommerce_socks repo, CachingService caching) {
            this.repository = repo;
            this.cachingService = caching;
        }

        public IActionResult Index (int? done) {
            List<Cart> cart = this.cachingService.GetCartCache();
            Users user = null;
            List<Addresses> addresses = new List<Addresses>();
            List<Cart_Complete> cartComplete = new List<Cart_Complete>();
            if (HttpContext.Session.GetInt32("user") != null) {
                user = this.repository.GetUser((int)HttpContext.Session.GetInt32("user"));
                addresses = this.repository.GetAddresses(user.Users_id);

                foreach (Cart c in cart) {
                    cartComplete.Add(new Cart_Complete(this.repository.GetProduct_Complete(c.Product_id),
                        this.repository.GetProduct_Size_View(c.Product_id, c.Size_id), c.Amount));
                }
                ViewData["cart"] = cartComplete;
                ViewData["addresses"] = addresses;

                if (done != null) {
                    Orders order = this.repository.AddOrder(user.Users_id);
                    foreach(Cart c in cart) {
                        this.repository.AddOrderDetails(order.Orders_id, c.Product_id, c.Size_id, c.Amount);
                    }
                    this.cachingService.CleanCartCache();
                    return RedirectToAction("Index", "Home");
                }
            }
            return View(user);
        }
    }
}
