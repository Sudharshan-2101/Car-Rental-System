<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Vehicle.aspx.cs" Inherits="CarRental.Admin.Vehicle" %>

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
                    $('#<%=imgCar.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="d-flex ml-auto">
        <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
    </div>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">Vehicle</h4>
                    <p class="card-category">Complete vehicle details</p>
                </div>
                <div class="card-body">
                    <div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Vehicle Name</label>
                                    <input type="text" class="form-control" id="txtVehicleName" runat="server" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlBrand" runat="server" AppendDataBoundItems="true" CssClass="form-control text-secondary">
                                        <asp:ListItem Value="0">Select Brand</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvBrand" runat="server" ErrorMessage="Brand is required" ForeColor="Red"
                                        ControlToValidate="ddlBrand" InitialValue="0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <asp:FileUpload ID="fuVehicleImage" runat="server" ToolTip="Vehicle Image" onchange="ImagePreview(this);" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Vehicle Description</label>
                                    <textarea id="txtDescription" runat="server" class="form-control" cols="30" rows="4" required></textarea>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbIsActive">
                                            IsActive
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Price Per Kilometer(₹)</label>
                                    <input type="text" id="txtPrice" runat="server" class="form-control" required>
                                    <asp:RegularExpressionValidator ID="regexPrice" runat="server" ForeColor="Red" ErrorMessage="Price must be in decimal" 
                                        SetFocusOnError="true" Display="Dynamic" ValidationExpression="^\d{0,8}(\.\d{1,4})?$" ControlToValidate="txtPrice">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Seating Capacity</label>
                                    <input type="text" id="txtSeatingCapacity" runat="server" class="form-control"
                                        placeholder="                                   Ex. 5 Adults & 1 Child" required>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlFuelType" runat="server" AppendDataBoundItems="true" CssClass="form-control text-secondary">
                                        <asp:ListItem Value="0">Select Fuel Type</asp:ListItem>
                                        <asp:ListItem>Petrol</asp:ListItem>
                                        <asp:ListItem>Diesel</asp:ListItem>
                                        <asp:ListItem>CNG</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvFuelType" runat="server" ErrorMessage="Fuel Type is required" ForeColor="Red"
                                        ControlToValidate="ddlFuelType" InitialValue="0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="bmd-label-floating">Mileage(KMPL)</label>
                                    <input type="text" id="txtMileage" runat="server" class="form-control" required>
                                    <asp:RegularExpressionValidator ID="rfvMileage" runat="server" ForeColor="Red" ErrorMessage="Mileage must be in numbers" 
                                        SetFocusOnError="true" Display="Dynamic" ValidationExpression="^[0-9]*$" ControlToValidate="txtMileage">
                                    </asp:RegularExpressionValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlLuggage" runat="server" CssClass="form-control text-secondary">
                                        <asp:ListItem Value="0">Select Luggage</asp:ListItem>
                                        <asp:ListItem>1 Bag</asp:ListItem>
                                        <asp:ListItem>2 Bags</asp:ListItem>
                                        <asp:ListItem>3 Bags</asp:ListItem>
                                        <asp:ListItem>4 Bags</asp:ListItem>
                                        <asp:ListItem>5 Bags</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvLuggage" runat="server" ErrorMessage="Luggage is required" ForeColor="Red"
                                        ControlToValidate="ddlLuggage" InitialValue="0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <asp:DropDownList ID="ddlTransmission" runat="server" CssClass="form-control text-secondary">
                                        <asp:ListItem Value="0">Select Transmission</asp:ListItem>
                                        <asp:ListItem>Automatic</asp:ListItem>
                                        <asp:ListItem>Manual</asp:ListItem>
                                        <asp:ListItem>Continuously Variable(CVT)</asp:ListItem>
                                        <asp:ListItem>Semi-Automatic & Dual Cluth</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="rfvTransmission" runat="server" ErrorMessage="Transmission is required" ForeColor="Red"
                                        ControlToValidate="ddlTransmission" InitialValue="0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Accessories</label>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="" runat="server" id="cbAirConditioner">
                                                        Air Conditioner
                                                        <span class="form-check-sign">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="" runat="server" id="cbPowerDoorLocks">
                                                        Power Door Locks
                                                        <span class="form-check-sign">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="form-group">
                                                <div class="form-check">
                                                    <label class="form-check-label">
                                                        <input class="form-check-input" type="checkbox" value="" runat="server" id="cbAntilockBrackingSystem">
                                                        Antilock Bracking System
                                                        <span class="form-check-sign">
                                                            <span class="check"></span>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbPowerSteering">
                                            Power Steering
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbChildSeat">
                                            Child Seat
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbPassengersAirbag">
                                            Passengers Airbag
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbMusic">
                                            Music
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbClimateControl">
                                            Climate Control
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbGPS">
                                            Global Positioning System (GPS)
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbSeatBealt">
                                            Seat Bealt
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbBluetooth">
                                            Bluetooth
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <div class="form-check">
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="checkbox" value="" runat="server" id="cbRemoteCentralLocking">
                                            Remote Central Locking
                                            <span class="form-check-sign">
                                                <span class="check"></span>
                                            </span>
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-primary" OnClick="btnAddOrUpdate_Click" />

                        <asp:Image ID="imgCar" runat="server" CssClass="img-thumbnail" />

                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>
