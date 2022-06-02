<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Pricing.aspx.cs" Inherits="CarRental.User.Pricing" %>
<%@ Import Namespace="CarRental" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                        <span>Pricing <i class="ion-ios-arrow-forward"></i></span>
                    </p>
                    <h1 class="mb-3 bread">Pricing</h1>
                </div>
            </div>
        </div>
    </section>

    <section class="ftco-section ftco-cart">
        <div class="container">
            <div class="row">
                <div class="col-md-12 ftco-animate">
                    <div class="car-list">
                        <asp:Repeater ID="rPricing" runat="server">
                            <HeaderTemplate>
                                <table class="table">
                                    <thead class="thead-primary">
                                        <tr class="text-center">
                                            <th>&nbsp;</th>
                                            <th>&nbsp;</th>
                                            <th class="bg-primary heading">Per Day Rate</th>
                                            <th class="bg-dark heading">Per Week Rate</th>
                                            <th class="bg-black heading">Leasing</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <tr class="">
                                    <td class="car-image">
                                        <div class="img" style="background-image: url('<%# Utils.GetImageUrl( Eval("ImageUrl")) %>');"></div>
                                    </td>
                                    <td class="product-name">
                                        <h3><a href='<%# "CarDetails.aspx?id=" +Eval("VehicleId") %>'><%#Eval("Name") %> </a></h3>
                                        <%--<p class="mb-0 rated">
                                            <span>rated:</span>
                                            <span class="ion-ios-star"></span>
                                            <span class="ion-ios-star"></span>
                                            <span class="ion-ios-star"></span>
                                            <span class="ion-ios-star"></span>
                                            <span class="ion-ios-star"></span>
                                        </p>--%>
                                        <p class="btn btn-secondary"><a href='<%# "CarBooking.aspx?id=" +Eval("VehicleId") %>' title="Click to view details"
                                            class="text-white">Rent a car</a></p>
                                    </td>

                                    <td class="price">
                                        <%--<p class="btn-custom"><a href="#">Rent a car</a></p>--%>
                                        <div class="price-rate">
                                            <h3>
                                                <span class="num"><small class="currency">₹</small> <%#Eval("DayPrice") %></span>
                                                <span class="per">/per day</span>
                                            </h3>
                                            <span class="subheading">₹99/hour fuel surcharges</span>
                                        </div>
                                    </td>

                                    <td class="price">
                                        <%--<p class="btn-custom"><a href="#">Rent a car</a></p>--%>
                                        <div class="price-rate">
                                            <h3>
                                                <span class="num"><small class="currency">₹</small> <%#Eval("WeekPrice") %></span>
                                                <span class="per">/per week</span>
                                            </h3>
                                            <span class="subheading">₹95/hour fuel surcharges</span>
                                        </div>
                                    </td>

                                    <td class="price">
                                        <%--<p class="btn-custom"><a href="#">Rent a car</a></p>--%>
                                        <div class="price-rate">
                                            <h3>
                                                <span class="num"><small class="currency">₹</small> <%#Eval("MonthPrice") %></span>
                                                <span class="per">/per month</span>
                                            </h3>
                                            <span class="subheading">₹90/hour fuel surcharges</span>
                                        </div>
                                    </td>
                                </tr>
                                <!-- END TR-->
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
    </section>



</asp:Content>
