using Project_PRN292_Group5.Entity;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ProjectCSharpAdmin.Model
{
    public class AccountDAO
    {
        SqlConnection conn = null;
        //demo query SELECT
        public Account GetAccount(string name)
        {
            List<Account> listAccount = new List<Account>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT [username],[password],[type] FROM[dbo].[Account] where username='" + name + "'";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Account a = new Account();
                            a.Username = reader.GetString(0);
                            a.Password = reader.GetString(1);
                            a.Type = reader.GetString(2);
                            return a;
                        }
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

        public List<Account> getAllAccount()
        {
            List<Account> listAccount = new List<Account>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "select username from Account";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Account a = new Account();
                            a.Username = reader.GetString(0);
                            listAccount.Add(a);
                        }
                    }
                }
                return listAccount;
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

        public void addAccount(string username, string pass, int type, string email)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "INSERT INTO [dbo].[Account]([username] ,[password] ,[type] ,[email]) VALUES (@username, @pass, @type, @email)";

                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@username", username));
                cmd.Parameters.Add(new SqlParameter("@pass", pass));
                cmd.Parameters.Add(new SqlParameter("@type", type));
                cmd.Parameters.Add(new SqlParameter("@email", email));
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
        public void deletaAccount(string id)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "DELETE FROM [dbo].[Account]     WHERE Account.username = @id ";

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