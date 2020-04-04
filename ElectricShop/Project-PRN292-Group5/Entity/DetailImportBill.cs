using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class DetailImportBill
    {
        Product product;
        ImportBill importBill;
        double quantity;
        double priceAitem;
        double totalPrice;

        public Product Product { get => product; set => product = value; }
        public ImportBill ImportBill { get => importBill; set => importBill = value; }
        public double Quantity { get => quantity; set => quantity = value; }
        public double PriceAitem { get => priceAitem; set => priceAitem = value; }
        public double TotalPrice { get => totalPrice; set => totalPrice = value; }
    }
}