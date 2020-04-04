using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class ImportBill
    {
        List<DetailImportBill> listDetailImport = new List<DetailImportBill>();
        int id;
        DateTime importDate;
        Staff staff;
        Suplier suplier;
        double totalPrice;

        public List<DetailImportBill> ListDetailImport { get => listDetailImport; set => listDetailImport = value; }
        public int Id { get => id; set => id = value; }
        public DateTime ImportDate { get => importDate; set => importDate = value; }
        public Staff Staff { get => staff; set => staff = value; }
        public Suplier Suplier { get => suplier; set => suplier = value; }
        public double TotalPrice { get => totalPrice; set => totalPrice = value; }
    }
}