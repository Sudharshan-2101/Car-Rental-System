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
    public partial class Contact : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Contact_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "INSERT");
                cmd.Parameters.AddWithValue("@Name", txtName.Value.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Value.Trim());
                cmd.Parameters.AddWithValue("@Subject", txtSubject.Value.Trim());
                cmd.Parameters.AddWithValue("@Message", txtMessage.Value.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Thanks for reaching out will look into your query!";
                lblMsg.CssClass = "alert alert-success";
                clear();
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

        private void clear()
        {
            txtName.Value = string.Empty;
            txtEmail.Value = string.Empty;
            txtSubject.Value = string.Empty;
            txtMessage.Value = string.Empty;
        }
    }
}