using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ECommerceSocks_ASPNetCore.Data;
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
            services.AddTransient<Ecommerce_socksRepository>();
            services.AddDbContext<Ecommerce_socksContext>(options => options.UseSqlServer(cadena));
            services.AddControllersWithViews();
        }

        
        public void Configure (IApplicationBuilder app, IWebHostEnvironment env) {
            if (env.IsDevelopment()) {
                app.UseDeveloperExceptionPage();
            }

            app.UseRouting();
            app.UseStaticFiles();
            app.UseEndpoints(endpoints => {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}");
            });
        }
    }
}
