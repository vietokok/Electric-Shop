using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class DetailExportBill
    {
        public DetailExportBill() { }
        public ExportBill ExportBill { get; set; }
        public Product Product { get; set; }
        public float Quantity { get; set; }
        public float ToTalPrice { get; set; }
        public float Discount { get; set; }
    }
}