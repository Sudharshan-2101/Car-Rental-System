<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Cars.aspx.cs" Inherits="CarRental.User.Cars" %>
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
                        <span>Cars <i class="ion-ios-arrow-forward"></i></span>
                    </p>
                    <h1 class="mb-3 bread">Choose Your Car</h1>
                </div>
            </div>
        </div>
    </section>

    <section class="bg-light">
        <div class="container pt-4">
            <div class="row">
                <div class="col-4">
                    <asp:DropDownList ID="ddlBrand" runat="server" AppendDataBoundItems="true" AutoPostBack="true" OnSelectedIndexChanged="ddlBrand_SelectedIndexChanged"
                        CssClass="form-control mt-1" Font-Size="Medium">
                        <asp:ListItem Value="0">Filter By Brand</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-4">
                    <div class="input-group p-md-1">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search Products" Font-Size="Medium"></asp:TextBox>
                        <div class="input-group-append">
                            <asp:LinkButton ID="btnSearch" runat="server" class="form-control pt-3" OnClick="btnSearch_Click">
                                <i class="icon-search"></i>
                            </asp:LinkButton>
                        </div>
                        <div class="input-group-append">
                            <asp:LinkButton ID="btnReset" runat="server" class="form-control pt-3" OnClick="btnReset_Click">
                                <i class="icon-refresh"></i>
                            </asp:LinkButton>
                        </div>
                    </div>
                </div>
                <div class="col-4">
                </div>
            </div>
        </div>
    </section>

    <section class="ftco-section bg-light">
        <div class="container">
            <div class="row">
                <asp:Repeater ID="rCars" runat="server" OnItemDataBound="rCars_ItemDataBound">
                    <ItemTemplate>
                        <div class="col-md-4">
                            <div class="car-wrap rounded ftco-animate">
                                <div class="img rounded d-flex align-items-end" style="background-image: url('<%# Utils.GetImageUrl( Eval("ImageUrl")) %>');">
                                </div>
                                <div class="text">
                                    <h2 class="mb-0"><a href='<%# "CarDetails.aspx?id=" +Eval("VehicleId") %>'><%#Eval("Name") %> </a></h2>
                                    <div class="d-flex mb-3">
                                        <span class="cat"><%#Eval("BrandName") %></span>
                                        <p class="price ml-auto">₹<%#Eval("PricePerKM") %> <span>/KM</span></p>
                                    </div>
                                    <p class="d-flex mb-0 d-block">
                                        <asp:HyperLink ID="lbBuyNow" runat="server" NavigateUrl='<%# "CarBooking.aspx?id=" +Eval("VehicleId") %>'
                                            CssClass="btn btn-primary py-2 mr-1" Text="Book Now"></asp:HyperLink>
                                        <a href='<%# "CarDetails.aspx?id=" +Eval("VehicleId") %>' class="btn btn-secondary py-2 ml-1">Details</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

            </div>
        </div>
    </section>



</asp:Content>
