<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="CarBooking.aspx.cs" Inherits="CarRental.User.CarBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function calculate() {
            var pricePerKM = document.getElementById("<%=hdnPrice.ClientID %>").value;
            var noOfKilometer = document.getElementById("<%=txtDistance.ClientID %>").value;
            var actualPrice = 0.0;
            var price = noOfKilometer * pricePerKM;
            var discountMsg = "";
            if (noOfKilometer >= 1000) {
                var discount = 10.0;
                actualPrice = price - (price * discount / 100);
                discountMsg = "Rs.<del>" + price.toFixed(2) + "</del> is now <b>" + actualPrice.toFixed(2) + "</b> with 10% discount";
            }
            else {
                actualPrice = price;
                discountMsg = "<b>Rs." + price.toFixed(2) + "</b>, now you can get 10% discount with 1000+ kilometer"
            }
            document.getElementById("<%=hdnDiscountedPrice.ClientID %>").value = actualPrice.toFixed(2);
            document.getElementById("<%=lblPrice.ClientID %>").innerHTML = discountMsg;
            /*alert(discountMsg);*/
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('../UserTemplate/images/bg_3.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
                <div class="col-md-9 ftco-animate pb-5">
                    <p class="breadcrumbs"><span class="mr-2"><a href="Default.aspx">Home <i class="ion-ios-arrow-forward"></i></a></span><span>Car Booking <i class="ion-ios-arrow-forward"></i></span></p>
                    <h1 class="mb-3 bread">Car Booking</h1>
                </div>
            </div>
        </div>
    </section>

    <div class="d-flex ml-auto m-3">
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    </div>

    <!-- START Rent Car Section -->
    <section class="ftco-section bg-light">
        <div class="container">
            <div class="row no-gutters">
                <div class="col-md-12">
                    <div class="row no-gutters">
                        <div class="col-md-12 align-items-center">
                            <div action="#" class="request-form ftco-animate bg-primary">
                                <h2 class="text-center">Make Your Trip</h2>
                                <hr class="border border-white" />
                                <div class="d-flex">
                                    <div class="form-group mr-2">
                                        <label for="" class="label">Pick-up date</label>
                                        <input type="date" class="form-control" id="txtPickUpDate" placeholder="Date" runat="server">
                                        <asp:RequiredFieldValidator ID="rfvPickUpDate" runat="server" ErrorMessage="Pick-up date is required"
                                            ControlToValidate="txtPickUpDate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Bold="true"
                                            ValidationGroup="booking"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group ml-2">
                                        <label for="" class="label">Drop-off date</label>
                                        <input type="date" class="form-control" id="txtDropOffDate" placeholder="Date" runat="server">
                                        <asp:RequiredFieldValidator ID="rfvDropOffDate" runat="server" ErrorMessage="Drop-off date is required"
                                            ControlToValidate="txtDropOffDate" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Bold="true"
                                            ValidationGroup="booking"></asp:RequiredFieldValidator>
                                    </div>
                                </div>
                                <div class="d-flex">
                                    <div class="form-group mr-2">
                                        <label for="" class="label">Pick-up time</label>
                                        <input type="time" class="form-control" id="txtPickUpTime" placeholder="Time" runat="server">
                                        <asp:RequiredFieldValidator ID="rfvPickUpTime" runat="server" ErrorMessage="Pick-up time is required"
                                            ControlToValidate="txtPickUpTime" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Bold="true"
                                            ValidationGroup="booking"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="form-group ml-2">
                                        <label for="" class="label">Distance</label>
                                        <input type="number" class="form-control" id="txtDistance" placeholder="Distance in kilometer" runat="server"
                                            onkeyup="calculate();">
                                        <input type="hidden" id="hdnPrice" runat="server" value="0" />
                                        <input type="hidden" id="hdnDiscountedPrice" runat="server" value="0" />
                                        <asp:RequiredFieldValidator ID="rfvDistance" runat="server" ErrorMessage="Distance is required"
                                            ControlToValidate="txtDistance" ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Font-Bold="true"
                                            ValidationGroup="booking"></asp:RequiredFieldValidator>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <asp:Label ID="lblPrice" runat="server" ForeColor="White"></asp:Label>
                                </div>

                                <div class="form-group">
                                    <asp:LinkButton ID="btnBooking" runat="server" CssClass="btn btn-secondary py-3 px-4" OnClick="btnBooking_Click"
                                        ValidationGroup="booking">Rent A Car Now</asp:LinkButton>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- END Rent Car Section -->

</asp:Content>
