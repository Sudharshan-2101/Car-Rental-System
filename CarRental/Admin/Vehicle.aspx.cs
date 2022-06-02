using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental.Admin
{
    public partial class Vehicle : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                getBrands();
                if (Request.QueryString["id"] != null)
                {
                    getVehicleDetails();
                }
                Session["breadCrum"] = "Vehicle";
            }
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
            ddlBrand.DataSource = dt;
            ddlBrand.DataTextField = "BrandName";
            ddlBrand.DataValueField = "BrandId";
            ddlBrand.DataBind();
        }

        void getVehicleDetails()
        {
            if (Request.QueryString["id"] != null)
            {
                int vehicleId = Convert.ToInt32(Request.QueryString["id"]);
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Vehicle_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "GETBYID");
                cmd.Parameters.AddWithValue("@VehicleId", vehicleId);
                cmd.CommandType = CommandType.StoredProcedure;
                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);
                if (dt.Rows.Count > 0)
                {
                    txtVehicleName.Value = dt.Rows[0]["Name"].ToString();
                    ddlBrand.SelectedValue = dt.Rows[0]["BrandId"].ToString();
                    txtDescription.Value = dt.Rows[0]["Description"].ToString();
                    txtPrice.Value = dt.Rows[0]["PricePerKM"].ToString();
                    txtSeatingCapacity.Value = dt.Rows[0]["SeatingCapacity"].ToString();
                    ddlFuelType.SelectedValue = dt.Rows[0]["FuelType"].ToString();
                    txtMileage.Value = dt.Rows[0]["Mileage"].ToString();
                    ddlLuggage.SelectedValue = dt.Rows[0]["Luggage"].ToString();
                    ddlTransmission.SelectedValue = dt.Rows[0]["Transmission"].ToString();
                    cbIsActive.Checked = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
                    cbAirConditioner.Checked = Convert.ToBoolean(dt.Rows[0]["Air_Conditioner"]);
                    cbPowerDoorLocks.Checked = Convert.ToBoolean(dt.Rows[0]["Power_Door_Locks"]);
                    cbAntilockBrackingSystem.Checked = Convert.ToBoolean(dt.Rows[0]["Antilock_Bracking_System"]);
                    cbPowerSteering.Checked = Convert.ToBoolean(dt.Rows[0]["Power_Steering"]);
                    cbChildSeat.Checked = Convert.ToBoolean(dt.Rows[0]["Child_Seat"]);
                    cbPassengersAirbag.Checked = Convert.ToBoolean(dt.Rows[0]["Passengers_Airbag"]);
                    cbMusic.Checked = Convert.ToBoolean(dt.Rows[0]["Music"]);
                    cbClimateControl.Checked = Convert.ToBoolean(dt.Rows[0]["Climate_Control"]);
                    cbGPS.Checked = Convert.ToBoolean(dt.Rows[0]["GPS"]);
                    cbSeatBealt.Checked = Convert.ToBoolean(dt.Rows[0]["Seat_Bealt"]);
                    cbBluetooth.Checked = Convert.ToBoolean(dt.Rows[0]["Bluetooth"]);
                    cbRemoteCentralLocking.Checked = Convert.ToBoolean(dt.Rows[0]["Remote_Central_Locking"]);
                    imgCar.ImageUrl = string.IsNullOrEmpty(dt.Rows[0]["ImageUrl"].ToString()) ? "../Images/No_image.png" : "../" + dt.Rows[0]["ImageUrl"].ToString();
                    imgCar.Width = 200;
                    btnAddOrUpdate.Text = "Update";
                }
            }
        }

        protected void btnAddOrUpdate_Click(object sender, EventArgs e)
        {
            string actionName = string.Empty, imagePath = string.Empty, fileExtension = string.Empty;
            bool isValidToExecute = false;
            int carId = Request.QueryString["id"] == null ? 0 : Convert.ToInt32(Request.QueryString["id"]);
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Vehicle_Crud", con);
            cmd.Parameters.AddWithValue("@Action", carId == 0 ? "INSERT" : "UPDATE");
            cmd.Parameters.AddWithValue("@VehicleId", carId);
            cmd.Parameters.AddWithValue("@Name", txtVehicleName.Value.Trim());
            cmd.Parameters.AddWithValue("@Description", txtDescription.Value.Trim());
            cmd.Parameters.AddWithValue("@BrandId", ddlBrand.SelectedValue);
            cmd.Parameters.AddWithValue("@PricePerKM", txtPrice.Value.Trim());
            cmd.Parameters.AddWithValue("@SeatingCapacity", txtSeatingCapacity.Value.Trim());
            cmd.Parameters.AddWithValue("@FuelType", ddlFuelType.SelectedValue);
            cmd.Parameters.AddWithValue("@Mileage", txtMileage.Value.Trim());
            cmd.Parameters.AddWithValue("@Luggage", ddlLuggage.SelectedValue);
            cmd.Parameters.AddWithValue("@Transmission", ddlTransmission.SelectedValue);
            cmd.Parameters.AddWithValue("@IsActive", cbIsActive.Checked);
            cmd.Parameters.AddWithValue("@Air_Conditioner", cbAirConditioner.Checked);
            cmd.Parameters.AddWithValue("@Power_Door_Locks", cbPowerDoorLocks.Checked);
            cmd.Parameters.AddWithValue("@Antilock_Bracking_System", cbAntilockBrackingSystem.Checked);
            cmd.Parameters.AddWithValue("@Power_Steering", cbPowerSteering.Checked);
            cmd.Parameters.AddWithValue("@Child_Seat", cbChildSeat.Checked);
            cmd.Parameters.AddWithValue("@Passengers_Airbag", cbPassengersAirbag.Checked);
            cmd.Parameters.AddWithValue("@Music", cbMusic.Checked);
            cmd.Parameters.AddWithValue("@Climate_Control", cbClimateControl.Checked);
            cmd.Parameters.AddWithValue("@GPS", cbGPS.Checked);
            cmd.Parameters.AddWithValue("@Seat_Bealt", cbSeatBealt.Checked);
            cmd.Parameters.AddWithValue("@Bluetooth", cbBluetooth.Checked);
            cmd.Parameters.AddWithValue("@Remote_Central_Locking", cbRemoteCentralLocking.Checked);
            if (fuVehicleImage.HasFile)
            {
                if (Utils.IsValidExtension(fuVehicleImage.FileName))
                {
                    object obj = Utils.GetUniqueId();
                    fileExtension = Path.GetExtension(fuVehicleImage.FileName);
                    imagePath = "Images/Car/" + obj.ToString() + fileExtension;
                    fuVehicleImage.PostedFile.SaveAs(Server.MapPath("~/Images/Car/") + obj.ToString() + fileExtension);
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
                    actionName = carId == 0 ? "inserted" : "updated";
                    lblMsg.Visible = true;
                    lblMsg.Text = "Car " + actionName + " successfully!";
                    lblMsg.CssClass = "alert alert-success";
                    clear();
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

        private void clear()
        {
            txtVehicleName.Value = string.Empty;
            ddlBrand.ClearSelection();
            txtDescription.Value = string.Empty;
            txtPrice.Value = string.Empty;
            txtSeatingCapacity.Value = string.Empty;
            ddlFuelType.ClearSelection();
            txtMileage.Value = string.Empty;
            ddlLuggage.ClearSelection();
            ddlTransmission.ClearSelection();
            cbIsActive.Checked = false;
            cbAirConditioner.Checked = false;
            cbPowerDoorLocks.Checked = false;
            cbAntilockBrackingSystem.Checked = false;
            cbPowerSteering.Checked = false;
            cbChildSeat.Checked = false;
            cbPassengersAirbag.Checked = false;
            cbMusic.Checked = false;
            cbClimateControl.Checked = false;
            cbGPS.Checked = false;
            cbSeatBealt.Checked = false;
            cbBluetooth.Checked = false;
            cbRemoteCentralLocking.Checked = false;
            btnAddOrUpdate.Text = "Add";
            imgCar.ImageUrl = "";
        }

    }
}