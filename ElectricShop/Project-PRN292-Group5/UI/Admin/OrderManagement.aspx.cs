using Project_PRN292_Group5.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_PRN292_Group5.UI.Admin
{
    public partial class OrderManagement : System.Web.UI.Page
    {
        ExportBillDAO bDAO = null;
        private int numberInPage = 3;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["check"] == null)
            {
                bDAO = new ExportBillDAO();
                loadProduct("","");
            }
            else
            {
                if (Request["detail"] != null)
                {
                    ViewDetailOrder();

                }

                if (Request.Form["key"] != null)
                {
                    SearchProductByKeyWord();
                    return;
                }

                if (Request.QueryString["pageChoose"] != null)
                {
                    string keyword = (string)Session["key"];
                    string check = (string)Request.Form["check"];
                    loadProduct(keyword,check);
                    return;
                }
            }


        }

        void SearchProductByKeyWord()
        {
            string keyword = (string)Request.Form["key"];
            Session["key"] = keyword;
            string check = (string)Request.Form["check"];
            Session["check"] = check;
            loadProduct(keyword,check);
        }

        public void loadProduct(string key, string sort)
        {
            bDAO = new ExportBillDAO();

            int pageCurrent;
            if (Request.QueryString["pageChoose"] == null)
            {
                pageCurrent = 1;
            }
            else
            {
                string raw_page = Request.QueryString["pageChoose"];
                pageCurrent = Convert.ToInt32(raw_page);
            }
            Session["totalPage"] = bDAO.getNumberPage(numberInPage, key);
            Session["listOrder"] = bDAO.GetExportBill(numberInPage, pageCurrent, key,sort);
            Session["pageCurrent"] = pageCurrent;

        }

        public void ViewDetailOrder()
        {
            string rawId = (string)Request.Form["id"];
            int detailID = Convert.ToInt32(rawId);
            ExportBillDAO exDAO = new ExportBillDAO();
            ExportBill ex = new ExportBill();
            DetailExportBill de = new DetailExportBill();
            Session["detailInfo"] = exDAO.GetExportBillByID(detailID);
            Session["detailOrder"] = exDAO.GetDetailExportBillByID(detailID);
        }
    }
}