<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="CarRental.User.Payment" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../UserTemplate/css/css/Payment.css" rel="stylesheet" />
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
                        <span>Payment <i class="ion-ios-arrow-forward"></i></span>
                    </p>
                    <h1 class="mb-3 bread">Car Payment</h1>
                </div>
            </div>
        </div>
    </section>

    <div class="d-flex ml-auto m-3">
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    </div>

    <section>
        <div class="container-fluid">
            <div class="row d-flex justify-content-center">
                <div class="col-sm-12">
                    <div class="card mx-auto">
                        <p class="heading">PAYMENT DETAILS</p>
                        <div class="card-details ">
                            <div class="form-group mb-0">
                                <p class="text-warning mb-0">Card Number</p>
                                <input type="number" name="card-num" placeholder="1234 5678 9012 3457" size="17" id="cno" runat="server">
                                <span>
                                    <asp:RequiredFieldValidator ID="rfvCard" runat="server" ErrorMessage="Card number is required" ControlToValidate="cno"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Text="*"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revCard" runat="server" ErrorMessage="Card No. must have 16 digits"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{16}$"
                                        ControlToValidate="cno" Text="*">
                                    </asp:RegularExpressionValidator>
                                </span>
                                <img src="https://img.icons8.com/color/48/000000/visa.png" width="64px" height="60px" />
                            </div>

                            <div class="form-group">
                                <p class="text-warning mb-0">Cardholder's Name</p>
                                <input type="text" name="name" placeholder="Name" size="17" id="txtName" runat="server">
                                <span>
                                    <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Text="*"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="Name must be in characters" Text="*"
                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName">
                                    </asp:RegularExpressionValidator>
                                </span>
                            </div>
                            <div class="form-group pt-2">
                                <div class="row d-flex">
                                    <div class="col-sm-4">
                                        <p class="text-warning mb-0">Expiration</p>
                                        <asp:TextBox ID="txtExpiry" runat="server" TextMode="Month"></asp:TextBox>
                                        <span>
                                            <asp:RequiredFieldValidator ID="rfvExpiration" runat="server" ErrorMessage="Expiry Date is required" ControlToValidate="txtExpiry"
                                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Text="*"></asp:RequiredFieldValidator>
                                        </span>
                                    </div>
                                    <div class="col-sm-3">
                                        <p class="text-warning mb-0">Cvv</p>
                                        <input type="password" name="cvv" placeholder="&#9679;&#9679;&#9679;" size="1" minlength="3" maxlength="3" id="txtCvv"
                                            runat="server">
                                        <span>
                                            <asp:RequiredFieldValidator ID="rfv" runat="server" ErrorMessage="CVV is required" ControlToValidate="txtCvv"
                                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" Text="*"></asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="revCvv" runat="server" ErrorMessage="CVV must have 3 digits"
                                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{3}$"
                                                ControlToValidate="txtCvv" Text="*">
                                            </asp:RegularExpressionValidator>
                                        </span>
                                    </div>
                                    <div class="col-sm-5 pt-3">
                                        <asp:LinkButton ID="btnPay" runat="server" CssClass="btn btn-warning" OnClick="btnPay_Click">
                                            <i class="icon-arrow-right px-2 py-2 text-white"></i>
                                        </asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card-footer">
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" Font-Size="Small"  DisplayMode="BulletList" 
                                HeaderText="Fix the following error's"/>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
