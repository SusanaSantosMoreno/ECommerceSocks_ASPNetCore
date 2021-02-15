using ECommerceSocks_ASPNetCore.Filters;
using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
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

        IRepositoryEcommerce_socks repository;
        CachingService cachingService;

        public IdentityController(IRepositoryEcommerce_socks repo,
            CachingService service) { 
            this.repository = repo;
            this.cachingService = service;
        }

        public IActionResult Index (int? clicked) {
            ViewData["Clicked"] = clicked == null ? "1" : clicked.ToString();
            return View();
        }

        public IActionResult OrderDetails (int order_id) {
            Orders order = this.repository.GetOrdersById(order_id);
            List<Order_details> order_Details = this.repository.GetOrder_Detail(order_id);
            List<Product_Complete> products = new List<Product_Complete>();
            List<Product_sizes> sizes = new List<Product_sizes>();
            float finalPrice = 0;
            foreach (Order_details od in order_Details) {
                Product_Complete product = this.repository.GetProduct_Complete(od.Product_id);
                products.Add(product);
                sizes.Add(this.repository.GetProduct_Size_View(od.Product_id, od.Size_id));
                finalPrice += (float)product.Product_price;
            }
            ViewData["order_details"] = order_Details;
            ViewData["products"] = products;
            ViewData["sizes"] = sizes;
            ViewData["finalPrice"] = finalPrice.ToString();
            return View(order);
        }

        public IActionResult GetOrdersPartial () {
            List<Orders> orders = this.repository.GetOrders(
                int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString()));
            return PartialView("_OrdersPartial", orders);
        }

        public IActionResult PersonalInfo () {
            Users user = this.repository.GetUser(
                int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString()));

            return View(user);
        }

        [HttpPost]
        public IActionResult PersonalInfo (String firstName, String lastName, String nationality, 
            String phone, DateTime birthDate, String gender) {
            int userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString());
            this.repository.EditUser(userId, firstName, lastName, nationality, phone, birthDate, gender);
            Users user = this.repository.GetUser(userId);
            return View(user);
        }

        public IActionResult GetWishlistPartial () {
            List<Favorite> favorites = this.repository.
                GetFavorites(int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString()));
            List<Product_Complete> productsFavorites = new List<Product_Complete>();
            foreach(Favorite fav in favorites) {
                productsFavorites.Add(this.repository.GetProduct_Complete(fav.Favorite_product));
            }
            return PartialView("_OrderWishlistPartial", productsFavorites);
        }

        public async Task<IActionResult> LogOut (bool? logout) {
            int userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString());
            if (logout == null) {
                return PartialView("_UserLogoutPartial");
            } else {
                /*List<int> favorites = this.cachingService.getFavoritesCache();
                foreach (int fav in favorites) {
                    this.repository.AddFavorite(fav, userId);
                }
                this.cachingService.CleanFavoritesCache();*/
                await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
                return RedirectToAction("Index", "Home");
            }
        }

        public IActionResult UserPersonalInfo () {
            return PartialView("_UserPersonalInfoPartial");
        }

        public IActionResult UserAddresses () {
            int user_id = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value.ToString());
            List<Addresses> addreses = this.repository.GetAddresses(user_id);
            return PartialView("_UserAddressesPartial", addreses);
        }
    }
}
