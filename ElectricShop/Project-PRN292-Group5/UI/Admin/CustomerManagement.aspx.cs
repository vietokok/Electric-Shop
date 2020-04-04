using Project_PRN292_Group5.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_PRN292_Group5.UI.Admin
{
    public partial class CustomerManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CustomerDAO cdao = new CustomerDAO();
            Session["listCustomer"] = cdao.getAllCustomer();
            if (Request.Form["addCus"] != null)
            {
                AddCus();
                return;
            }
            if (Request.Form["deleteCus"] != null)
            {
                deleteCus();
                return;
            }
        }
        void AddCus()
        {
            CustomerDAO cdao = new CustomerDAO();
            string cusName = (string)Request.Form["name"];
            string address = (string)Request.Form["address"];
            string note = (string)Request.Form["note"];
            string phone = (string)Request.Form["phone"];
            cdao = new CustomerDAO();
            cdao.AddCustomer(cusName, address, phone, note);
            Session["listCustomer"] = cdao.getAllCustomer();
        }
        void deleteCus()
        {
            CustomerDAO cDAO = new CustomerDAO();
            string id = (string)Request.Form["id"];
            cDAO.DeleteCustomerByID(id);
            Session["listCustomer"] = cDAO.getAllCustomer();
        }
    }
}