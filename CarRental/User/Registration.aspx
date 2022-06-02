<%@ Page Title="" Language="C#" MasterPageFile="~/User/User.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="CarRental.User.Registration" %>

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

    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgUser.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('../UserTemplate/images/bg_3.jpg');" data-stellar-background-ratio="0.5">
        <div class="overlay"></div>
        <div class="container">
            <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
                <div class="col-md-9 ftco-animate pb-5">
                    <p class="breadcrumbs">
                        <span class="mr-2"><a href="Default.aspx">Home <i class="ion-ios-arrow-forward"></i></a></span>
                        <span><% Response.Write(Session["Title"].ToString()); %> <i class="ion-ios-arrow-forward"></i></span>
                    </p>
                    <h1 class="mb-3 bread">User <% Response.Write(Session["Title"].ToString()); %> </h1>
                </div>
            </div>
        </div>
    </section>

    <div class="d-flex ml-auto m-3">
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    </div>

    <section class="ftco-section contact-section">
        <div class="container">
            <div class="row d-flex mb-5 contact-info">
                <div class="col-md-12 block-9 mb-md-5">
                    <div class="bg-light p-5 contact-form">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="txtName">Full Name</label>
                                <input type="text" class="form-control" id="txtName" placeholder="User Fullname" runat="server">
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is required" ControlToValidate="txtName"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revName" runat="server" ErrorMessage="Name must be in characters"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-Z\s]+$" ControlToValidate="txtName">
                                </asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="txtUsername">Username</label>
                                <input type="text" class="form-control" id="txtUsername" placeholder="Unique Username" runat="server">
                                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Username is required"
                                    ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="txtMobile">Mobile</label>
                                <input type="number" class="form-control" id="txtMobile" placeholder="Mobile Number" runat="server">
                                <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Mobile number is required" ControlToValidate="txtMobile"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="Mobile No. must have 10 digits"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{10}$"
                                    ControlToValidate="txtMobile">
                                </asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="txtEmail">Email</label>
                                <input type="email" class="form-control" id="txtEmail" placeholder="Email" runat="server">
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is required" ControlToValidate="txtEmail"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ErrorMessage="Invalid email format"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$"
                                    ControlToValidate="txtEmail">
                                </asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-12">
                                <label for="txtAddress">Address</label>
                                <textarea id="txtAddress" cols="30" rows="3" class="form-control" placeholder="Address" runat="server"></textarea>
                                <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is required" ControlToValidate="txtAddress"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="txtPostCode">PostCode</label>
                                <input type="number" class="form-control" id="txtPostCode" placeholder="Post Code/Pin Code" runat="server">
                                <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Post/Zip Code is required" ControlToValidate="txtPostCode"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revPostCode" runat="server" ControlToValidate="txtPostCode"
                                    ErrorMessage="Post/Zip Code must be of 6 digits" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                    ValidationExpression="[0-9]{6}"></asp:RegularExpressionValidator>
                            </div>
                            <div class="form-group col-md-6">
                                <label for="txtPostCode">License</label>
                                <input type="text" class="form-control" id="txtLicense" placeholder="License Number" runat="server">
                                <asp:RequiredFieldValidator ID="rfvLicense" runat="server" ErrorMessage="Post/Zip Code is required"
                                    ControlToValidate="txtLicense" ForeColor="Red" Display="Dynamic" SetFocusOnError="true">
                                </asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revLicense" runat="server" ControlToValidate="txtLicense"
                                    ErrorMessage="License no. must be of 16 characters" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"
                                    ValidationExpression="^(([A-Z]{2}[0-9]{2})( )|([A-Z]{2}-[0-9]{2}))((19|20)[0-9][0-9])[0-9]{7}$"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="fuUserImage">Image</label>
                                <asp:FileUpload ID="fuUserImage" runat="server" ToolTip="User Image" onchange="ImagePreview(this);" CssClass="form-control" />
                            </div>
                            <div class="form-group col-md-6">
                                <label for="txtPassword">Password</label>
                                <asp:TextBox ID="txtUserPassword" runat="server" placeholder="Password" CssClass="form-control"
                                    TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is required" ControlToValidate="txtUserPassword"
                                    ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            </div>
                        </div>

                        <div class="form-group">
                            <asp:Button ID="btnAddOrUpdate" runat="server" Text="Register" CssClass="btn btn-primary py-3 px-5 mr-3"
                                OnClick="btnAddOrUpdate_Click" />

                            <asp:Image ID="imgUser" runat="server" CssClass="img-thumbnail my-4" />
                            <span>
                                <asp:LinkButton ID="lbChangePassword" runat="server" Text="Change Password?" CssClass="badge badge-info ml-4" 
                                    CausesValidation="false" PostBackUrl="ChangePassword.aspx"></asp:LinkButton>
                            </span>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

</asp:Content>
