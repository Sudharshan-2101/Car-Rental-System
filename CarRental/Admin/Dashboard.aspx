<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="CarRental.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
                <div class="card-header card-header-warning card-header-icon">
                    <div class="card-icon">
                        <i class="material-icons">local_offer</i>
                    </div>
                    <p class="card-category">Brands</p>
                    <h3 class="card-title">
                        <% Response.Write(Session["brand"]); %><%--<small>GB</small>--%>
                  </h3>
                </div>
                <div class="card-footer">
                    <div class="stats">
                        <i class="material-icons">visibility</i>
                        <a href="Brand.aspx">View Details</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
                <div class="card-header card-header-success card-header-icon">
                    <div class="card-icon">
                        <i class="material-icons">directions_car</i>
                    </div>
                    <p class="card-category">Vehicles</p>
                    <h3 class="card-title">
                        <% Response.Write(Session["car"]); %>
                    </h3>
                </div>
                <div class="card-footer">
                    <div class="stats">
                        <i class="material-icons">visibility</i>
                        <a href="VehicleList.aspx">View Details</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
                <div class="card-header card-header-danger card-header-icon">
                    <div class="card-icon">
                        <i class="material-icons">card_travel</i>
                    </div>
                    <p class="card-category">Bookings</p>
                    <h3 class="card-title">
                        <% Response.Write(Session["booking"]); %>
                    </h3>
                </div>
                <div class="card-footer">
                    <div class="stats">
                        <i class="material-icons">visibility</i>
                        <a href="Bookings.aspx">View Details</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
                <div class="card-header card-header-info card-header-icon">
                    <div class="card-icon">
                        <i class="material-icons">person</i>
                    </div>
                    <p class="card-category">Users</p>
                    <h3 class="card-title">
                        <% Response.Write(Session["user"]); %>
                    </h3>
                </div>
                <div class="card-footer">
                    <div class="stats">
                        <i class="material-icons">visibility</i>
                        <a href="Users.aspx">View Details</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="card card-stats">
                <div class="card-header card-header-warning card-header-icon">
                    <div class="card-icon">
                        <i class="material-icons">contact_support</i>
                    </div>
                    <p class="card-category">Contact</p>
                    <h3 class="card-title">
                        <% Response.Write(Session["contact"]); %>
                  </h3>
                </div>
                <div class="card-footer">
                    <div class="stats">
                        <i class="material-icons">visibility</i>
                        <a href="Brand.aspx">View Details</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
