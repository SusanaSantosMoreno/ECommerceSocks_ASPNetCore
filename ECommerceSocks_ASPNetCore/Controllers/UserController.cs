using ECommerceSocks_ASPNetCore.Helpers;
using EcommerceSocksAPI.Models;
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
using ECommerceSocks_ASPNetCore.Services;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class UserController : Controller {

        Ecommerce_socksService service;
        CachingService cachingService; 
        private PathProvider pathProvider;
        private MailService mailService;

        public UserController(Ecommerce_socksService APIservice, CachingService service
            , PathProvider provider, MailService mail) { 
            this.service = APIservice;
            this.cachingService = service;
            this.pathProvider = provider;
            this.mailService = mail;
        }

        public IActionResult Login () {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Login (String email, String password) {
            Users user = await this.service.GetUserByCredentialsAsync(email, password);
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
                this.cachingService.CleanFavoritesCache();
                List<Favorite> favorites = await this.service.GetUserFavoritesAsync(user.Users_id);
                foreach(Favorite fav in favorites) {
                    this.cachingService.saveFavoritesCache(fav.Favorite_product);
                }

                return RedirectToAction(action, controller);
            }
            else{
                ViewData["Invalid"] = "invalid";
                return View();
            }
        }

        public IActionResult SignUp () {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SignUp (String email, String name,  String password, String repeatPassword, bool serviceTerms) {
            this.service.AddUserAsync(name, "", email, password,"", "", new DateTime(), "M", "");
            String template = this.pathProvider.MapPath("Welcome_EmailTemplate.html", "templates\\emailTemplates");
            String text = System.IO.File.ReadAllText(template);
            this.mailService.SendMail(email, "Welcome to our family!", text);
            return RedirectToAction("Login");
        }

        public async Task<IActionResult> ForgotPassword (String email) {
            Users user = await this.service.GetUserByEmailAsync(email);
            if(user != null) {
                var token = ToolkitService.GenerarToken();
                var link = Url.Action("ResetPassword", "User", new { token, email = email }, Request.Scheme);
                this.mailService.SendMail(email, link);
            }
            return View();
        }

        public async Task<IActionResult> ResetPassword(string token, string email) {
            Users user = await this.service.GetUserByEmailAsync(email);
            return View(user);
        }

        [HttpPost]
        public async Task<IActionResult> ResetPassword (String email, String password, String repeatPassword) {
            if (password.Equals(repeatPassword)) {
                Users user = await this.service.GetUserByEmailAsync(email);
                this.service.SetPasswordAsync(user.Users_id, password);
                return RedirectToAction("Index", "Home");
            }
            return View();
        }
    }
}
