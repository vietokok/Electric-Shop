using Project_PRN292_Group5.Entity;
using Project_PRN292_Group5.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_PRN292_Group5.UI.Shop
{
    public partial class Index : System.Web.UI.Page
    {
        ProductDAO pdao = null;
        CustomerDAO cdao = null;
        ExportBillDAO edao = null;
        private int NumProductInPage = 14;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["check"] == null)
            {
                cdao = new CustomerDAO();
                LoadProduct("");
                Session["listCustomer"] = cdao.GetCustomer("");
            }
            else
            {
                if (Request.Form["key"] != null)
                {
                    SearchProductByKeyWord();
                    return;
                }
                if (Request.Form["productId"] != null)
                {
                    AddProductToCart();
                    return;
                }
                if (Request.Form["delete"] != null)
                {
                    DeleteCart();
                    return;
                }
                if (Request.Form["name"] != null)
                {
                    AddCus();
                    return;
                }
                if (Request.Form["searchCus"] != null)
                {
                    SearchCusByName();
                    return;
                }
                if (Request.Form["frmDiscount"] != null)
                {
                    FromDiscount();
                    return;
                }
                if (Request.QueryString["pageChoose"] != null)
                {
                    string keyword = (string)Session["key"];
                    LoadProduct(keyword);
                    return;
                }
                if (Request.Form["checkout"] != null)
                {
                    checkOut();
                    return;
                }
            }
        }
        //tìm sản phẩm theo tên
        void SearchProductByKeyWord()
        {
            string keyword = (string)Request.Form["key"];
            Session["key"] = keyword;
            LoadProduct(keyword);
        }
        //thêm sản phẩm vào giỏ hàng
        void AddProductToCart()
        {
            string rawId = (string)Request.Form["productId"];
            ExportBill eb = (ExportBill)Session["cart"];
            if (eb == null)
            {
                eb = new ExportBill();
            }
            int productId = Convert.ToInt32(rawId);
            pdao = new ProductDAO();
            Product p = pdao.GetProductById(productId);
            int indexExisting = -1;
            for (int i = 0; i < eb.Lines.Count; i++)
            {
                DetailExportBill detail = eb.Lines[i];
                if (p.Id == detail.Product.Id)
                {
                    indexExisting = i;
                    break;
                }
            }
            if (indexExisting != -1)
            {
                DetailExportBill detail = eb.Lines[indexExisting];
                detail.Quantity = (detail.Quantity + 1);
            }
            else
            {
                DetailExportBill detail = new DetailExportBill();
                detail.Product = p;
                detail.ExportBill = eb;
                detail.ToTalPrice = p.PriceSale;
                detail.Quantity = 1;
                detail.Discount = 0;
                eb.Lines.Add(detail);
            }
            Session["cart"] = eb;
        }
        //Load sản phẩm tử database
        void LoadProduct(string keyword)
        {
            ProductDAO dao = new ProductDAO();
            int pageCurrent;
            if (Request.QueryString["pageChoose"] == null)
            {
                pageCurrent = 1;
            }
            else
            {
                String rawPage = Request.QueryString["pageChoose"];
                pageCurrent = Convert.ToInt32(rawPage);
            }
            Session["totalPage"] = dao.getNumberPage(NumProductInPage, keyword);
            Session["listProducts"] = dao.GetListProductSearch(NumProductInPage, pageCurrent, keyword);
            Session["pageCurrent"] = pageCurrent;
        }
        //xóa hoặc giảm số lượng sản phẩm từ cart
        void DeleteCart()
        {
            string delete = (string)Request.Form["delete"];
            ExportBill eb = (ExportBill)Session["cart"];
            string rawDeleteId = (string)Request.Form["id"];
            int deleteId = Convert.ToInt32(rawDeleteId);
            for (int i = 0; i < eb.Lines.Count; i++)
            {
                DetailExportBill detail = eb.Lines[i];
                if (deleteId == detail.Product.Id)
                {
                    if (detail.Quantity > 1)
                    {
                        detail.Quantity = (detail.Quantity - 1);
                        detail.Discount = 0;
                    }
                    else
                    {
                        eb.Lines.RemoveAt(i);
                    }
                    break;
                }
            }
            Session["cart"] = eb;
        }
        //thêm khách hàng mới
        void AddCus()
        {
            string cusName = (string)Request.Form["name"];
            string address = (string)Request.Form["address"];
            string note = (string)Request.Form["note"];
            string phone = (string)Request.Form["phone"];
            cdao = new CustomerDAO();
            cdao.AddCustomer(cusName, address, phone, note);
            Session["listCustomer"] = cdao.GetCustomer("");
        }
        //tìm khách hàng theo tên
        void SearchCusByName()
        {
            string searchCus = (string)Request.Form["searchCus"];
            string searchCusName = (string)Request.Form["partCusName"];
            cdao = new CustomerDAO();
            Session["listCustomer"] = cdao.GetCustomer(searchCusName);
            Session["searchCus"] = searchCusName;
        }
        //giảm giá
        void FromDiscount()
        {
            string frmDiscount = Request.Form["frmDiscount"];
            int index = Convert.ToInt32(frmDiscount);
            ExportBill eb = (ExportBill)Session["cart"];
            string rawValueDiscount = Request.Form["valueDiscount"];
            float valueDiscount = Convert.ToSingle(rawValueDiscount);
            eb.Lines[index].Discount = (eb.Lines[index].ToTalPrice * eb.Lines[index].Quantity * valueDiscount) / 100;
            Session["cart"] = eb;
        }
        void checkOut()
        {
            ExportBill eb = (ExportBill)Session["cart"];
            eb.Note = Request.Form["note"];
            Staff staff = new Staff
            {
                ID = (string)Session["Name"]
            };
            Customer cus = new Customer();
            cus.ID = Convert.ToInt32(Request.Form["cusName"]);
            eb.Staff = staff;
            eb.Customer = cus;
            edao = new ExportBillDAO();           
            edao.insert(eb);
            eb = new ExportBill();
            Session["cart"] = eb;
        }
    }
}