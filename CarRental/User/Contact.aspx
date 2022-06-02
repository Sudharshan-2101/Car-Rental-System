﻿<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="CarRental.User.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('../UserTemplate/images/bg_3.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
                <div class="col-md-9 ftco-animate pb-5">
                    <p class="breadcrumbs"><span class="mr-2"><a href="Default.aspx">Home <i class="ion-ios-arrow-forward"></i></a></span><span>Contact <i class="ion-ios-arrow-forward"></i></span></p>
                    <h1 class="mb-3 bread">Contact Us</h1>
                </div>
            </div>
        </div>
    </section>

    <div class="d-flex ml-auto mt-3 ml-3">
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    </div>

    <section class="ftco-section contact-section">
        <div class="container">
            <div class="row d-flex mb-5 contact-info">
                <div class="col-md-4">
                    <div class="row mb-5">
                        <div class="col-md-12">
                            <div class="border w-100 p-4 rounded mb-2 d-flex">
                                <div class="icon mr-3">
                                    <span class="icon-map-o"></span>
                                </div>
                                <p><span>Address:</span> Hyderabad, Telangana</p>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="border w-100 p-4 rounded mb-2 d-flex">
                                <div class="icon mr-3">
                                    <span class="icon-mobile-phone"></span>
                                </div>
                                <p><span>Phone:</span> <a href="tel://7036507016">+91 7036507016</a></p>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="border w-100 p-4 rounded mb-2 d-flex">
                                <div class="icon mr-3">
                                    <span class="icon-envelope-o"></span>
                                </div>
                                <p><span>Email:</span> <a href="mailto:harijatavath9949@gmail.com">harijatavath9949@gmail.com</a></p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8 block-9 mb-md-5">
                    <div class="bg-light p-5 contact-form">
                        <div class="form-group">
                            <input type="text" id="txtName" class="form-control" placeholder="Your Name" runat="server">
                        </div>
                        <div class="form-group">
                            <input type="text" id="txtEmail" class="form-control" placeholder="Your Email" runat="server">
                        </div>
                        <div class="form-group">
                            <input type="text" id="txtSubject" class="form-control" placeholder="Subject" runat="server">
                        </div>
                        <div class="form-group">
                            <textarea id="txtMessage" cols="30" rows="7" class="form-control" placeholder="Message" runat="server"></textarea>
                        </div>
                        <div class="form-group">
                            <%--<input type="submit" value="Send Message" class="btn btn-primary py-3 px-5">--%>
                            <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary py-3 px-5" OnClick="btnSubmit_Click" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>



</asp:Content>
