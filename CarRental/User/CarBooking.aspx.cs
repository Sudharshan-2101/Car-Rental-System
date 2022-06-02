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
    public partial class CarBooking : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        SqlDataReader sdr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else if(Request.QueryString["id"] == null)
                {
                    btnBooking.Enabled = false;
                }
                getPrice();
            }
        }

        private void getPrice()
        {
            if(Request.QueryString["id"] != null)
            {
                try
                {
                    con = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("Vehicle_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "PRICEBYID");                    
                    cmd.Parameters.AddWithValue("@VehicleId", Request.QueryString["id"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    con.Open();
                    sdr = cmd.ExecuteReader();
                    while(sdr.Read())
                    {
                        hdnPrice.Value = sdr["PricePerKM"].ToString();
                    }
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
        }

        protected void btnBooking_Click(object sender, EventArgs e)
        {
            DateTime pickUpDate = Convert.ToDateTime(txtPickUpDate.Value);
            DateTime dropOffDate = Convert.ToDateTime(txtDropOffDate.Value);
            TimeSpan timeSpan = new TimeSpan(1, 0, 0);
            TimeSpan selectedTime = TimeSpan.Parse(txtPickUpTime.Value).Subtract(timeSpan);
            TimeSpan currentTime = DateTime.Now.TimeOfDay;
            if (pickUpDate < DateTime.Now.Date)
            {
                Response.Write("<script>alert('Pick-up date cannot be less than current date!');</script>");
            }
            else if (dropOffDate < pickUpDate)
            {
                Response.Write("<script>alert('Drop-off date cannot be less than pick-up date!');</script>");
            }
            else if (pickUpDate == DateTime.Now.Date && currentTime >= selectedTime)
            {
                Response.Write("<script>alert('Pick-up time cannot be greater than current time(current time + 1 hour) for today!');</script>");
            }
            else
            {
                if(Session["userId"] != null)
                {
                    bookACar(pickUpDate,dropOffDate,selectedTime,Convert.ToDecimal(txtDistance.Value),Convert.ToDecimal(hdnDiscountedPrice.Value));
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }
            
        }

        private void bookACar(DateTime pickUpDate, DateTime dropOffDate, TimeSpan pickUpTime, decimal distance, decimal discountedPrice)
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Booking_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "INSERT");
                cmd.Parameters.AddWithValue("@PickUpDate", pickUpDate);
                cmd.Parameters.AddWithValue("@DropOffDate", dropOffDate);
                cmd.Parameters.AddWithValue("@PickUpTime", pickUpTime);
                cmd.Parameters.AddWithValue("@Distance", distance);
                cmd.Parameters.AddWithValue("@Price", discountedPrice);
                cmd.Parameters.AddWithValue("@VehicleId", Request.QueryString["id"]);
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmd.Parameters.AddWithValue("@Status", "Not Yet Confirm");
                cmd.Parameters.AddWithValue("@IsDeleted", false);
                cmd.CommandType = CommandType.StoredProcedure;
                con.Open();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Booking done successful. <a href='Profile.aspx'>Click</a> to view your booking history";
                lblMsg.CssClass = "alert alert-success";
                Response.AddHeader("REFRESH", "2;URL=Profile.aspx");
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