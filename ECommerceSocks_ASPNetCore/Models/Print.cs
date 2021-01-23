using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    public class Print {

        public String Print_name { get; set; }

        public Print (string print_name) {
            this.Print_name = print_name;
        }
    }
}
