using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.ViewComponents {
    public class CartViewComponent : ViewComponent {

        IRepositoryEcommerce_socks repository;

        public CartViewComponent(IRepositoryEcommerce_socks repo) {
            this.repository = repo;
        }

        public async Task<IViewComponentResult> InvokeAsync () {
            List<Cart> cart = null;
            if (this.HttpContext.Session.GetString("SesionCart") != null) {
                cart = JsonConvert.DeserializeObject<List<Cart>>(this.HttpContext.Session.GetString("SesionCart"));
            }
            return View(cart);
        }
        /*
        [HttpPost]
        public async Task<IViewComponentResult> InvokeAsync (int product_id, int amount) {
            //change session data
            List<Cart> cartList = null;
            if (this.HttpContext.Session.GetString("SesionCart") != null) {
                cartList = JsonConvert.DeserializeObject<List<Cart>>(this.HttpContext.Session.GetString("SesionCart"));
            }
            foreach(Cart cart in cartList) {
                if (cart.Product.Product_id == product_id) {
                    cart.Amount = amount;
                }
            }
            this.HttpContext.Session.SetString("SesionCart", JsonConvert.SerializeObject(cartList));
            return View();
        }*/
    }
}
