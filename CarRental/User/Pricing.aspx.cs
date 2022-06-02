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
    public partial class Pricing : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                getCars();
            }
        }

        private void getCars()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Vehicle_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "CARPRICING");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rPricing.DataSource = dt;
            rPricing.DataBind();
        }
    }
}