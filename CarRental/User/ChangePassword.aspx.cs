using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental.User
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataReader sdr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            if(Session["username"] != null)
            {
                if(txtOldPassword.Value.Trim() == getPassword())
                {
                    if(txtOldPassword.Value.Trim() != txtNewPassword.Value.Trim())
                    {
                        con = new SqlConnection(Connection.GetConnectionString());
                        cmd = new SqlCommand("User_Crud", con);
                        cmd.Parameters.AddWithValue("@Action", "AUTOPASSWORDUPDATE");
                        cmd.Parameters.AddWithValue("@Password", txtNewPassword.Value.Trim());
                        cmd.Parameters.AddWithValue("@Username", Session["username"]);
                        cmd.CommandType = CommandType.StoredProcedure;
                        try
                        {
                            con.Open();
                            cmd.ExecuteNonQuery();
                            lblMsg.Visible = true;
                            lblMsg.Text = "Password changed successful!";
                            lblMsg.CssClass = "alert alert-success";
                            Session.Abandon();
                            Response.AddHeader("REFRESH", "1;URL=Login.aspx");
                        }
                        catch(Exception ex)
                        {
                            Response.Write("<script>alert('" + ex.Message + "');</script>");
                        }
                        finally
                        {
                            con.Close();
                        }
                    }
                    else
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "Old password & new password cannot be same.";
                        lblMsg.CssClass = "alert alert-warning";
                    }
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Invalid old password..!";
                    lblMsg.CssClass = "alert alert-danger";
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
        }

        string getPassword()
        {
            string password = string.Empty;
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "FORGOTPASSWORD");
                cmd.Parameters.AddWithValue("@Username", Session["username"]);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                sdr = cmd.ExecuteReader();
                while (sdr.Read())
                {
                    password = sdr["Password"].ToString();
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('" + ex.Message + "');</script>");
            }
            finally
            {
                con.Close();
            }
            return password;
        }
    }
}