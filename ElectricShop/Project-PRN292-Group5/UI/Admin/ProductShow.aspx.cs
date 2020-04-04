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
    public partial class ProductShow : System.Web.UI.Page
    {
        SqlConnection con = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_data();
            }

        }

        public void load_data()
        {
            GridView1.DataSource = SqlDataSource1;
            GridView1.DataBind();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextBox1.Text == "" || TextBox1.Text == null)
            {
                //GridView1.DataSourceID = "SqlDataSource1";
                load_data();
            }
            else
            {
                GridView1.DataSource = SqlDataSource2;
                GridView1.DataBind();
                //GridView1.DataSourceID = "SqlDataSource2";
            }
        }


        protected void Code_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkCode.Checked)
            {
                GridView1.Columns[0].Visible = true;
            }
            else
            {
                GridView1.Columns[0].Visible = false;
            }
        }

        protected void ChkName_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkName.Checked)
            {
                GridView1.Columns[1].Visible = true;
            }
            else
            {
                GridView1.Columns[1].Visible = false;
            }
        }

        protected void ChkPriceImport_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkPriceImport.Checked)
            {
                GridView1.Columns[3].Visible = true;
            }
            else
            {
                GridView1.Columns[3].Visible = false;
            }
        }

        protected void ChkCategory_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkCategory.Checked)
            {
                GridView1.Columns[2].Visible = true;
            }
            else
            {
                GridView1.Columns[2].Visible = false;
            }
        }

        protected void ChkStatus_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkStatus.Checked)
            {
                GridView1.Columns[6].Visible = true;
            }
            else
            {
                GridView1.Columns[6].Visible = false;
            }
        }

        protected void ChkPriceSale_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkPriceSale.Checked)
            {
                GridView1.Columns[4].Visible = true;
            }
            else
            {
                GridView1.Columns[4].Visible = false;
            }
        }

        protected void ChkQuantity_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkQuantity.Checked)
            {
                GridView1.Columns[5].Visible = true;
            }
            else
            {
                GridView1.Columns[5].Visible = false;
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            load_data();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            load_data();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                TextBox name = (TextBox)row.FindControl("txtName");
                TextBox priceImport = (TextBox)row.FindControl("txtPriceImport");
                TextBox price = (TextBox)row.FindControl("txtPrice");
                TextBox quantity = (TextBox)row.FindControl("txtQuantity");
                Label id = (Label)row.FindControl("txtCode");
                DropDownList listCate = (DropDownList)row.FindControl("listCate");
                DropDownList listStatus = (DropDownList)row.FindControl("listStatus");
                string query = "update product set [product_name] = @product_name, [price_import] =@price_import, [price_sale]=@price_sale, [quantity]=@quantity, [category_id]=@category_id, [image]='', [status_id]=@status_id where product_id=@product_id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@product_name", name.Text);
                cmd.Parameters.AddWithValue("@price_import", priceImport.Text);
                cmd.Parameters.AddWithValue("@price_sale", price.Text);
                cmd.Parameters.AddWithValue("@quantity", quantity.Text);
                cmd.Parameters.AddWithValue("@product_id", id.Text);
                cmd.Parameters.AddWithValue("@category_id", listCate.SelectedValue);
                cmd.Parameters.AddWithValue("@status_id", listStatus.SelectedValue);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            GridView1.EditIndex = -1;
            load_data();
        }

        public string getInt(object id)
        {
            return id.ToString();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {

            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                Label id = (Label)row.FindControl("lblCode");
                string query = "delete from Detail_ExportBill where product_id =@id delete from Detail_ImportBill where product_id =@id delete from product where product_id =@id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@id", id.Text);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            load_data();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            load_data();
        }
    }
}