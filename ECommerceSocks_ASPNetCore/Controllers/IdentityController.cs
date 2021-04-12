using ECommerceSocks_ASPNetCore.Filters;
using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Repositories;
using ECommerceSocks_ASPNetCore.Services;
using EcommerceSocksAPI.Models;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    [UsersAuthorize]
    public class IdentityController : Controller {

        Ecommerce_socksService service;
        CachingService cachingService;

        public IdentityController(Ecommerce_socksService APIservice, CachingService service) { 
            this.service = APIservice;
            this.cachingService = service;
        }

        public IActionResult Index (int? clicked, int? address_deleted, int? disfav) {
            ViewData["Clicked"] = clicked == null ? "1" : clicked.ToString();
            if(address_deleted != null) {
                this.service.DeleteAddressAsync((int)address_deleted);
            }
            if(disfav != null) {
                this.cachingService.RemoveFavoriteCache((int)disfav);
            }
            return View();
        }

        public async Task<IActionResult> OrderDetails (int order_id) {
            Orders order = await this.service.GetOrderByIdAsync(order_id);
            List<Order_details> order_Details = await this.service.GetOrderDetailsAsync(order_id);
            List<Product_Complete> products = new List<Product_Complete>();
            List<Product_sizes> sizes = new List<Product_sizes>();
            float finalPrice = 0;
            foreach (Order_details od in order_Details) {
                Product_Complete product = await this.service.GetProductCompleteAsync(od.Product_id);
                products.Add(product);
                sizes.Add(await this.service.GetProduct_SizesByProductSizeAsync(od.Product_id, od.Size_id));
                finalPrice += (float)product.Product_price;
            }
            ViewData["order_details"] = order_Details;
            ViewData["products"] = products;
            ViewData["sizes"] = sizes;
            ViewData["finalPrice"] = finalPrice.ToString();
            return View(order);
        }

        public async Task<IActionResult> GetOrdersPartial () {
            List<Orders> orders = await this.service.GetOrdersAsync(
                int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString()));
            return PartialView("_OrdersPartial", orders);
        }

        public async Task<IActionResult> PersonalInfo () {
            Users user = await this.service.GetUserAsync(
                int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString()));

            return View(user);
        }

        [HttpPost]
        public async Task<IActionResult> PersonalInfo (String firstName, String lastName, String nationality, 
            String phone, DateTime birthDate, String gender) {
            int userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString());
            this.service.EditUserAsync(userId, firstName, lastName, "", "", nationality, phone, birthDate, gender, "");
            Users user = await this.service.GetUserAsync(userId);
            return View(user);
        }

        public async Task<IActionResult> GetWishlistPartial () {
            List<int> favorites = this.cachingService.getFavoritesCache();
            List<Product_Complete> productsFavorites = new List<Product_Complete>();
            foreach (int fav in favorites) {
                productsFavorites.Add(await this.service.GetProductCompleteAsync(fav));
            }
            return PartialView("_OrderWishlistPartial", productsFavorites);
        }

        public async Task<IActionResult> LogOut (bool? logout) {
            int userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString());
            if (logout == null) {
                return PartialView("_UserLogoutPartial");
            } else {
                List<int> favorites = this.cachingService.getFavoritesCache();
                this.service.DeleteFavoriteAsync(userId);
                
                foreach (int fav in favorites) {
                    this.service.AddFavoriteAsync(fav, userId);
                }
                this.cachingService.CleanFavoritesCache();
                await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
                return RedirectToAction("Index", "Home");
            }
        }

        public IActionResult UserPersonalInfo () {
            return PartialView("_UserPersonalInfoPartial");
        }

        public async Task<IActionResult> UserAddresses () {
            int user_id = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString());
            List<Addresses> addreses = await this.service.GetAddressesByUserAsync(user_id);
            return PartialView("_UserAddressesPartial", addreses);
        }

        public async Task<IActionResult> EditAddresses (int? address_id) {
            if(address_id != null) {
                Addresses address = await this.service.GetAddressAsync((int)address_id);
                return View(address);
            } else {
                return View();
            }
        }

        [HttpPost]
        public async Task<IActionResult> EditAddresses (int? address_id, String name, String street, String cp, 
                String country, String city, String province) {
            int userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString());
            if(address_id != null) {
                this.service.EditAddressAsync((int)address_id, userId, name, street, cp, country, province, city);
            } else {
                this.service.AddAddressAsync(userId, userId, name, street, cp, country, province, city);
                List<Addresses> addreses = await this.service.GetAddressesByUserAsync(userId);
            }

            return RedirectToAction("Index", new { clicked = 4 });
        }
    }
}
