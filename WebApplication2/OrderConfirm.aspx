<%@ Page Title="Order Confirm" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="OrderConfirm.aspx.cs"
    Inherits="WebApplication2.OrderConfirm" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<div class="container mt-4">
    <div class="card shadow-sm">

        <!-- Header -->
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
            <span>🧾 Order Confirmation</span>
            <asp:Label ID="lblStatusBadge" runat="server" CssClass="badge bg-secondary">
                Pending
            </asp:Label>
        </div>

        <div class="card-body">

            <!-- Progress -->
            <div class="mb-4">
                <div class="progress" style="height: 25px;">
                    <div id="progressBar" runat="server"
                         class="progress-bar progress-bar-striped progress-bar-animated bg-warning"
                         style="width:20%">
                        Pending
                    </div>
                </div>
            </div>

            <!-- Order Items -->
            <asp:GridView ID="gvOrderDetails" runat="server"
                CssClass="table table-bordered table-hover"
                AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="FoodName" HeaderText="Item Name" />
                    <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                    <asp:BoundField DataField="Price" HeaderText="Price ($)" />
                    <asp:BoundField DataField="SubTotal" HeaderText="Subtotal ($)" />
                </Columns>
            </asp:GridView>

            <!-- Total -->
            <div class="text-end mt-3">
                <h4>
                    Total:
                    <span class="text-success">
                        $<asp:Label ID="lblTotal" runat="server"></asp:Label>
                    </span>
                </h4>
            </div>
        </div>

        <!-- Footer -->
        <div class="card-footer text-end">
            <asp:Button ID="btnConfirm" runat="server"
                Text="✔ Confirm Order"
                CssClass="btn btn-success"
                OnClick="btnConfirm_Click" />

            <asp:Label ID="lblMessage" runat="server"
                CssClass="ms-3 text-success fw-bold"></asp:Label>
        </div>

    </div>
</div>

</asp:Content>