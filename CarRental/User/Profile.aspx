<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="CarRental.User.Profile" %>

<%@ Import Namespace="CarRental" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../UserTemplate/css/css/UserProfile.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('../UserTemplate/images/bg_3.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
                <div class="col-md-9 ftco-animate pb-5">
                    <p class="breadcrumbs">
                        <span class="mr-2">
                            <a href="Default.aspx">Home <i class="ion-ios-arrow-forward"></i></a>
                        </span>
                        <span>Profile <i class="ion-ios-arrow-forward"></i></span>
                    </p>
                    <h1 class="mb-3 bread">User Profile & Purchase History</h1>
                </div>
            </div>
        </div>
    </section>

    <section class="ftco-section bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-12">

                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                        <li class="nav-item">
                            <a class="nav-link active" id="pills-home-tab" data-toggle="pill" href="#pills-home" role="tab" aria-controls="pills-home" aria-selected="true">Profile</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" id="pills-profile-tab" data-toggle="pill" href="#pills-profile" role="tab" aria-controls="pills-profile" aria-selected="false">History</a>
                        </li>
                    </ul>
                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">
                            <div class="page-content page-container" id="page-content">
                                <div class="padding">
                                    <div class="row container d-flex justify-content-center">
                                        <asp:Repeater ID="rProfile" runat="server">
                                            <ItemTemplate>
                                                <div class="col-xl-12 col-md-12">
                                                    <div class="card user-card-full">
                                                        <div class="row m-l-0 m-r-0">
                                                            <div class="col-sm-4 bg-c-lite-green user-profile">
                                                                <div class="card-block text-center text-white">
                                                                    <div class="m-b-25">
                                                                        <img src="<%# Utils.GetImageUrl( Eval("ImageUrl")) %>" class="img-radius" width="150" alt="User-Image">
                                                                    </div>
                                                                    <h6 class="f-w-600"><%# Eval("Name") %></h6>
                                                                    <p>@<%# Eval("Username") %></p>
                                                                    <a href='<%# "Registration.aspx?id=" +Eval("UserId") %>' class="btn btn-info">
                                                                        <i class=" mdi mdi-square-edit-outline feather icon-edit m-t-10 f-16"></i>
                                                                    </a>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-8">
                                                                <div class="card-block">
                                                                    <h6 class="m-b-20 p-b-5 b-b-default f-w-600">Information</h6>
                                                                    <div class="row">
                                                                        <div class="col-sm-6">
                                                                            <p class="m-b-10 f-w-600">Email</p>
                                                                            <h6 class="text-muted f-w-400"><%# Eval("Email") %></h6>
                                                                        </div>
                                                                        <div class="col-sm-6">
                                                                            <p class="m-b-10 f-w-600">Phone</p>
                                                                            <h6 class="text-muted f-w-400"><%# Eval("Mobile") %></h6>
                                                                        </div>
                                                                    </div>
                                                                    <h6 class="m-b-20 p-b-5 b-b-default f-w-600"></h6>
                                                                    <div class="row">
                                                                        <div class="col-sm-12">
                                                                            <p class="m-b-10 f-w-600">Address</p>
                                                                            <h6 class="text-muted f-w-400"><%# Eval("Address") %></h6>
                                                                        </div>
                                                                    </div>
                                                                    <h6 class="m-b-20 p-b-5 b-b-default f-w-600"></h6>
                                                                    <div class="row">
                                                                        <div class="col-sm-6">
                                                                            <p class="m-b-10 f-w-600">Post Code</p>
                                                                            <h6 class="text-muted f-w-400"><%# Eval("PostCode") %></h6>
                                                                        </div>
                                                                        <div class="col-sm-6">
                                                                            <p class="m-b-10 f-w-600">Joined Date</p>
                                                                            <h6 class="text-muted f-w-400"><%# Eval("CreatedDate") %></h6>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:Repeater>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-header card-header-primary">
                                            <h4 class="card-title">Booking History</h4>
                                        </div>
                                        <div class="card-body table-responsive">
                                            <asp:Repeater ID="rBookingHistory" runat="server" OnItemCommand="rBookingHistory_ItemCommand">
                                                <HeaderTemplate>
                                                    <table class="data-table table hover nowrap" id="example_table">
                                                        <thead class="text-primary">
                                                            <tr>
                                                                <th class="table-plus datatable-nosort">#</th>
                                                                <th>Pick-Up Date</th>
                                                                <th>Drop-Off Date</th>
                                                                <th>Pick-Up Time</th>
                                                                <th>Name</th>
                                                                <th>KM</th>
                                                                <th>Price(₹)</th>
                                                                <th>Status</th>
                                                                <th>Booking Date</th>
                                                                <th></th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                </HeaderTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td class="table-plus"><%# Eval("SrNo") %></td>
                                                        <td><%# Eval("PickUpDate","{0:dd-MM-yyyy}") %></td>
                                                        <td><%# Eval("DropOffDate","{0:dd-MM-yyyy}") %></td>
                                                        <td><%# Eval("PickUpTime") %></td>
                                                        <td>
                                                            <a href='<%# "CarDetails.aspx?id=" +Eval("VehicleId") %>'
                                                                title="Click to view Vehicle details"><%# Eval("Name") %> </a>
                                                        </td>
                                                        <td><%# Eval("Distance") %></td>
                                                        <td><%# Eval("Price") %></td>
                                                        <td>
                                                            <asp:Label ID="lblStatus" runat="server"
                                                                Text='<%# Eval("Status") %>'
                                                                CssClass='<%# Eval("Status").ToString()  == "Not Yet Confirm" 
                                                                    ? "badge badge-warning" : Eval("Status").ToString() == "Confirmed" 
                                                                    ? "badge badge-success" : Eval("Status").ToString() == "Cancelled" 
                                                                    ? "badge badge-danger" : Eval("Status").ToString() == "Rented" 
                                                                    ? "badge badge-primary" : "badge badge-info" %>'>
                                                            </asp:Label>
                                                        </td>
                                                        <td><%# Eval("BookingDate","{0:dd-MM-yyyy}") %></td>
                                                        <td>
                                                            <asp:LinkButton ID="lnkCancel" runat="server" CommandName="cancel" CommandArgument='<%# Eval("BookingId") %>'
                                                                CssClass="badge badge-danger" ToolTip="Cancel your booking">
                                                                <i>x</i>
                                                            </asp:LinkButton>
                                                        </td>
                                                    </tr>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    </tbody>
                                                    </table>
                                                </FooterTemplate>
                                            </asp:Repeater>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

</asp:Content>
