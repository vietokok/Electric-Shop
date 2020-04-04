using Project_PRN292_Group5.Entity;
using ProjectCSharpAdmin.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Project_PRN292_Group5.UI
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["userInfo"];
            if (cookie != null)
            {
                string User_name = cookie["UserName"].ToString();
                string User_pass = cookie["UserPassWord"].ToString();
                string type = cookie["type"].ToString();
                TextBox1.Text = User_name;
                TextBox2.Text = User_pass;
                checkLogin(type);
            }
        }
        public void setCookie(string username, string password, string type)
        {
            HttpCookie userInfo = new HttpCookie("userInfo");
            userInfo["UserName"] = username;
            userInfo["UserPassWord"] = password;
            userInfo["type"] = type;
            userInfo.Expires.Add(new TimeSpan(0, 5, 0));
            Response.Cookies.Add(userInfo);
        }
        public void checkLogin(string type)
        {
            if ((TextBox1.Text.Trim() == "" || TextBox1.Text == null) && (TextBox2.Text.Trim() == "" || TextBox2.Text == null))
            {
                string message = "Your username and password is empty";
                string script = String.Format("alert('{0}');", message);
                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "msgbox", script, true);
                return;
            }
            else if (TextBox1.Text.Trim() == "" || TextBox1.Text == null)
            {
                string message = "Your username is empty";
                string script = String.Format("alert('{0}');", message);
                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "msgbox", script, true);
                return;
            }
            else if (TextBox2.Text.Trim() == "" || TextBox2.Text == null)
            {
                string message = "Your password is empty";
                string script = String.Format("alert('{0}');", message);
                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "msgbox", script, true);
                return;
            }
            else
            {
                AccountDAO accountDAO = new AccountDAO();
                Account account = accountDAO.GetAccount(TextBox1.Text.Trim());

                if (account == null)
                {
                    string message = "Your account does not exist";
                    string script = String.Format("alert('{0}');", message);
                    this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "msgbox", script, true);
                    //return;
                }
                else
                {
                    string username = account.Username.Trim();


                    string password = account.Password.Trim();
                    if (password.Equals(TextBox2.Text.Trim()) == false)
                    {
                        string message = "Your password is incorect";
                        string script = String.Format("alert('{0}');", message);
                        this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "msgbox", script, true);
                        return;
                    }
                    else
                    {
                        if (type.Equals("1"))
                        {
                            if (account.Type.Equals("1"))
                            {
                                if (checkBox1.Checked)
                                {
                                    setCookie(username, password, "1");
                                }
                                Session["Name"] = username;
                                Session.Timeout = 1;
                                Response.Redirect("../UI/Admin/Index.aspx");
                            }
                            else
                            {
                                string message = "You are not authorized to access this page";
                                string script = String.Format("alert('{0}');", message);
                                this.Page.ClientScript.RegisterStartupScript(this.Page.GetType(), "msgbox", script, true);
                                return;
                            }
                        }
                        else if (type.Equals("0"))
                        {
                            if (checkBox1.Checked)
                            {
                                setCookie(username, password, "0");
                            }
                            Session["Name"] = username;
                            Session.Timeout = 60 * 24;
                            Response.Redirect("../UI/Shop/Index.aspx");
                        }

                    }

                }

            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            checkLogin("1");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            checkLogin("0");
        }
    }
}