using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class Product
    {
        public Product() { }
        public int Id { get; set; }
        public string Name { get; set; }
        public float PriceImport { get; set; }
        public float PriceSale { get; set; }
        public float Quantity { get; set; }
        public string Image { get; set; }
        public Category Cate { get; set; }
        public Status St { get; set; }
    }
}