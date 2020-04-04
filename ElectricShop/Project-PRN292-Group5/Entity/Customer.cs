using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class Customer
    {
        public Customer() { }
        public int ID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public string Note { get; set; }
    }
}