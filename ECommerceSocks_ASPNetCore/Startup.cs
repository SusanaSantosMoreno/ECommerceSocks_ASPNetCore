using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Data;
using ECommerceSocks_ASPNetCore.Helpers;
using ECommerceSocks_ASPNetCore.Repositories;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
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

            /*CACHING*/
            services.AddMemoryCache();
            services.AddDistributedMemoryCache();
            services.AddResponseCaching();

            /*SESSION*/
            services.AddDistributedMemoryCache();
            services.AddSession(options => {
                options.IdleTimeout = TimeSpan.FromDays(1);
            });

            /*HELPERS*/
            services.AddSingleton<MailService>();

            services.AddControllersWithViews();
        }

        
        public void Configure (IApplicationBuilder app, IWebHostEnvironment env) {
            if (env.IsDevelopment()) {
                app.UseDeveloperExceptionPage();
            }
            app.UseRouting();
            app.UseStaticFiles();
            app.UseResponseCaching();
            app.UseSession();
            app.UseEndpoints(endpoints => {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}");
            });
        }
    }
}
