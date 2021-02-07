using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class AccountController : Controller {
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
    }
}
