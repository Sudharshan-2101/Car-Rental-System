using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental.User
{
    public partial class Registration : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Title"] = "Registration";
                lbChangePassword.Visible = false;
                if (Request.QueryString["id"] != null && Session["userId"] != null)
                {
                    getUserDetails();
                    lbChangePassword.Visible=true;
                }
                else if (Session["userId"] != null)
                {
                    Response.Redirect("Default.aspx");
                }
            }
        }

        void getUserDetails()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
            cmd.Parameters.AddWithValue("@UserId", Request.QueryString["id"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count == 1)
            {
                txtName.Value = dt.Rows[0]["Name"].ToString();
                txtUsername.Value = dt.Rows[0]["Username"].ToString();
                txtMobile.Value = dt.Rows[0]["Mobile"].ToString();
                txtEmail.Value = dt.Rows[0]["Email"].ToString();
                txtAddress.Value = dt.Rows[0]["Address"].ToString();
                txtPostCode.Value = dt.Rows[0]["PostCode"].ToString();
                txtLicense.Value = dt.Rows[0]["License"].ToString();
                imgUser.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString())
                    ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                imgUser.Height = 200;
                imgUser.Width = 200;
                txtUserPassword.TextMode = TextBoxMode.SingleLine;
                txtUserPassword.Text = dt.Rows[0]["Password"].ToString();
                txtUserPassword.Enabled = false;
            }
            Session["Title"] = "Edit Profile";
            btnAddOrUpdate.Text = "Update";
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int userId = Convert.ToInt32(Request.QueryString["id"]);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", userId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@UserId", userId);
            cmd.Parameters.AddWithValue("@Name", txtName.Value.Trim());
            cmd.Parameters.AddWithValue("@Username", txtUsername.Value.Trim());
            cmd.Parameters.AddWithValue("@Mobile", txtMobile.Value.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Value.Trim());
            cmd.Parameters.AddWithValue("@Address", txtAddress.Value.Trim());
            cmd.Parameters.AddWithValue("@PostCode", txtPostCode.Value.Trim());
            cmd.Parameters.AddWithValue("@License", txtLicense.Value.Trim());
            cmd.Parameters.AddWithValue("@Password", txtUserPassword.Text.Trim());
            cmd.Parameters.AddWithValue("@RoleId", 2);
            if (fuUserImage.HasFile)
            {
                if (Utils.IsValidExtension(fuUserImage.FileName))
                {
                    object obj = Utils.GetUniqueId();
                    fileExtension = Path.GetExtension(fuUserImage.FileName);
                    imagePath = "Images/User/" + obj.ToString() + fileExtension;
                    fuUserImage.PostedFile.SaveAs(Server.MapPath("~/Images/User/") + obj.ToString() + fileExtension);
                    cmd.Parameters.AddWithValue("@ImageUrl", imagePath);
                    isValidToExecute = true;
                }
                else
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Please select .jpg, .jpeg or .png image";
                    lblMsg.CssClass = "alert alert-danger";
                    isValidToExecute = false;
                }
            }
            else
            {
                isValidToExecute = true;
            }

            if (isValidToExecute)
            {
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    actionName = userId == 0 ?
                        "registration is successful! <b><a href='Login.aspx'>Click here</a></b> to do login" :
                        "details updated successful! <b><a href='Profile.aspx'>Can check here</a></b>";
                    lblMsg.Visible = true;
                    lblMsg.Text = "<b>" + txtUsername.Value.Trim() + "</b> " + actionName;
                    lblMsg.CssClass = "alert alert-success";
                    if (userId != 0)
                    {
                        Response.AddHeader("REFRESH", "1;URL=Profile.aspx");
                    }
                    clear();
                }
                catch (SqlException ex)
                {
                    if (ex.Message.Contains("Violation of UNIQUE KEY constraint"))
                    {
                        lblMsg.Visible = true;
                        lblMsg.Text = "<b>" + txtUsername.Value.Trim() + "</b> username already exist, try new one..!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
                catch (Exception ex)
                {
                    lblMsg.Visible = true;
                    lblMsg.Text = "Error-" + ex.Message;
                    lblMsg.CssClass = "alert alert-danger";
                }
                finally
                {
                    con.Close();
                }
            }
        }

        void clear()
        {
            txtName.Value = string.Empty;
            txtUsername.Value = string.Empty;
            txtMobile.Value = string.Empty;
            txtEmail.Value = string.Empty;
            txtAddress.Value = string.Empty;
            txtPostCode.Value = string.Empty;
            txtLicense.Value = string.Empty;
            txtUserPassword.Text = string.Empty;
            imgUser.ImageUrl = "";
        }
    }
}