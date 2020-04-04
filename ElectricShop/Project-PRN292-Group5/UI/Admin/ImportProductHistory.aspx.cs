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
    public partial class ImportProductHistory : System.Web.UI.Page
    {
        SqlConnection con = null;
        string datakeys = "";

        public string Datakeys { get => datakeys; set => datakeys = value; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                load_data();
            }
            GridView2.Visible = false;
            Label1.Visible = false;
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
            Label1.Visible = false;
            GridView2.Visible = false;
        }

        protected void ChkCode_CheckedChanged(object sender, EventArgs e)
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

        protected void ChkDate_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkDate.Checked)
            {
                GridView1.Columns[1].Visible = true;
            }
            else
            {
                GridView1.Columns[1].Visible = false;
            }
        }

        protected void ChkStaff_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkStaff.Checked)
            {
                GridView1.Columns[2].Visible = true;
            }
            else
            {
                GridView1.Columns[2].Visible = false;
            }
        }

        protected void ChkSuplier_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkSuplier.Checked)
            {
                GridView1.Columns[3].Visible = true;
            }
            else
            {
                GridView1.Columns[3].Visible = false;
            }
        }

        protected void ChkTotal_CheckedChanged(object sender, EventArgs e)
        {
            if (ChkTotal.Checked)
            {
                GridView1.Columns[4].Visible = true;
            }
            else
            {
                GridView1.Columns[4].Visible = false;
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("NMHAddProduct.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("NMHImportProduct.aspx");
        }

        public string getString(object obj)
        {
            return obj.ToString();
        }

        protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            Datakeys = GridView1.DataKeys[e.NewSelectedIndex].Value.ToString();
            Session["datakeys"] = Datakeys;
            GridView2.DataBind();
            Label1.Visible = true;
            GridView2.Visible = true;
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
                Calendar importDate = (Calendar)(row.FindControl("editDate"));
                DropDownList listStaff = (DropDownList)row.FindControl("listStaff");
                DropDownList listSuplier = (DropDownList)row.FindControl("listSuplier");
                TextBox total = (TextBox)row.FindControl("txtTotal");
                Label id = (Label)row.FindControl("txtCode");
                string query = "update ImportBill set [import_date]=@import_date, [staff_id] = @staff_id, [suplier_id] =@suplier_id, [total_price]=@total_price where id=@id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("import_date", Convert.ToDateTime(importDate.SelectedDate));
                cmd.Parameters.AddWithValue("staff_id", listStaff.SelectedValue);
                cmd.Parameters.AddWithValue("suplier_id", listSuplier.SelectedValue);
                cmd.Parameters.AddWithValue("total_price", total.Text);
                cmd.Parameters.AddWithValue("id", id.Text);
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

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];
                Label id = (Label)row.FindControl("lblCode");
                string query = "DELETE FROM [dbo].[Detail_ImportBill] where import_id=@import_id DELETE FROM [dbo].[ImportBill] where id =@id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@import_id", id.Text);
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

        public string dateFormat(object date)
        {

            return Convert.ToDateTime(date).ToString("MM/dd/yyyy");
        }
        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            load_data();
        }

        protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            load_data();
        }
    }
}