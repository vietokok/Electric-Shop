using Project_PRN292_Group5.Entity;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Model
{
    public class CustomerDAO
    {
        SqlConnection conn = null;
        public List<Customer> GetCustomer(string keyword)
        {
            List<Customer> listCustomer = new List<Customer>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT [customer_id],[customer_name],[state],[phone],[note] FROM[dbo].[Customer]"
                    + "WHERE customer_name LIKE @key or state LIKE @key";
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
                            Customer c = new Customer();
                            c.ID = Convert.ToInt32(reader["customer_id"]);
                            c.Name = reader["customer_name"].ToString();
                            c.Address = reader["state"].ToString();
                            c.Phone = reader["phone"].ToString();
                            c.Note = reader["note"].ToString();

                            listCustomer.Add(c);
                        }
                    }
                }
                return listCustomer;
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

        public List<Customer> getAllCustomer()
        {
            List<Customer> listCus = new List<Customer>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT  [customer_id],[customer_name] ,[state],[phone] ,[note] FROM[ElectricShop].[dbo].[Customer]";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Customer c = new Customer();
                            c.ID = Convert.ToInt32(reader["customer_id"]);
                            c.Name = reader.GetString(1);
                            c.Address = reader.GetString(2);
                            c.Phone = reader.GetString(3);
                            c.Note = reader["note"].ToString();
                            listCus.Add(c);
                        }
                    }
                }
                return listCus;
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

        public void AddCustomer(string name, string address, string phone, string note)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "INSERT INTO [dbo].[Customer]"
                 + "([customer_name]"
                 + ",[state]"
                 + ",[phone]"
                 + ",[note]) VALUES(@name, @address, @phone, @note)";
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@name", name));
                cmd.Parameters.Add(new SqlParameter("@address", address));
                cmd.Parameters.Add(new SqlParameter("@phone", phone));
                cmd.Parameters.Add(new SqlParameter("@note", note));
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

        public void DeleteCustomerByID(string id)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "DELETE FROM[dbo].[Customer]     WHERE customer_id = @id";
                SqlCommand cmd = conn.CreateCommand();
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
    }
}