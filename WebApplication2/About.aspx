<%@ Page Title="Order History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="WebApplication2.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <h2>📜 Order History</h2>
        <p class="text-muted">
            This page show you past food orders.
        </p>


        <div class="row mb-4 align-items-center">
            <div class="col-md-6">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                    Placeholder="Search by Order ID..."></asp:TextBox>
            </div>

            <!-- Add New Filter -->
            <div class="col-md-3">
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                    <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                    <asp:ListItem Text="Preparing" Value="Preparing"></asp:ListItem>
                    <asp:ListItem Text="Confirmed" Value="Confirmed"></asp:ListItem>
                    <asp:ListItem Text="Cancelled" Value="Cancelled"></asp:ListItem>
                </asp:DropDownList> 
            </div>

            <div class="col-md-2">
                <asp:Button ID="btnSearch" runat="server" Text="Search" 
                    CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
            </div>
        </div>

        <!-- Order -->
        <asp:Repeater ID="rptOrders" runat="server" OnItemCommand="rptOrders_ItemCommand">
            <ItemTemplate>
                <div class="card mb-3 shadow-sm p-3">
                    <div class="card-body">

                        <!-- Header -->
                        <div class="d-flex justify-content-between">
                            <div>
                                <h5 class="mb-0">
                                    Order #<%# Eval("OrderId") %>
                                </h5>

                                <small class="text-muted">
                                    <%# Eval("OrderDate") == null ? "" : Eval("OrderDate") %>
                                </small>

                                <span class='<%# GetStatusClass(Eval("Status") == null ? "" : Eval("Status").ToString()) %>'>
                                    Status: <%# Eval("Status") %>
                                </span>
                            </div>

                            <a href='OrderDetail.aspx?id=<%# Eval("OrderId") %>'
                                class="btn btn-outline-primary btn-sm">
                                View Details
                            </a>
                        </div>

                        <!-- Items -->
                        <asp:Repeater ID="rptOrderItems" runat="server" DataSource='<%# Eval("Items") %>'>
                            <ItemTemplate>
                                <li class="list-group-item px-0">
                                    <div class="d-flex justify-content-between">
                                        <strong>
                                            <%# Eval("FoodName") %> 
                                        </strong>
                                        <span class="text-muted"> x <%# Eval("Quantity") %></span>
                                        <div class="fw-semibold">
                                            $<%# Eval("SubTotal", "{0:0.00}")%>
                                        </div>
                                    </div>

                                    <small class="text-muted d-block mt-1">
                                        <%# Eval("Flavor") != null && Eval("Flavor").ToString() != ""? "Flavor: " + Eval("Flavor"): ""%>
                                    </small>

                                    <small class="text-muted d-block mt-1">
                                        <%# Eval("Extras") != null && Eval("Extras").ToString() != ""? "Extras: " + Eval("Extras"): ""%>
                                    </small>

                                    <small class="text-muted d-block mt-1">
                                        <%# Eval("SpecialRequest") != null && Eval("SpecialRequest").ToString() != ""? "Note: " + Eval("SpecialRequest"): ""%>
                                    </small>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                        <!-- Total -->
                        <div class="text-end mt-2 fw-bold">
                            <h5 class="mb-2">
                                Total: $<%# Eval("Total", "{0:0.00}") %>
                            </h5>
                        </div>
                  </div>
               </div>
            </ItemTemplate>
        </asp:Repeater>

        <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
            <div class="alert alert-info mt-3">
                No order history yet
            </div>
        </asp:Panel>
    </div>
</asp:Content>