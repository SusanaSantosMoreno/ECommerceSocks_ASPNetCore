using ECommerceSocks_ASPNetCore.Models;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class UserController : Controller {

        IRepositoryEcommerce_socks repository;

        public UserController(IRepositoryEcommerce_socks repo) { this.repository = repo; }

        public IActionResult Login () {
            return View();
        }

        [HttpPost]
        public IActionResult Login (String email, String password) {
            Users user = this.repository.GetUser(email, password);
            if(user != null) {
                HttpContext.Session.SetInt32("user", user.Users_id);
                return RedirectToAction("Index", "Home");
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
            return View();
        }

        public IActionResult ForgotPassword () {
            return View();
        }
    }
}
