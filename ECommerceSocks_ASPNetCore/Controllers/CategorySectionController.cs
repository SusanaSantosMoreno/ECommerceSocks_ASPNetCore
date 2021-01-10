using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class CategorySectionController : Controller {
        public IActionResult Index() {
            return View();
        }
    }
}
