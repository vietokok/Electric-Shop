using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Entity
{
    public class ExportBillDAO
    {
        SqlConnection conn = null;
        public void insert(ExportBill eb)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                String insertOrder = "INSERT INTO [dbo].[ExportBill]\n"
                   + "           ([export_date]\n"
                   + "           ,[staff_id]\n"
                   + "           ,[customer_id]\n"
                   + "           ,[total_price]\n"
                   + "           ,[note])\n"
                   + "     VALUES\n"
                   + "           (GETDATE(), @staff, @cus, @total, @note)";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = insertOrder;
                cmd.Parameters.Add(new SqlParameter("@staff", eb.Staff.ID));
                cmd.Parameters.Add(new SqlParameter("@cus", eb.Customer.ID));
                cmd.Parameters.Add(new SqlParameter("@total", eb.TotalPrice()));
                cmd.Parameters.Add(new SqlParameter("@note", eb.Note));
                cmd.ExecuteNonQuery();

                string queryGetExportBillId = "SELECT @@IDENTITY as oid";
                SqlCommand cmd1 = new SqlCommand();
                cmd1.Connection = conn;
                cmd1.CommandText = queryGetExportBillId;
                using (DbDataReader reader = cmd1.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        if (reader.Read())
                        {
                            eb.ID = Convert.ToInt32(reader["oid"]);
                        }
                    }
                }

                string insertOrderline = "INSERT INTO [dbo].[Detail_ExportBill]\n"
                    + "           ([export_id]\n"
                    + "           ,[product_id]\n"
                    + "           ,[quantity]\n"
                    + "           ,[total_price]\n"
                    + "           ,[discount])\n"
                    + "     VALUES\n"
                    + "           (@ebId, @pdId, @quan, @total, @discount)";
                foreach (var item in eb.Lines)
                {
                    SqlCommand cmd2 = new SqlCommand();
                    cmd2.Connection = conn;
                    cmd2.CommandText = insertOrderline;
                    cmd2.Parameters.Add(new SqlParameter("@ebId", eb.ID));
                    cmd2.Parameters.Add(new SqlParameter("@pdId", item.Product.Id));
                    cmd2.Parameters.Add(new SqlParameter("@quan", item.Quantity));
                    cmd2.Parameters.Add(new SqlParameter("@total", item.ToTalPrice));
                    cmd2.Parameters.Add(new SqlParameter("@discount", item.Discount));
                    cmd2.ExecuteNonQuery();
                }
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

        public List<ExportBill> GetExportBill(int numberInPage, int pageCurrent, string key)
        {
            List<ExportBill> listExportBill = new List<ExportBill>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "Select * from( Select *, ROW_NUMBER() OVER (ORDER BY id ASC) as row_num FROM\n" +
                            "\n" +
                            "(SELECT ExportBill.id, ExportBill.export_date, Customer.customer_name, ExportBill.total_price\n" +
                            "FROM     Customer INNER JOIN\n" +
                            "ExportBill ON Customer.customer_id = ExportBill.customer_id where Customer.customer_name like @key) ab) xy\n" +
                            "Where row_num >= @from	 and row_num <= @to";
              
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                int from = (pageCurrent - 1) * numberInPage + 1;
                int to = pageCurrent * numberInPage;
                cmd.Parameters.Add(new SqlParameter("@key", "%" + key + "%"));
                cmd.Parameters.Add(new SqlParameter("@from", from));
                cmd.Parameters.Add(new SqlParameter("@to", to));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            ExportBill e = new ExportBill();
                            e.ID = Convert.ToInt32(reader["id"]);
                            e.Date = reader["export_date"].ToString();
                            e.TotalPrice1 = Convert.ToSingle(reader["total_price"]);
                            Customer c = new Customer();
                            c.Name = reader["customer_name"].ToString();
                            e.Customer = c;

                            listExportBill.Add(e);
                        }
                    }
                }
                return listExportBill;
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
        public List<ExportBill> GetExportBill1(int numberInPage, int pageCurrent, string begin,string end)
        {
            List<ExportBill> listExportBill = new List<ExportBill>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "Select * from( Select *, ROW_NUMBER() OVER (ORDER BY id ASC) as row_num FROM\n" +
                            "\n" +
                            "(SELECT ExportBill.id, ExportBill.export_date, Customer.customer_name, ExportBill.total_price\n" +
                            "FROM     Customer INNER JOIN\n" +
                            "ExportBill ON Customer.customer_id = ExportBill.customer_id where export_date >= @begin and export_date <= @end) ab) xy\n" +
                            "Where row_num >= @from	 and row_num <= @to";

                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                int from = (pageCurrent - 1) * numberInPage + 1;
                int to = pageCurrent * numberInPage;
                cmd.Parameters.Add(new SqlParameter("@begin", begin));
                cmd.Parameters.Add(new SqlParameter("@end", end));
                cmd.Parameters.Add(new SqlParameter("@from", from));
                cmd.Parameters.Add(new SqlParameter("@to", to));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            ExportBill e = new ExportBill();
                            e.ID = Convert.ToInt32(reader["id"]);
                            e.Date = reader["export_date"].ToString();
                            e.TotalPrice1 = Convert.ToSingle(reader["total_price"]);
                            Customer c = new Customer();
                            c.Name = reader["customer_name"].ToString();
                            e.Customer = c;

                            listExportBill.Add(e);
                        }
                    }
                }
                return listExportBill;
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

        public ExportBill GetExportBillByID(int id)
        {
            int check = 1;
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT ExportBill.id, ExportBill.export_date, Customer.customer_name, Staff.staff_id, Staff.staff_name, Staff.note\n"
                    + "FROM     Customer INNER JOIN\n"
                    + "                  ExportBill ON Customer.customer_id = ExportBill.customer_id INNER JOIN\n"
                    + "                  Staff ON ExportBill.staff_id = Staff.staff_id Where ExportBill.id = @id";
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
                            check = 0;
                            ExportBill eb = new ExportBill();
                            eb.ID = Convert.ToInt32(reader["id"]);
                            eb.Date = Convert.ToDateTime(reader["export_date"]).ToString();
                            eb.Note = reader["note"].ToString();

                            Staff s = new Staff();
                            s.Name = reader["staff_name"].ToString();
                            eb.Staff = s;

                            Customer c = new Customer();
                            c.Name = reader["customer_name"].ToString();
                            eb.Customer = c;

                            return eb;
                        }
                    }
                }
                Console.WriteLine(check);
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

        public List<DetailExportBill> GetDetailExportBillByID(int id)
        {
            List<DetailExportBill> lDetail = new List<DetailExportBill>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT Detail_ExportBill.export_id, Product.product_name, Detail_ExportBill.quantity, Product.price_sale, Detail_ExportBill.discount, Detail_ExportBill.total_price\n"
                    + "FROM     Detail_ExportBill INNER JOIN\n"
                    + "                  Product ON Detail_ExportBill.product_id = Product.product_id Where Detail_ExportBill.export_id = @id";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@id", id));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            DetailExportBill de = new DetailExportBill();

                            ExportBill e = new ExportBill();
                            e.ID = Convert.ToInt32(reader["export_id"]);

                            de.ExportBill = e;

                            Product p = new Product();
                            p.Name = reader["product_name"].ToString();
                            p.PriceSale = Convert.ToSingle(reader["price_sale"]);

                            de.Product = p;

                            de.Quantity = Convert.ToSingle(reader["quantity"]);
                            de.Discount = Convert.ToSingle(reader["discount"]);
                            de.ToTalPrice = Convert.ToSingle(reader["total_price"]);

                            lDetail.Add(de);
                        }
                    }
                }
                return lDetail;
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

        public int getNumberPage(int numberProductInPage, string key)
        {
            int count = -1;
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT COUNT(*) as rownum FROM \n" +
                   "Customer INNER JOIN\n" +
                   "ExportBill ON Customer.customer_id = ExportBill.customer_id Where Customer.customer_name like @key";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@key", "%" + key + "%"));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            count = Convert.ToInt32(reader["rownum"]);
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
        public int getNumberPage1(int numberProductInPage, string begin,string end )
        {
            int count = -1;
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT COUNT(*) as rownum FROM \n" +
                   "Customer INNER JOIN\n" +
                   "ExportBill ON Customer.customer_id = ExportBill.customer_id where export_date >= @begin and export_date <= @end";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@begin", begin));
                cmd.Parameters.Add(new SqlParameter("@end", end));
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            count = Convert.ToInt32(reader["rownum"]);
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