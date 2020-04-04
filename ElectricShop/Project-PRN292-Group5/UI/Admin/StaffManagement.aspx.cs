using Project_PRN292_Group5.Entity;
using Project_PRN292_Group5.Model;
using ProjectCSharpAdmin.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_PRN292_Group5.UI.Admin
{
    public partial class StaffManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            StaffDAO sDAO = new StaffDAO();
            AccountDAO aDAO = new AccountDAO();
            Session["listStaff"] = sDAO.GetStaff();
            Session["listAccount"] = aDAO.getAllAccount();
            if (Request.Form["addStaff"] != null)
            {
                addStaff();
                return;
            }
            if (Request.Form["delete"] != null)
            {
                deleteStaff();
                return;
            }
            if (Request.Form["editStaff"] != null)
            {
                editStaff();
                return;
            }

        }
        void addStaff()
        {
            string cusID = (string)Request.Form["id"];
            string cusName = (string)Request.Form["name"];
            string cusDate = (string)Request.Form["date"];
            string cusGender = (string)Request.Form["gender"];
            string cusAdress = (string)Request.Form["adress"];
            string cusNote = (string)Request.Form["note"];
            string username = (string)Request.Form["username"];
            string pass = (string)Request.Form["pass"];
            string email = (string)Request.Form["email"];
            int type;
            if (cusID.Equals("admin"))
            {
                type = 1;
            }
            else type = 0;
            AccountDAO aDAO = new AccountDAO();
            List<Account> listAccount = new List<Account>();
            listAccount = aDAO.getAllAccount();
            for (int i = 0; i < listAccount.Count; i++)
            {
                if (listAccount[i].Username.Equals(username))
                {
                    string er = "Tài Khoản Đã Tồn Tại";
                    Session["er"] = er;
                    return;
                }
            }
            aDAO.addAccount(username, pass, type, email);
            StaffDAO sDAO = new StaffDAO();
            sDAO.AddStaff(username, cusName, cusDate, cusGender, cusAdress, cusNote);
            Session["listStaff"] = sDAO.GetStaff();
            Response.Redirect("StaffManagement.aspx");
        }
        void deleteStaff()
        {
            string ID = (string)Request.Form["ID"];

            StaffDAO sDAO = new StaffDAO();
            sDAO.deletaStaff(ID);
            AccountDAO aDAO = new AccountDAO();
            aDAO.deletaAccount(ID);

            Session["listStaff"] = sDAO.GetStaff();
        }
        void editStaff()
        {
            string index = (string)Request.Form["index"];
            string username = (string)Request.Form["ID" + index];
            string name = (string)Request.Form["name" + index];
            string date = (string)Request.Form["date" + index];
            string gender = (string)Request.Form["gender" + index];
            string adress = (string)Request.Form["adress" + index];
            string note = (string)Request.Form["note" + index];


            StaffDAO sDAO = new StaffDAO();

            sDAO.editStaff(name, date, gender, adress, note, username);
            Session["listStaff"] = sDAO.GetStaff();
        }
    }
}