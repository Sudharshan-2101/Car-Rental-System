using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental.User
{
    public partial class Login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        static string UserEmail = "hari.aug1598@gmail.com";
        static string UserPassword = "djlyfrbwydhaknqm";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] != null)
            {
                Response.Redirect("Default.aspx");
            }
            if(!IsPostBack)
            {
                pnlForgotPassword.Visible = false;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            //if (txtUsername.Value.Trim() == "Admin" & txtPassword.Value.Trim() == "123")
            //{
            //    Session["admin"] = txtUsername.Value.Trim();
            //    Response.Redirect("../Admin/Dashboard.aspx");
            //}
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                cmd.Parameters.AddWithValue("@Username", txtUsername.Value.Trim());
                cmd.Parameters.AddWithValue("@Password", txtPassword.Value.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count == 1)
                {   
                    if (Convert.ToInt32(dt.Rows[0]["RoleId"]) == 1)
                    {
                        Session["admin"] = txtUsername.Value.Trim();
                        Response.Redirect("../Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Session["userId"] = dt.Rows[0]["UserId"];
                        Session["username"] = txtUsername.Value.Trim();
                        Response.Redirect("Default.aspx");
                    }
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Invalid Credentials..!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        protected void btnForgotPassword_Click(object sender, EventArgs e)
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "FORGOTPASSWORD");
                cmd.Parameters.AddWithValue("@Username", txtForgotUsername.Value.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count == 1)
                {
                    using (SmtpClient client = new SmtpClient("smtp.gmail.com", 587))
                    {
                        string Destination = dt.Rows[0]["Email"].ToString();
                        string mailSubject = "Forgot Password - Access your new password.";
                        Guid g = Guid.NewGuid();
                        string newPassword = g.ToString("N").Substring(0, 10); /* N is used to remove hypen(-) */
                        string mailMessage = "<b style='background-color:yellow'>" + newPassword + "</b>  is your new password";

                        client.EnableSsl = true;
                        client.DeliveryMethod = SmtpDeliveryMethod.Network;
                        client.UseDefaultCredentials = false;
                        client.Credentials = new NetworkCredential(UserEmail, UserPassword);
                        MailMessage msgObj = new MailMessage();
                        msgObj.To.Add(Destination);
                        msgObj.From = new MailAddress(UserEmail);
                        msgObj.Subject = mailSubject;
                        msgObj.Body = mailMessage;
                        msgObj.IsBodyHtml = true;
                        client.Send(msgObj);
                        updatePasswordByEmail(txtForgotUsername.Value.Trim(), newPassword);

                        txtForgotUsername.Value = string.Empty;
                        lblMsg.Visible = true;
                        lblMsg.Text = "We've sent you one email with new password for login!";
                        lblMsg.CssClass = "alert alert-success";
                    }
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Invalid Username..!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
        }

        void updatePasswordByEmail(string username, string password)
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "AUTOPASSWORDUPDATE");
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
        }

        protected void lbForgotPassword_Click(object sender, EventArgs e)
        {
            pnlLogin.Visible = false;
            pnlForgotPassword.Visible = true;
        }

        protected void lbLogin_Click(object sender, EventArgs e)
        {
            pnlForgotPassword.Visible = false;
            pnlLogin.Visible = true;
        }
    }
}