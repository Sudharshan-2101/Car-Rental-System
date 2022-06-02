<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Bookings.aspx.cs" Inherits="CarRental.Admin.Bookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        /*For disappearing alert message*/
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };

        function calculate() {
            var pricePerKM = document.getElementById("<%=hdnPrice.ClientID %>").value;
            var odoMeterStart = document.getElementById("<%=txtOdoMeterStart.ClientID %>").value;
            var odoMeterEnd = document.getElementById("<%=txtOdoMeterEnd.ClientID %>").value;
            var noOfKilometer = odoMeterEnd - odoMeterStart;
            var actualPrice = 0.0;
            var price = noOfKilometer * pricePerKM;
            if (noOfKilometer >= 1000) {
                var discount = 10.0;
                actualPrice = price - (price * discount / 100);
            }
            else {
                actualPrice = price;
            }
            document.getElementById("<%=txtDistance.ClientID %>").value = noOfKilometer.toFixed(2);
            document.getElementById("<%=txtPrice.ClientID %>").value = actualPrice.toFixed(2);
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
                    <h4 class="card-title">Car Booked List</h4>
                </div>
                <asp:Panel ID="pnledit" runat="server" Visible="false">
                    <div class="card-header card-header-secondary">
                        <div class="form-row pt-5">
                            <div class="form-group col-md-2">
                                <label for="txtOdoMeterStart">OdoMeter Initial</label>
                                <input type="number" class="form-control" id="txtOdoMeterStart" runat="server">
                            </div>
                            <div class="form-group col-md-2">
                                <label for="txtOdoMeterEnd">OdoMeter End</label>
                                <input type="number" class="form-control" id="txtOdoMeterEnd" runat="server" onkeyup="calculate();">
                            </div>
                            <div class="form-group col-md-2">
                                <label for="txtDistance">Distance(KM)</label>
                                <input type="number" class="form-control" id="txtDistance" runat="server">
                            </div>
                            <div class="form-group col-md-2">
                                <label for="txtPrice">Price(₹)</label>
                                <input type="number" class="form-control" id="txtPrice" runat="server">
                                <input type="hidden" id="hdnPrice" runat="server" value="0" />
                                <input type="hidden" id="hdnBookingId" runat="server" value="0" />
                            </div>
                            <div class="form-group col-md-2">
                                <asp:DropDownList ID="ddlStatus" runat="server" AppendDataBoundItems="true" CssClass="form-control text-secondary">
                                    <asp:ListItem Value="0">Select Status</asp:ListItem>
                                    <asp:ListItem>Not Yet Confirm</asp:ListItem>
                                    <asp:ListItem>Confirmed</asp:ListItem>
                                    <asp:ListItem>Cancelled</asp:ListItem>
                                    <asp:ListItem>Rented</asp:ListItem>
                                    <asp:ListItem>Returned</asp:ListItem>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvStatus" runat="server" ErrorMessage="Status is required" ForeColor="Red"
                                    ControlToValidate="ddlStatus" InitialValue="0" SetFocusOnError="true" Display="Dynamic"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group col-md-2">
                                <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary mt-0" OnClick="btnUpdate_Click" />
                                <asp:Button ID="btnClear" runat="server" Text="X" CssClass="btn btn-warning btn-sm pt-2 pb-2 mt-0" OnClick="btnClear_Click" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <div class="card-body table-responsive">
                    <asp:Repeater ID="rCarBookList" runat="server" OnItemCommand="rCarBookList_ItemCommand">
                        <HeaderTemplate>
                            <table class="data-table table hover nowrap" id="example_table">
                                <thead class="text-primary">
                                    <tr>
                                        <%--<th class="table-plus datatable-nosort">SrNo</th>--%>
                                        <th style="font-size: small">Pick-Up Date</th>
                                        <th style="font-size: small">Drop-Off Date</th>
                                        <th style="font-size: small">Pick-Up Time</th>
                                        <th style="font-size: small">Car</th>
                                        <th style="font-size: small">User</th>
                                        <th style="font-size: small">Status</th>
                                        <th style="font-size: small">Deleted</th>
                                        <th style="font-size: small">Booking Date</th>
                                        <th class="datatable-nosort" style="font-size: small">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <%--<td class="table-plus"><%# Eval("SrNo") %></td>--%>
                                <td><%# Eval("PickUpDate","{0:dd-MM-yyyy}") %></td>
                                <td><%# Eval("DropOffDate","{0:dd-MM-yyyy}") %></td>
                                <td><%# Eval("PickUpTime") %></td>
                                <td>
                                    <a href='<%# "VehicleList.aspx?id=" + Eval("VehicleId") %>' title="Click to view"><%# Eval("Name") %> </a>
                                </td>
                                <td>
                                    <%--<%# Eval("Email") %>--%>
                                    <a href='<%# "Users.aspx?id=" +Eval("UserId") %>' title="Click to view"><%# Eval("Username") %> </a>
                                </td>
                                <td>
                                    <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("Status") %>'
                                        CssClass='<%# Eval("Status").ToString()  == "Not Yet Confirm" 
                                            ? "badge badge-warning" : Eval("Status").ToString() == "Confirmed" 
                                            ? "badge badge-success" : Eval("Status").ToString() == "Cancelled" 
                                            ? "badge badge-danger" : Eval("Status").ToString() == "Rented" 
                                            ? "badge badge-primary" : "badge badge-info" %>'></asp:Label>
                                </td>
                                <td>
                                    <asp:Label ID="lblIsDeleted" runat="server" Text='<%# (bool)Eval("IsDeleted") == true ? "Yes" : "No" %>'></asp:Label>
                                </td>
                                <td><%# Eval("BookingDate") %></td>
                                <td>
                                    <asp:LinkButton ID="lnkedit" Text="Edit" runat="server" CommandName="edit" CommandArgument='<%# Eval("BookingId") %>'
                                        CssClass="btn btn-link btn-primary btn-just-icon edit">
                                        <i class="material-icons">edit</i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete" CommandArgument='<%# Eval("BookingId") %>'
                                        OnClientClick="return confirm('Do you want to delete this booking?');"
                                        CssClass="btn btn-link btn-danger btn-just-icon remove">
                                        <i class="material-icons">delete</i>
                                    </asp:LinkButton>
                                </td>
                            </tr>
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

</asp:Content>
