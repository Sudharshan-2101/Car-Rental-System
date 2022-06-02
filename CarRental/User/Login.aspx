<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CarRental.User.Login" %>

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
                    <p class="breadcrumbs"><span class="mr-2"><a href="Default.aspx">Home <i class="ion-ios-arrow-forward"></i></a></span><span>Login <i class="ion-ios-arrow-forward"></i></span></p>
                    <h1 class="mb-3 bread">Login</h1>
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
                    <asp:Panel ID="pnlLogin" runat="server">
                        <div class="bg-light p-5 contact-form">
                            <div>
                                <h2>User Login</h2>
                            </div>
                            <div class="form-group">
                                <label for="txtUsername">Username</label>
                                <input type="text" id="txtUsername" class="form-control" placeholder="Username" runat="server">
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Username is required"
                                    ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <label for="txtPassword">Password</label>
                                <input type="password" id="txtPassword" class="form-control" placeholder="Password" runat="server">
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required"
                                    ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                            </div>


                            <div class="form-group">
                                <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary py-3 px-5" OnClick="btnLogin_Click" />
                                <span>
                                    <asp:LinkButton ID="lbForgotPassword" runat="server" Text="Forgot Password?" CssClass="badge badge-info ml-4"
                                        OnClick="lbForgotPassword_Click" CausesValidation="false"></asp:LinkButton>
                                </span>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlForgotPassword" runat="server">
                        <div class="bg-light p-5 contact-form">
                            <div>
                                <h2>Forgot Password</h2>
                            </div>
                            <div class="form-group">
                                <label for="txtUsername">Username</label>
                                <input type="text" id="txtForgotUsername" class="form-control" placeholder="Your Username" runat="server">
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Username is required"
                                    ControlToValidate="txtForgotUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="form-group">
                                <asp:Button ID="btnForgotPassword" runat="server" Text="Submit" CssClass="btn btn-primary py-3 px-5" 
                                    OnClick="btnForgotPassword_Click" />
                                <span>
                                    <asp:LinkButton ID="lbLogin" runat="server" Text="User Login?" CssClass="badge badge-info ml-4"
                                        OnClick="lbLogin_Click" CausesValidation="false"></asp:LinkButton>
                                </span>
                            </div>
                        </div>
                    </asp:Panel>

                </div>
            </div>
        </div>
    </section>

</asp:Content>
