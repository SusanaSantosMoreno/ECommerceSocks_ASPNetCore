using ECommerceSocks_ASPNetCore.Filters;
using ECommerceSocks_ASPNetCore.Helpers;
using EcommerceSocksAPI.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Services;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CheckoutController : Controller {

        Ecommerce_socksService service;
        CachingService cachingService;

        public CheckoutController (Ecommerce_socksService service, CachingService caching) {
            this.service = service;
            this.cachingService = caching;
        }

        [UsersAuthorize]
        public async Task<IActionResult> Index (int? done) {
            List<Cart> cart = this.cachingService.GetCartCache();
            List<Cart_Complete> cartComplete = new List<Cart_Complete>();
            Users user = await this.service.GetUserAsync(
                    int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString()));
            List<Addresses> addresses = await this.service.GetAddressesByUserAsync(user.Users_id);
            
            foreach (Cart c in cart) {
                 cartComplete.Add(new Cart_Complete(await this.service.GetProductCompleteAsync(c.Product_id),
                       await this.service.GetProduct_SizesByProductSizeAsync(c.Product_id, c.Size_id), c.Amount));
            }
            ViewData["cart"] = cartComplete;
            ViewData["addresses"] = addresses;
            
            if (done != null) {
                 Orders order = await this.service.AddOrderAsync(user.Users_id, DateTime.Now);
                 foreach(Cart c in cart) {
                     this.service.AddOrderDetailsAsync(order.Orders_id, c.Product_id, c.Size_id, c.Amount);
                 }
                 this.cachingService.CleanCartCache();
                 return RedirectToAction("Index", "Home");
            }
            return View(user);
        }
    }
}
