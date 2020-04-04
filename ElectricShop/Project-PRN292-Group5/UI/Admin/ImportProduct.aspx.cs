using Project_PRN292_Group5.Entity;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_PRN292_Group5.UI.Admin
{
    public partial class ImportProduct : System.Web.UI.Page
    {
        SqlConnection con = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label1.Visible = false;
                DataTable dt = new DataTable();
                DataRow dr;
                dt.Columns.Add("product_id");
                dt.Columns.Add("product_name");
                dt.Columns.Add("price_sale");
                dt.Columns.Add("price_import");
                dt.Columns.Add("quantity");
                dt.Columns.Add("total", typeof(double));

                if (Session["datakeys"] != null)
                {
                    if (Session["buyItems"] == null)
                    {
                        dr = dt.NewRow();
                        int code = Convert.ToInt32(Session["datakeys"]);
                        DataSet ds = getProductById(code);
                        dr["product_id"] = ds.Tables[0].Rows[0]["product_id"].ToString();
                        dr["product_name"] = ds.Tables[0].Rows[0]["product_name"].ToString();
                        dr["price_sale"] = ds.Tables[0].Rows[0]["price_sale"].ToString();
                        dr["price_import"] = ds.Tables[0].Rows[0]["price_import"].ToString();
                        dr["quantity"] = ds.Tables[0].Rows[0]["quantity"].ToString();
                        dr["total"] = double.Parse(ds.Tables[0].Rows[0]["price_import"].ToString()) * double.Parse(ds.Tables[0].Rows[0]["quantity"].ToString());
                        dt.Rows.Add(dr);
                        GridView2.DataSource = dt;
                        GridView2.DataBind();
                        Session["buyItems"] = dt;
                    }
                    else
                    {
                        dt = (DataTable)Session["buyItems"];
                        dr = dt.NewRow();
                        int code = Convert.ToInt32(Session["datakeys"]);
                        DataSet ds = getProductById(code);
                        dr["product_id"] = ds.Tables[0].Rows[0]["product_id"].ToString();
                        dr["product_name"] = ds.Tables[0].Rows[0]["product_name"].ToString();
                        dr["price_sale"] = ds.Tables[0].Rows[0]["price_sale"].ToString();
                        dr["price_import"] = ds.Tables[0].Rows[0]["price_import"].ToString();
                        dr["quantity"] = ds.Tables[0].Rows[0]["quantity"].ToString();
                        dr["total"] = double.Parse(ds.Tables[0].Rows[0]["price_import"].ToString()) * double.Parse(ds.Tables[0].Rows[0]["quantity"].ToString());
                        dt.Rows.Add(dr);

                        GridView2.DataSource = dt;
                        GridView2.DataBind();
                        GridView2.FooterRow.Cells[2].Text = "Total";
                        GridView2.FooterRow.Cells[5].Text = dt.Compute("Sum(total)", "").ToString();
                        Session["buyItems"] = dt;

                    }
                }
                else
                {
                    dt = (DataTable)Session["buyItems"];
                    GridView2.DataSource = dt;
                    GridView2.DataBind();
                }



            }
        }



        protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {

            Session["datakeys"] = GridView1.DataKeys[e.NewSelectedIndex].Value.ToString();
            Response.Redirect("ImportProduct.aspx");
        }

        public DataSet getProductById(int id)
        {
            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                string query = "select * from product where product_id=@id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@id", id);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                return ds;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        public Category getCategoryById(int id)
        {
            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                string query = "select * from Category where cate_id=@id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@id", id);
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Category c = new Category();
                            c.ID = Convert.ToInt32(reader["cate_id"].ToString());
                            c.Name = reader["category_name"].ToString();
                            return c;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            return null;
        }

        public Status getStatusById(int id)
        {
            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                string query = "select * from Status where status_id=@id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@id", id);
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Status c = new Status();
                            c.ID = Convert.ToInt32(reader["status_id"].ToString());
                            c.statusName = reader["status_name"].ToString();
                            return c;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            return null;
        }

        protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["buyItems"];
            dt.Rows[e.RowIndex].Delete();
            GridView2.DataSource = dt;
            GridView2.DataBind();
            Session["buyItems"] = dt;
            GridView2.FooterRow.Cells[2].Text = "Total";
            GridView2.FooterRow.Cells[5].Text = dt.Compute("Sum(total)", "").ToString();
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            GridView1.DataBind();
        }

        //protected void GridView2_PageIndexChanging(object sender, GridViewPageEventArgs e)
        //{
        //    GridView2.PageIndex = e.NewPageIndex;
        //    DataTable dt = new DataTable();
        //    dt = (DataTable)Session["buyItems"];
        //    GridView2.DataSource = dt;
        //    GridView2.DataBind();
        //    Session["buyItems"] = dt;
        //    GridView2.FooterRow.Cells[2].Text = "Total";
        //    GridView2.FooterRow.Cells[5].Text = dt.Compute("Sum(total)", "").ToString();
        //}

        protected void Button1_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt = (DataTable)Session["buyItems"];
            DataRow dr;
            GridViewRow row;
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                row = GridView2.Rows[i];
                dr = dt.Rows[i];
                TextBox textPriceImport = (TextBox)row.FindControl("txtPriceImport");
                TextBox txtQuantity = (TextBox)row.FindControl("txtQuantity");
                dr["price_import"] = textPriceImport.Text;
                dr["quantity"] = txtQuantity.Text;
                dr["total"] = double.Parse(textPriceImport.Text) * double.Parse(txtQuantity.Text);
            }
            GridView2.DataSource = dt;
            GridView2.DataBind();
            Session["buyItems"] = dt;
            GridView2.FooterRow.Cells[2].Text = "Total";
            GridView2.FooterRow.Cells[5].Text = dt.Compute("Sum(total)", "").ToString();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

            if (Session["buyItems"] == null)
            {
                Label1.Visible = true;
                return;
            }

            int idImportBill = getImportId();
            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                string query = "insert into [ImportBill] ([import_date], [staff_id], [suplier_id], [total_price]) values(GETDATE(), @staff, @suplier, @totalPrice)";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@staff", listStaff.SelectedValue);
                cmd.Parameters.AddWithValue("@suplier", listSuplier.SelectedValue);
                cmd.Parameters.AddWithValue("@totalPrice", 1500);
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



            for (int i = 0; i < GridView2.Rows.Count; i++)
            {
                con.Open();
                string productId = GridView2.Rows[i].Cells[0].Text;
                TextBox quantity = (TextBox)GridView2.Rows[i].FindControl("txtQuantity");
                TextBox priceImport = (TextBox)GridView2.Rows[i].FindControl("txtPriceImport");
                string total = GridView2.Rows[i].Cells[5].Text;
                try
                {
                    string query = "insert into [Detail_ImportBill] ([import_id], [product_id], [quantity], [priceAitem], [total_price]) values(@import_id, @product, @quantity, @price, @total)";
                    SqlCommand cmd = new SqlCommand();
                    cmd.Connection = con;
                    cmd.CommandText = query;
                    cmd.Parameters.AddWithValue("@import_id", idImportBill);
                    cmd.Parameters.AddWithValue("@product", productId);
                    cmd.Parameters.AddWithValue("@quantity", quantity.Text);
                    cmd.Parameters.AddWithValue("@price", priceImport.Text);
                    cmd.Parameters.AddWithValue("@total", total);
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
                updatePriceImport(productId);
            }


            Session["buyItems"] = null;
            Session["datakeys"] = null;
            Response.Redirect("ImportProductHistory.aspx");

        }

        public int getImportId()
        {
            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                string query2 = "select top 1 id from ImportBill order by id DESC";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query2;
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            int id = Convert.ToInt32(reader["id"].ToString());
                            return id;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            return -1;

        }
        public void updatePriceImport(string product_id)
        {

            con = DBContext.GetDBConnection();
            con.Open();
            try
            {
                string query = "update Product set price_import = (select sum(total_price)/sum(quantity) from Detail_ImportBill where product_id =@iId) where product_id = @pId";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = con;
                cmd.CommandText = query;
                cmd.Parameters.AddWithValue("@iId", product_id);
                cmd.Parameters.AddWithValue("@pId", product_id);
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
        }
    }
}