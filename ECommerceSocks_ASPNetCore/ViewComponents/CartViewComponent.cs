﻿using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.ViewComponents {
    public class CartViewComponent : ViewComponent {
        public async Task<IViewComponentResult> InvokeAsync () {
            return View();
        }
    }
}
