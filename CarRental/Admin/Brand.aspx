<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Brand.aspx.cs" Inherits="CarRental.Admin.Brand" %>

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
        <div class="col-lg-4 col-md-12">
            <div class="card">
                <div class="card-header card-header-tabs card-header-primary">
                    <h4 class="card-title">Brand</h4>
                </div>
                <div class="card-body">
                    <div class="tab-content">
                        <div class="tab-pane active" id="profile">
                            <div class="form-group bmd-form-group">
                                <label for="txtBrandName" class="bmd-label-floating">Brand Name</label>
                                <input type="text" class="form-control" id="txtBrandName" runat="server">
                                <asp:HiddenField ID="hdnBrandId" runat="server" Value="0" />
                            </div>
                            <div class="form-check">
                                <label class="form-check-label">
                                    <input class="form-check-input" type="checkbox" value="" runat="server" id="chkIsActive">
                                    IsActive
                                    <span class="form-check-sign">
                                        <span class="check"></span>
                                    </span>
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <asp:Button ID="btnAddOrUpdate" runat="server" Text="Add" CssClass="btn btn-fill btn-primary" OnClick="btnAddOrUpdate_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-fill btn-primary" OnClick="btnClear_Click" />
                </div>
            </div>
        </div>
        <div class="col-lg-8 col-md-12">
            <div class="card">
                <div class="card-header card-header-primary">
                    <h4 class="card-title">Brand List</h4>
                </div>
                <div class="card-body table-responsive">
                    <asp:Repeater ID="rBrand" runat="server" OnItemCommand="rBrand_ItemCommand"
                        OnItemDataBound="rBrand_ItemDataBound">
                        <HeaderTemplate>
                            <table class="data-table table hover nowrap" id="example_table">
                                <thead class="text-primary">
                                    <tr>
                                        <th class="table-plus">Name</th>
                                        <th>IsActive</th>
                                        <th>CreatedDate</th>
                                        <th class="datatable-nosort">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <tr>
                                <td class="table-plus"><%# Eval("BrandName") %></td>
                                <td>
                                    <asp:Label ID="lblIsActive" runat="server" Text='<%# Eval("IsActive") %>'></asp:Label>
                                </td>
                                <td><%# Eval("CreatedDate") %></td>
                                <td>
                                    <asp:LinkButton ID="lnkEdit" Text="Edit" runat="server" CommandName="edit" CommandArgument='<%# Eval("BrandId") %>'
                                        CssClass="btn btn-link btn-primary btn-just-icon edit">
                                                <i class="material-icons">edit</i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete" CommandArgument='<%# Eval("BrandId") %>'
                                        OnClientClick="return confirm('Do you want to delete this category?');"
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
                    <%--<table class="data-table table table-hover nowrap" id="example">
                        <thead class="text-primary">
                            <tr>
                                <th class="nowrap">ID</th>
                                <th>Name</th>
                                <th>IsActive</th>
                                <th>Created Date</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="table-plus">1</td>
                                <td>Dakota Rice</td>
                                <td>$36,738</td>
                                <td>Niger</td>
                                <td>
                                    <a href="#" class="btn btn-link btn-warning btn-just-icon edit"><i class="material-icons">edit</i></a>
                                    <a href="#" class="btn btn-link btn-danger btn-just-icon remove"><i class="material-icons">close</i></a>
                                </td>
                            </tr>
                        </tbody>
                    </table>--%>
                </div>
            </div>

        </div>
    </div>

</asp:Content>
