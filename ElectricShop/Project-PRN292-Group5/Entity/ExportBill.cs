using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class ExportBill
    {
        private List<DetailExportBill> lines = new List<DetailExportBill>();
        public ExportBill() { }
        public int ID { get; set; }
        public string Date { get; set; }
        public Staff Staff { get; set; }
        public Customer Customer { get; set; }
        public string Note { get; set; }
        public float TotalPrice1 { get; set; }
        public List<DetailExportBill> Lines { get => lines; set => lines = value; }

        public float TotalPrice()
        {
            float sum = 0;
            foreach (var line in lines)
            {
                sum += line.ToTalPrice * line.Quantity - line.Discount;
            }
            return sum;
        }
    }
}