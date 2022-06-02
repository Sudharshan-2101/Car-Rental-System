<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="CarRental.Admin.Contacts" %>
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
                    <asp:Repeater ID="rCarList" runat="server" OnItemCommand="rCarList_ItemCommand">
                        <HeaderTemplate>
                            <table class="data-table table hover nowrap" id="example_table">
                                <thead class="text-primary">
                                    <tr>
                                        <th class="table-plus">SrNo</th>
                                        <th>User Name</th>
                                        <th>Email</th>
                                        <th>Subject</th>
                                        <th>Message</th>
                                        <th>Contact Date</th>
                                        <th class="datatable-nosort">Delete</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="table-plus"><%# Eval("SrNo") %></td>
                                <td><%# Eval("Name") %></td>
                                <td><%# Eval("Email") %></td>
                                <td><%# Eval("Subject") %></td>
                                <td><%# Eval("Message") %></td>
                                <td><%# Eval("CreatedDate") %></td>
                                <td>
                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete" CommandArgument='<%# Eval("ContactId") %>'
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
