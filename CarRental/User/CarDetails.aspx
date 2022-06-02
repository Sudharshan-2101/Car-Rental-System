<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="CarDetails.aspx.cs" Inherits="CarRental.User.CarDetails" %>
<%@ Import Namespace="CarRental" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('../UserTemplate/images/bg_3.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
                <div class="col-md-9 ftco-animate pb-5">
                    <p class="breadcrumbs"><span class="mr-2"><a href="Default.aspx">Home <i class="ion-ios-arrow-forward"></i></a></span><span>Car details <i class="ion-ios-arrow-forward"></i></span></p>
                    <h1 class="mb-3 bread">Car Details</h1>
                </div>
            </div>
        </div>
    </section>


    <section class="ftco-section ftco-car-details">
        <div class="container">
            <asp:Repeater ID="rCarDetails" runat="server">
                <ItemTemplate>
                    <div class="row justify-content-center">
                        <div class="col-md-12">
                            <div class="car-details">
                                <div class="img rounded" style="background-image: url('<%# Utils.GetImageUrl( Eval("ImageUrl")) %>');"></div>
                                <div class="text text-center">
                                    <span class="subheading"><%#Eval("BrandName") %></span>
                                    <h2><%#Eval("Name") %></h2>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md d-flex align-self-stretch ftco-animate">
                            <div class="media block-6 services">
                                <div class="media-body py-md-4">
                                    <div class="d-flex mb-3 align-items-center">
                                        <div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-dashboard"></span></div>
                                        <div class="text">
                                            <h3 class="heading mb-0 pl-3">Mileage
		                
                                        <span><%#Eval("Mileage") %></span>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md d-flex align-self-stretch ftco-animate">
                            <div class="media block-6 services">
                                <div class="media-body py-md-4">
                                    <div class="d-flex mb-3 align-items-center">
                                        <div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-pistons"></span></div>
                                        <div class="text">
                                            <h3 class="heading mb-0 pl-3">Transmission
		                
                                        <span><%#Eval("Transmission") %></span>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md d-flex align-self-stretch ftco-animate">
                            <div class="media block-6 services">
                                <div class="media-body py-md-4">
                                    <div class="d-flex mb-3 align-items-center">
                                        <div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-car-seat"></span></div>
                                        <div class="text">
                                            <h3 class="heading mb-0 pl-3">Seats
		                
                                        <span><%#Eval("SeatingCapacity") %></span>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md d-flex align-self-stretch ftco-animate">
                            <div class="media block-6 services">
                                <div class="media-body py-md-4">
                                    <div class="d-flex mb-3 align-items-center">
                                        <div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-backpack"></span></div>
                                        <div class="text">
                                            <h3 class="heading mb-0 pl-3">Luggage
		                
                                        <span><%#Eval("Luggage") %></span>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md d-flex align-self-stretch ftco-animate">
                            <div class="media block-6 services">
                                <div class="media-body py-md-4">
                                    <div class="d-flex mb-3 align-items-center">
                                        <div class="icon d-flex align-items-center justify-content-center"><span class="flaticon-diesel"></span></div>
                                        <div class="text">
                                            <h3 class="heading mb-0 pl-3">Fuel
		                
                                        <span><%#Eval("FuelType") %></span>
                                            </h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12 pills">
                            <div class="bd-example bd-example-tabs">
                                <div class="d-flex justify-content-center">
                                    <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">

                                        <li class="nav-item">
                                            <a class="nav-link active" id="pills-description-tab" data-toggle="pill" href="#pills-description" role="tab" aria-controls="pills-description" aria-expanded="true">Features</a>
                                        </li>
                                        <li class="nav-item">
                                            <a class="nav-link" id="pills-manufacturer-tab" data-toggle="pill" href="#pills-manufacturer" role="tab" aria-controls="pills-manufacturer" aria-expanded="true">Description</a>
                                        </li>
                                    </ul>
                                </div>

                                <div class="tab-content" id="pills-tabContent">
                                    <div class="tab-pane fade show active" id="pills-description" role="tabpanel" aria-labelledby="pills-description-tab">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <ul class="features">
                                                    <li class='<%# ((bool)Eval("Air_Conditioner")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Air_Conditioner")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Air Conditioner</li>
                                                    <li class='<%# ((bool)Eval("Child_Seat")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Child_Seat")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Child Seat</li>
                                                    <li class='<%# ((bool)Eval("Passengers_Airbag")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Passengers_Airbag")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Passengers Airbag</li>
                                                    <li class='<%# ((bool)Eval("Music")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Music")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Music</li>
                                                </ul>
                                            </div>
                                            <div class="col-md-4">
                                                <ul class="features">
                                                    <li class='<%# ((bool)Eval("Seat_Bealt")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Seat_Bealt")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Seat Belt</li>
                                                    <li class='<%# ((bool)Eval("Bluetooth")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Bluetooth")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Bluetooth</li>
                                                    <li class='<%# ((bool)Eval("Power_Steering")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Power_Steering")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Power Steering</li>
                                                    <li class='<%# ((bool)Eval("GPS")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("GPS")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>GPS</li>
                                                </ul>
                                            </div>
                                            <div class="col-md-4">
                                                <ul class="features">
                                                    <li class='<%# ((bool)Eval("Antilock_Bracking_System")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Antilock_Bracking_System")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Antilock Bracking System</li>
                                                    <li class='<%# ((bool)Eval("Power_Door_Locks")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Power_Door_Locks")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Power Door Locks</li>
                                                    <li class='<%# ((bool)Eval("Remote_Central_Locking")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Remote_Central_Locking")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Remote central locking</li>
                                                    <li class='<%# ((bool)Eval("Climate_Control")) == false ? "remove" : "check" %>'><span class='<%# ((bool)Eval("Climate_Control")) == false ? "ion-ios-close" : "ion-ios-checkmark" %>'></span>Climate control</li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="tab-pane fade" id="pills-manufacturer" role="tabpanel" aria-labelledby="pills-manufacturer-tab">
                                        <p><%#Eval("Description") %></p>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 text-center">
                            <a href='<%# "CarBooking.aspx?id=" +Eval("VehicleId") %>' class="btn btn-primary py-2 px-5"><span class="flaticon-rent"></span> Book Now</a>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>

</asp:Content>
