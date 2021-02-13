using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class IdentityController : Controller {
        public IActionResult Index () {
            return View();
        }

        public IActionResult GetOrdersPartial () {
            return PartialView("_OrdersPartial");
        }

        public IActionResult GetOrderDetailsPartial (int? orderId) {
            return PartialView("_OrderDetailsPartial");
        }

        public IActionResult GetWishlistPartial () {
            return PartialView("_OrderWishlistPartial");
        }

        public IActionResult LogOut (bool? logout) {
            if(logout == null) {
                return PartialView("_UserLogoutPartial");
            } else {
                return RedirectToAction("Index", "Home");
            }
        }

        public IActionResult UserPersonalInfo () {
            return PartialView("_UserPersonalInfoPartial");
        }

        public IActionResult UserAddresses () {
            return PartialView("_UserAddressesPartial");
        }
    }
}
