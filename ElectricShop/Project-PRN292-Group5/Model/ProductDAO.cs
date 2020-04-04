using Project_PRN292_Group5.Entity;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Model
{
    public class ProductDAO
    {
        SqlConnection conn = null;
        public List<Product> GetProducts(string keyword)
        {
            List<Product> listItems = new List<Product>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT Product.*, Category.category_name, Status.status_name\n"
                + "FROM     Category INNER JOIN\n"
                + "                  Product ON Category.cate_id = Product.category_id INNER JOIN\n"
                + "                  Status ON Product.status_id = Status.status_id\n"
                + " WHERE product_name LIKE @key or category_name LIKE @key";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@key", "%" + keyword + "%"));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Product p = new Product();
                            p.Id = Convert.ToInt32(reader["product_id"]);
                            p.Name = reader["product_name"].ToString();
                            p.PriceImport = Convert.ToSingle(reader["price_import"]);
                            p.PriceSale = Convert.ToSingle(reader["price_sale"]);
                            p.Quantity = Convert.ToSingle(reader["quantity"]);
                            Category c = new Category();
                            c.ID = Convert.ToInt32(reader["category_id"]);
                            c.Name = reader["category_name"].ToString();
                            p.Cate = c;
                            Status s = new Status();
                            s.ID = Convert.ToInt32(reader["status_id"]);
                            s.statusName = reader["status_name"].ToString();
                            p.St = s;
                            p.Image = "../../Assets/Shop/img/" + reader["image"].ToString();
                            listItems.Add(p);
                        }
                        return listItems;
                    }
                }
                return null;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                conn.Close();
            }
        }
        public Product GetProductById(int id)
        {
            Product p = new Product();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT Product.*, Category.category_name, Status.status_name\n"
                + "FROM     Category INNER JOIN\n"
                + "                  Product ON Category.cate_id = Product.category_id INNER JOIN\n"
                + "                  Status ON Product.status_id = Status.status_id\n"
                + " WHERE product_id = @id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@id", id));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            p.Id = Convert.ToInt32(reader["product_id"]);
                            p.Name = reader["product_name"].ToString();
                            p.PriceImport = Convert.ToSingle(reader["price_import"]);
                            p.PriceSale = Convert.ToSingle(reader["price_sale"]);
                            p.Quantity = Convert.ToSingle(reader["quantity"]);
                            Category c = new Category();
                            c.ID = Convert.ToInt32(reader["category_id"]);
                            c.Name = reader["category_name"].ToString();
                            p.Cate = c;
                            Status s = new Status();
                            s.ID = Convert.ToInt32(reader["status_id"]);
                            s.statusName = reader["status_name"].ToString();
                            p.St = s;
                            p.Image = "../../Assets/Shop/img/" + reader["image"].ToString();

                        }
                        return p;
                    }
                }
                return null;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                conn.Close();
            }
        }
        public void DeleteProductById(int id)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "DELETE FROM [dbo].[Product] WHERE product_id = @id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@id", id));
                cmd.ExecuteNonQuery();
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                conn.Close();
            }
        }
       
        public List<Product> GetListProductSearch(int numberProductInPage, int pageCurrent, String keyword)
        {
            List<Product> listItems = new List<Product>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT * \n"
                + "FROM (                  \n"
                + "	SELECT *, ROW_NUMBER() OVER (ORDER BY product_id) as row_num\n"
                + "	FROM (		  \n"
                + "		SELECT Product.*, Category.category_name, [Status].status_name\n"
                + "		FROM Category INNER JOIN\n"
                + "             Product ON Category.cate_id = Product.category_id INNER JOIN\n"
                + "             [Status] ON Product.status_id = [Status].status_id				  \n"
                + "WHERE Product.product_name LIKE @key or Category.category_name LIKE @key	 \n"
                + "		)xyz \n"
                + "	)abc\n"
                + "WHERE row_num >= @from AND row_num<= @to";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                int from = (pageCurrent - 1) * numberProductInPage + 1;
                int to = pageCurrent * numberProductInPage;
                cmd.Parameters.Add(new SqlParameter("@key", "%" + keyword + "%"));
                cmd.Parameters.Add(new SqlParameter("@from", from));
                cmd.Parameters.Add(new SqlParameter("@to", to));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Product p = new Product();
                            p.Id = Convert.ToInt32(reader["product_id"]);
                            p.Name = reader["product_name"].ToString();
                            p.PriceImport = Convert.ToSingle(reader["price_import"]);
                            p.PriceSale = Convert.ToSingle(reader["price_sale"]);
                            p.Quantity = Convert.ToSingle(reader["quantity"]);
                            Category c = new Category();
                            c.ID = Convert.ToInt32(reader["category_id"]);
                            c.Name = reader["category_name"].ToString();
                            p.Cate = c;
                            Status s = new Status();
                            s.ID = Convert.ToInt32(reader["status_id"]);
                            s.statusName = reader["status_name"].ToString();
                            p.St = s;
                            p.Image = "../../Assets/Shop/img/" + reader["image"].ToString();
                            listItems.Add(p);
                        }
                        return listItems;
                    }
                }
                return null;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                conn.Close();
            }
        }
        public int getNumberPage(int numberProductInPage, string keyword)
        {
            int count = -1;
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT COUNT(product_id) as number\n"
                + "FROM Category INNER JOIN Product on\n"
                + "	Category.cate_id = Product.category_id\n"
                + "	INNER JOIN [Status] on\n"
                + "	Product.status_id = [Status].status_id\n"
                + "WHERE product_name LIKE @key OR Category.category_name LIKE @key";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@key", "%" + keyword + "%"));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            count = Convert.ToInt32(reader["number"]);
                        }
                        return (count % numberProductInPage == 0) ? (count / numberProductInPage) : (count / numberProductInPage + 1);
                    }
                }
                return -1;
            }
            catch (Exception e)
            {
                throw e;
            }
            finally
            {
                conn.Close();
            }
        }
    }
}