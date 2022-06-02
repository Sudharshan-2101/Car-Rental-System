<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Users.aspx.cs" Inherits="CarRental.Admin.Users" %>
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
            background-color: #CC99FF;
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
                    <h4 class="card-title">Brand List</h4>
                </div>
                <div class="card-body table-responsive">
                    <asp:Repeater ID="rUserList" runat="server" OnItemCommand="rUserList_ItemCommand">
                        <HeaderTemplate>
                            <table class="data-table table hover nowrap" id="example_table">
                                <thead class="text-primary">
                                    <tr>
                                        <th class="table-plus">SrNo</th>
                                        <th>Full Name</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>License</th>
                                        <th>Joined Date</th>
                                        <th class="datatable-nosort">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr class="trclass">
                                <td class="table-plus"><%# Eval("SrNo") %></td>
                                <td><%# Eval("Name") %></td>
                                <td><%# Eval("Username") %></td>
                                <td><%# Eval("Email") %></td>
                                <td><%# Eval("License") %></td>
                                <td><%# Eval("CreatedDate") %></td>
                                <input type="hidden" value='<%# Eval("UserId") %>' name="hdnId">
                                <td>
                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete" CommandArgument='<%# Eval("UserId") %>'
                                        OnClientClick="return confirm('Do you want to delete this record?');"
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
