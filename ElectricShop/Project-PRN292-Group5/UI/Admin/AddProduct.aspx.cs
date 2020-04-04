using Project_PRN292_Group5.Entity;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_PRN292_Group5.UI.Admin
{
    public partial class AddProduct : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string message = "";

            SqlConnection con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                string query = "insert into product ([product_name],[price_import],[price_sale],[quantity],[category_id],[image],[status_id]) values(@name, 0, @priceSale,0, @cId, '',@sId)";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@name", txtName.Text);
                cmd.Parameters.AddWithValue("@priceSale", txtPrice.Text);
                cmd.Parameters.AddWithValue("@cId", listCate.SelectedValue);
                cmd.Parameters.AddWithValue("@sId", listStatus.SelectedValue);
                cmd.ExecuteNonQuery();
            }
            catch
            {
                message = "Add Fail";
            }
            finally
            {
                con.Close();
                message = "Add sucessfull";
            }
            string script = String.Format("alert('{0}');", message);
            this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "msgbox", script, true);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("ProductShow.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("ImportProductHistory.aspx");
        }
    }
}