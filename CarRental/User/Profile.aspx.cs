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
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] != null)
                {
                    getUserDetails();
                    getPurchaseHistory();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        private void getUserDetails()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("User_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rProfile.DataSource = dt;
            rProfile.DataBind();
        }

        private void getPurchaseHistory()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Booking_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECTBYUSERID");
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            if (dt.Rows.Count > 0)
            {
                rBookingHistory.DataSource = dt;
            }
            else
            {
                rBookingHistory.DataSource = dt;
                rBookingHistory.FooterTemplate = null;
                rBookingHistory.FooterTemplate = new CustomTemplate(ListItemType.Footer);
            }
            rBookingHistory.DataBind();
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
                    var footer = new LiteralControl("<tr><td class='col-5' colspan='5'><b class='pl-3'>No record to display.</b></td></tr></tbody></table>");
                    container.Controls.Add(footer);
                }
            }
        }

        protected void rBookingHistory_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "cancel")
            {
                Label lblStatus = e.Item.FindControl("lblStatus") as Label;
                if(lblStatus.Text == "Returned")
                {
                    Response.Write("<script>alert('Booking with Returned status cannot be deleted!');</script>");
                }
                else
                {
                    con = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("Booking_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "CANCELBOOKING");
                    cmd.Parameters.AddWithValue("@BookingId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@IsDeleted", true);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        //lblMsg.Visible = true;
                        //lblMsg.Text = "Ordered deleted successfully!";
                        //lblMsg.CssClass = "alert alert-success";
                        Response.Write("<script>alert('Booking cancelled successfully!');</script>");
                        getPurchaseHistory();
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
        }
    }
}