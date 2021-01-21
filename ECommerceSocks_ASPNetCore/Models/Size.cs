using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace ECommerceSocks_ASPNetCore.Models {
    [Table("Size")]
    public class Size {

        [Key]
        [Column("Size_id")]
        public int Size_id { get; set; }
        [Column("Size_US")]
        public String Size_US { get; set; }
        [Column("Size_EUR")]
        public String Size_EUR { get; set; }
        [Column("Size_UK")]
        public String Size_UK { get; set; }

        public Size() {}

        public Size( int size_id, string size_US, 
            string size_EUR, string size_UK ) {
            Size_id = size_id;
            Size_US = size_US;
            Size_EUR = size_EUR;
            Size_UK = size_UK;
        }
    }
}
