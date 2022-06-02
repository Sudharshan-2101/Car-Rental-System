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
    public partial class Cars : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getBrands();
                getCars();
            }
        }

        private void getBrands()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Brand_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVEBRAND");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            ddlBrand.DataSource = dt;
            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "BrandId";
            ddlBrand.DataBind();
        }

        private void getCars()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Vehicle_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            bindData(dt);
        }

        protected void ddlBrand_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlBrand.SelectedValue != "0")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Vehicle_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYBRAND");
                cmd.Parameters.AddWithValue("@BrandId", Convert.ToInt32(ddlBrand.SelectedValue));
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                bindData(dt);
            }
            else
            {
                getCars();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Vehicle_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SEARCHBYNAME");
                cmd.Parameters.AddWithValue("@Name", txtSearch.Text.Trim());
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                bindData(dt);
                txtSearch.Text = string.Empty;
            }
        }

        void bindData(DataTable dt)
        {
            if (dt.Rows.Count > 0)
            {
                rCars.DataSource = dt;
            }
            else
            {
                rCars.DataSource = dt;
                rCars.FooterTemplate = null;
                rCars.FooterTemplate = new CustomTemplate(ListItemType.Footer);
            }
            rCars.DataBind();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            getCars();
            txtSearch.Text = string.Empty;
            ddlBrand.ClearSelection();
        }

        // Custom template class to add controls to the repeater's header, item and footer sections.
        private sealed class CustomTemplate : ITemplate
        {
            private ListItemType ListItemType { get; set; }

            public CustomTemplate(ListItemType type)
            {
                ListItemType = type;
            }

            public void InstantiateIn(Control container)
            {
                if (ListItemType == ListItemType.Footer)
                {
                    var footer = new LiteralControl("<div class='col-5'><b class='pl-3'>No car to display.</b></div>");
                    container.Controls.Add(footer);
                }
            }
        }

        protected void rCars_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            //if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            //{
            //    HyperLink a = e.Item.FindControl("lbBuyNow") as HyperLink;
            //    string val = a.NavigateUrl.ToString();
            //    string carId = val.Substring(val.IndexOf("=") + 1);
            //    con = new SqlConnection(Connection.GetConnectionString());
            //    cmd = new SqlCommand("Order_Crud", con);
            //    cmd.Parameters.AddWithValue("@Action", "GETBYCARID");
            //    cmd.Parameters.AddWithValue("@VehicleId", Convert.ToInt32(carId));
            //    cmd.CommandType = CommandType.StoredProcedure;
            //    sda = new SqlDataAdapter(cmd);
            //    dt = new DataTable();
            //    sda.Fill(dt);
            //    if (dt.Rows.Count > 0)
            //    {
            //        a.Text = "Sold Out";
            //        a.Enabled = false;
            //        a.CssClass = "btn btn-light py-2 mr-1";
            //    }
            //}
        }
    }
}