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
                loadProduct("");
            }
            else
            {
                if (Request["detail"] != null)
                {
                    ViewDetailOrder();

                }

                if (Request.Form["key"] != null || Request.Form["begin"] != null)
                {
                    SearchProductByKeyWord();
                    return;
                }

                if (Request.QueryString["pageChoose"] != null)
                {
                    string keyword = (string)Session["key"];                   
                    loadProduct(keyword);
                    return;
                }
            }


        }

        void SearchProductByKeyWord()
        {
            string keyword = (string)Request.Form["key"];
            if (keyword != null && keyword.Length !=0)
            {               
                loadProduct(keyword);
            }
            else
            {
                string begin = (string)Request.Form["begin"];

                string[] xbegin = begin.Split('-');
                begin = xbegin[1] + "-" + xbegin[2] + "-" + xbegin[0];

                string end = (string)Request.Form["end"];

                string[] xend = end.Split('-');
                end = xend[1] + "-" + xend[2] + "-" + xend[0];

                loadProduct1(begin, end);
            }
        }

        public void loadProduct(string key)
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
            Session["listOrder"] = bDAO.GetExportBill(numberInPage, pageCurrent, key);
            Session["pageCurrent"] = pageCurrent;

        }

        public void loadProduct1(string begin,string end)
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
            Session["totalPage"] = bDAO.getNumberPage1(numberInPage, begin,end);
            Session["listOrder"] = bDAO.GetExportBill1(numberInPage, pageCurrent, begin,end);
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