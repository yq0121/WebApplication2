<%@ Page Title="Order Confirm" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderConfirm.aspx.cs" Inherits="WebApplication2.OrderConfirm" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-5">

        <!-- Success Messsage -->
        <div class="alert alert-success text-center shadow-sm">
            <h4 class="mb-1">🎉 Order Confirmed!</h4>
            <p class="mb-0">Thank you for your order.</p>
        </div>

        <!-- Order Card -->
        <div class="card shadow-sm mt-4">
            <div class="card-body">

                <!-- Order Info -->
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h5>Order #<asp:Literal ID="litOrderId" runat="server"></asp:Literal></h5>
                        <small class="text-muted">
                            <asp:Literal ID="litOrderDate" runat="server"></asp:Literal>
                        </small>
                    </div>

                    <span id="statusBadge" runat="server"></span>
                </div>

                <hr />

                <!-- Items -->
                <asp:Repeater ID="rptItems" runat="server">
                    <ItemTemplate>
                        <div class="d-flex justify-content-between mb-2">
                            <div>
                                <strong><%# Eval("FoodName") %></strong>
                                <span class="text-muted"> x <%# Eval("Quantity") %></span>
                            </div>
                            <div>
                                $<%# Eval("Subtotal", "{0:0.00}") %>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>

                <hr />

                <!-- Total -->
                <div class="text-end">
                    <h5>Total: $
                        <asp:Literal ID="litTotal" runat="server"></asp:Literal>
                    </h5>
                </div>
            </div>
        </div>

        <!-- Button -->
        <div class="text-center mt-4">
            <asp:HyperLink ID="lnkPayment" runat="server" CssClass="btn btn-success me-2">
                Proceed to Payment
            </asp:HyperLink>

            <asp:HyperLink ID="lnkDetail" runat="server" CssClass="btn btn-outline-primary me-2">
                View Order Detail
            </asp:HyperLink>

            <a href="Default.aspx" class="btn btn-primary">
                Back to Menu
            </a>
        </div>
    </div>
</asp:Content>