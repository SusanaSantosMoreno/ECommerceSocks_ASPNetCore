using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Routing;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Filters {
    public class UsersAuthorizeAttribute : AuthorizeAttribute, IAuthorizationFilter {
        public void OnAuthorization (AuthorizationFilterContext context) {
            var user = context.HttpContext.User;
            if(user.Identity.IsAuthenticated == false) {
                ITempDataProvider provider = (ITempDataProvider)
                    context.HttpContext.RequestServices.GetService(typeof(ITempDataProvider));
                var TempData = provider.LoadTempData(context.HttpContext);
                String action = context.RouteData.Values["action"].ToString();
                String controller = context.RouteData.Values["controller"].ToString();
                TempData["action"] = action;
                TempData["controller"] = controller;
                provider.SaveTempData(context.HttpContext, TempData);
                context.Result = this.GetRoute("Login", "User");
            }
        }

        public RedirectToRouteResult GetRoute(string action,string controller) {
            RouteValueDictionary route = new RouteValueDictionary(new {
                action = action,
                controller = controller
            });
            RedirectToRouteResult result = new RedirectToRouteResult(route);
            return result;
        }
    }
}
