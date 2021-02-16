using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Data;
using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;

namespace ECommerceSocks_ASPNetCore {
    public class Startup {

        IConfiguration configuration { get; set; }

        public Startup(IConfiguration configuration ) {
            this.configuration = configuration;
        }
       
        public void ConfigureServices (IServiceCollection services) {
            String cadena = configuration.GetConnectionString("EcommerceSocks_Azure");
            services.AddTransient<IRepositoryEcommerce_socks, Ecommerce_socksRepository>();
            services.AddDbContext<Ecommerce_socksContext>(options => options.UseSqlServer(cadena));
            services.AddSingleton<PathProvider>();
            services.AddSingleton<CachingService>();


            /*TEMPDATA*/
            services.AddSingleton<ITempDataProvider, CookieTempDataProvider>();

            /*AUTHENTICATION*/
            services.AddAuthentication(options => {
                options.DefaultAuthenticateScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                options.DefaultChallengeScheme = CookieAuthenticationDefaults.AuthenticationScheme;
                options.DefaultSignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
            }).AddCookie();

            /*CACHING*/
            services.AddMemoryCache();
            services.AddDistributedMemoryCache();
            services.AddResponseCaching();

            /*SESSION*/
            services.AddHttpContextAccessor();
            services.AddDistributedMemoryCache();
            services.AddSession();

            /*HELPERS*/
            services.AddSingleton<MailService>();

            services.AddControllersWithViews(options => options.EnableEndpointRouting = false).
                AddSessionStateTempDataProvider();
        }

        
        public void Configure (IApplicationBuilder app, IWebHostEnvironment env) {
            if (env.IsDevelopment()) {
                app.UseDeveloperExceptionPage();
            }
            app.UseRouting();
            app.UseStaticFiles();
            app.UseAuthentication();
            app.UseResponseCaching();
            app.UseSession();
            app.UseMvc(routes => {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=Index}"
                );
            });
        }
    }
}
