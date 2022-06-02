<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="VehicleList.aspx.cs" Inherits="CarRental.Admin.VehicleList" %>
<%@ Import Namespace="CarRental" %>

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

    <style type="text/css">
        .highlightRow
        {
            background-color: #E0B0FF;
        }
    </style>

    <script>
        window.onload = function () {
            var userId = getUrlVars();
            $(".trclass").each(function (index, val) {
                var a = $("input[name=hdnId]");
                var userid = a[index].value;
                if (userId['id'] == userid) {
                    $(this).addClass("highlightRow").siblings().removeClass("highlightRow");
                }
            });
        };

        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
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
                    <h4 class="card-title">Vehicle List</h4>
                </div>
                <div class="card-body table-responsive">
                    <asp:Repeater ID="rCarList" runat="server" OnItemCommand="rCarList_ItemCommand"
                        OnItemDataBound="rCarList_ItemDataBound">
                        <HeaderTemplate>
                            <table class="data-table table hover nowrap" id="example_table">
                                <thead class="text-primary">
                                    <tr>
                                        <th class="table-plus">Name</th>
                                        <th>Image</th>
                                        <td>Brand</td>
                                        <th>Price / KM(₹)</th>
                                        <th>IsActive</th>
                                        <th>CreatedDate</th>
                                        <th class="datatable-nosort">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="trclass">
                                <td class="table-plus"><%# Eval("Name") %></td>
                                <td>
                                    <img width="40" src="<%# Utils.GetImageUrl( Eval("ImageUrl")) %>"
                                        alt='#'>
                                </td>
                                <td><%# Eval("BrandName") %></td>
                                <td><%# Eval("PricePerKM") %></td>
                                <td>
                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                </td>
                                <td><%# Eval("CreatedDate") %></td>
                                <input type="hidden" value='<%# Eval("VehicleId") %>' name="hdnId">
                                <td>
                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CommandName="edit" CommandArgument='<%# Eval("VehicleId") %>'
                                        CssClass="btn btn-link btn-primary btn-just-icon edit">
                                                <i class="material-icons">edit</i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete" CommandArgument='<%# Eval("VehicleId") %>'
                                        OnClientClick="return confirm('Do you want to delete this car?');"
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
