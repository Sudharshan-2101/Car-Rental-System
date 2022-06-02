using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental.Admin
{
    public partial class Brand : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["breadCrum"] = "Brand";
                getBrands();
            }
            lblMsg.Visible = false;
        }

        private void getBrands()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Brand_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rBrand.DataSource = dt;
            rBrand.DataBind();
        }

        protected void rBrand_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Brand_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@BrandId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                txtBrandName.Value = dt.Rows[0]["BrandName"].ToString();
                chkIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                hdnBrandId.Value = dt.Rows[0]["BrandId"].ToString();
                btnAddOrUpdate.Text = "Update";
            }
            else if (e.CommandName == "delete")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Brand_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@BrandId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    //ClientScript.RegisterClientScriptBlock(this.GetType(), "K",
                    //                    "swal('Succesfull!','Brand " + txtBrandName.Value.Trim() + " deleted succesful!','success')", true);
                    lblMsg.Visible = true;
                    lblMsg.Text = "Brand " + txtBrandName.Value.Trim() + " deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    getBrands();
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
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            int brandId = Convert.ToInt32(hdnBrandId.Value);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Brand_Crud", con);
            cmd.Parameters.AddWithValue("@Action", brandId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@BrandId", brandId);
            cmd.Parameters.AddWithValue("@BrandName", txtBrandName.Value.Trim());
            cmd.Parameters.AddWithValue("@IsActive", chkIsActive.Checked);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                actionName = brandId == 0 ? "inserted" : "updated";
                //ClientScript.RegisterClientScriptBlock(this.GetType(), "K",
                //                        "swal('Succesfull!','Brand " + txtBrandName.Value.Trim() + " " + actionName + " succesful!','success')", true);
                lblMsg.Visible = true;
                lblMsg.Text = "Brand " + actionName + " successfully!";
                lblMsg.CssClass = "alert alert-success";
                getBrands();
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

        protected void rBrand_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label lbl = e.Item.FindControl("lblIsActive") as Label;
                if (lbl.Text == "True")
                {
                    lbl.Text = "Active";
                    lbl.CssClass = "badge badge-success";
                }
                else
                {
                    lbl.Text = "In-Active";
                    lbl.CssClass = "badge badge-danger";
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            clear();
        }

        private void clear()
        {
            txtBrandName.Value = string.Empty;
            chkIsActive.Checked = false;
            hdnBrandId.Value = "0";
            btnAddOrUpdate.Text = "Add";
        }
    }
}