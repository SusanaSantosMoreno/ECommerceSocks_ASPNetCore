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
    public class UserController : Controller {

        IRepositoryEcommerce_socks repository;
        CachingService cachingService;

        public UserController(IRepositoryEcommerce_socks repo, CachingService service) { 
            this.repository = repo;
            this.cachingService = service;
        }

        public IActionResult Login () {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login (String email, String password) {
            Users user = this.repository.GetUser(email, password);
            if(user != null) {
                ClaimsIdentity identity = new ClaimsIdentity
                    (CookieAuthenticationDefaults.AuthenticationScheme,
                    ClaimTypes.Name, ClaimTypes.Role);
                identity.AddClaim(new Claim(ClaimTypes.NameIdentifier, user.Users_id.ToString()));
                identity.AddClaim(new Claim(ClaimTypes.Name, user.Users_name.ToString()));
                ClaimsPrincipal principal = new ClaimsPrincipal(identity);

                await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme,
                    principal, new AuthenticationProperties {
                        IsPersistent = true,
                        ExpiresUtc = DateTime.Now.AddMinutes(20)
                    });
                String action = TempData["action"].ToString();
                String controller = TempData["controller"].ToString();

                //add favorites to database
                /*this.cachingService.CleanFavoritesCache();
                List<Favorite> favorites = this.repository.GetFavorites();
                foreach(Favorite fav in favorites) {
                    this.cachingService.saveFavoritesCache(fav.Favorite_product);
                }*/

                return RedirectToAction(action, controller);
            }
            else{
                return View();
            }
        }

        public IActionResult SignUp () {
            return View();
        }

        [HttpPost]
        public IActionResult SignUp (String email, String name,  String password, String repeatPassword, bool serviceTerms) {
            bool result = this.repository.AddUser(email, name, password, repeatPassword);
            if (result) {
                return RedirectToAction("Login");
            }
            return View("Index", "Home");
        }

        public IActionResult ForgotPassword () {
            return View();
        }
    }
}
