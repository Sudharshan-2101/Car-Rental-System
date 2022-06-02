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
    public partial class Bookings : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        SqlDataReader sdr;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breadCrum"] = "Car Bookings";
                if (Session["admin"] != null)
                {
                    getPurchaseHistory();
                }
                else
                {
                    Response.Redirect("../User/Login.aspx");
                }
                pnledit.Visible = false;
            }
            lblMsg.Visible = false;
        }

        private void getPurchaseHistory()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Booking_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT4ADMIN");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCarBookList.DataSource = dt;
            rCarBookList.DataBind();
        }

        protected void rCarBookList_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                pnledit.Visible = true;
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Booking_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@BookingId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    sdr = cmd.ExecuteReader();
                    while (sdr.Read())
                    {
                        txtOdoMeterStart.Value = sdr["OdoMeterStart"].ToString();
                        txtOdoMeterEnd.Value = sdr["OdoMeterEnd"].ToString();
                        txtDistance.Value = sdr["Distance"].ToString();
                        txtPrice.Value = sdr["Price"].ToString();
                        ddlStatus.SelectedValue = sdr["Status"].ToString();
                        hdnPrice.Value = sdr["PricePerKM"].ToString();
                        hdnBookingId.Value = sdr["BookingId"].ToString();
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
            }
            else if (e.CommandName == "delete")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Booking_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@BookingId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    lblMsg.Visible = true;
                    lblMsg.Text = "Booking deleted successfully!";
                    lblMsg.CssClass = "alert alert-success";
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

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Booking_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "UPDATEBYADMIN");
            cmd.Parameters.AddWithValue("@BookingId", hdnBookingId.Value);
            cmd.Parameters.AddWithValue("@OdoMeterStart", txtOdoMeterStart.Value);
            cmd.Parameters.AddWithValue("@OdoMeterEnd", txtOdoMeterEnd.Value);
            cmd.Parameters.AddWithValue("@Distance", txtDistance.Value);
            cmd.Parameters.AddWithValue("@Price", txtPrice.Value);
            cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
            cmd.CommandType = CommandType.StoredProcedure;
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Booking updated successfully!";
                lblMsg.CssClass = "alert alert-success";
                getPurchaseHistory();
                pnledit.Visible = false;
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

        protected void btnClear_Click(object sender, EventArgs e)
        {
            pnledit.Visible = false;
        }
    }
}