using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CarRental.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                Session["breadCrum"] = "Dashboard";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../User/Login.aspx");
                }
                else
                {
                    DashboardCount dashboard = new DashboardCount();
                    Session["brand"] = Convert.ToInt32(dashboard.Count("BRAND"));
                    Session["car"] = Convert.ToInt32(dashboard.Count("CAR"));
                    Session["booking"] = Convert.ToInt32(dashboard.Count("BOOKING"));
                    Session["user"] = Convert.ToInt32(dashboard.Count("USER"));
                    Session["contact"] = Convert.ToInt32(dashboard.Count("CONTACTS"));
                }
            }
        }
    }
}