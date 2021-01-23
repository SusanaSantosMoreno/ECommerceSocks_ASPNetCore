using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    public class Style {

        public String Style_name { get; set; }

        public Style (string style_name) {
            this.Style_name = style_name;
        }
    }
}
