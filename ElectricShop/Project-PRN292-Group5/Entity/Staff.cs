using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class Staff
    {
        public Staff() { }
        public string ID { get; set; }
        public string Name { get; set; }
        public Account Account { get; set; }
        public string Date { get; set; }
        public string Gender { get; set; }
        public string Address { get; set; }
        public string Note { get; set; }
    }
}