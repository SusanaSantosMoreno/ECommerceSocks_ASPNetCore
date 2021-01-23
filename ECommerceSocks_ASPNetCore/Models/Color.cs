using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    public class Color {

        public String Color_name { get; set; }

        public Color (string color_name) {
            this.Color_name = color_name;
        }
    }
}
