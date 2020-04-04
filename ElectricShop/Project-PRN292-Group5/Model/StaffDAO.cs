using Project_PRN292_Group5.Entity;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Project_PRN292_Group5.Model
{
    public class StaffDAO
    {
        SqlConnection conn = null;
        //demo query SELECT
        public List<Staff> GetStaff()
        {
            List<Staff> listStaff = new List<Staff>();
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "SELECT  [staff_id] ,[staff_name],[dateOfBirth] ,[gender],[address],[note] FROM[ElectricShop].[dbo].[Staff]";
                SqlCommand cmd = new SqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = query;
                using (DbDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        while (reader.Read())
                        {
                            Staff s = new Staff();
                            s.ID = reader.GetString(0);
                            s.Name = reader.GetString(1);
                            s.Date = reader.GetDateTime(2).ToShortDateString();
                            s.Gender = reader.GetString(3);
                            s.Address = reader.GetString(4);
                            s.Note = reader["note"].ToString();
                            listStaff.Add(s);
                        }
                    }
                }
                return listStaff;
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
        public void AddStaff(string id, string name, string date, string gender, string address, string note)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "INSERT INTO [dbo].[Staff]  ([staff_id]  ,[staff_name]  ,[dateOfBirth]  ,[gender]  ,[address] ,[note])  VALUES (@id, @name,@date,@gender,@address,@note)";

                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@id", id));
                cmd.Parameters.Add(new SqlParameter("@name", name));
                cmd.Parameters.Add(new SqlParameter("@date", date));
                cmd.Parameters.Add(new SqlParameter("@gender", gender));
                cmd.Parameters.Add(new SqlParameter("@address", address));
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
        public void deletaStaff(string id)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "DELETE FROM [dbo].[Staff]     WHERE staff_id = @id ";

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
        public void editStaff(string name, string date, string gender, string address, string note, string id1)
        {
            //date = date.Substring(0, 10);
            //id1 = id1.Replace(countEdit_id,"");
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "UPDATE [dbo].[Staff] SET [staff_name] = @name ,[dateOfBirth] = @date ,[gender] = @gender ,[address] = @address  ,[note] = @note  where staff_id= @id1";

                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = query;

                cmd.Parameters.Add(new SqlParameter("@name", name));
                cmd.Parameters.Add(new SqlParameter("@date", date));
                cmd.Parameters.Add(new SqlParameter("@gender", gender));
                cmd.Parameters.Add(new SqlParameter("@address", address));
                cmd.Parameters.Add(new SqlParameter("@note", note));
                cmd.Parameters.Add(new SqlParameter("@id1", id1));


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

        public void editExport(string newID, string oldID)
        {
            conn = DBContext.GetDBConnection();
            conn.Open();
            try
            {
                string query = "UPDATE [dbo].[ExportBill]   SET[staff_id] = @newID WHERE staff_id = @oldID";
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = query;
                cmd.Parameters.Add(new SqlParameter("@newID", newID));
                cmd.Parameters.Add(new SqlParameter("@oldID", oldID));
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