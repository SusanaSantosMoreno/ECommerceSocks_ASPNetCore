﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace ECommerceSocks_ASPNetCore.Controllers {
    public class HomeController : Controller {

        // GET HOME
        public IActionResult Index () {
            return View();
        }
    }
}
