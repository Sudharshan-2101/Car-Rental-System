<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="CarRental.User.ChangePassword" %>

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
                    <p class="breadcrumbs"><span class="mr-2"><a href="Default.aspx">Home <i class="ion-ios-arrow-forward"></i></a></span><span>Change Password <i class="ion-ios-arrow-forward"></i></span></p>
                    <h1 class="mb-3 bread">Change Password</h1>
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
                <div class="col-md-6">
                    <img src="../UserTemplate/images/about.jpg" alt="" class="img rounded img-fluid" />
                </div>
                <div class="col-md-6 block-9 mb-md-5">
                    <div class="bg-light p-5 contact-form">
                        <div>
                            <h2>Change Password</h2>
                        </div>
                        <div class="form-group">
                            <label for="txtUsername">Old Password</label>
                            <input type="password" id="txtOldPassword" class="form-control" placeholder="Old Password" runat="server">
                            <asp:RequiredFieldValidator ID="rfvOldPassword" runat="server" ErrorMessage="Old Password is required"
                                ControlToValidate="txtOldPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <label for="txtPassword">New Password</label>
                            <input type="password" id="txtNewPassword" class="form-control" placeholder="New Password" runat="server">
                            <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ErrorMessage="New Password is required"
                                ControlToValidate="txtNewPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                            </asp:RequiredFieldValidator>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnChangePassword" runat="server" Text="Change Password" CssClass="btn btn-primary py-3 px-5" 
                                OnClick="btnChangePassword_Click" />
                            <%--<span>
                                <asp:LinkButton ID="lbForgotPassword" runat="server" Text="Forgot Password?" CssClass="badge badge-info ml-4"
                                    OnClick="lbForgotPassword_Click" CausesValidation="false"></asp:LinkButton>
                            </span>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
