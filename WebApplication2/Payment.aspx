<%@ Page Title="Payment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="WebApplication2.Payment" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-5">
        <div class=" card shadow-sm">
            <div class="card-body">

                <h4 class="mb-4">💳 Payment</h4>

                <!-- Order Info -->
                <div class="mb-3">
                    <strong>Order #</strong>
                    <asp:Literal ID="litOrderId" runat="server" />
                </div>

                <div class="mb-3">
                    <strong>Total Amount:</strong>
                    $<asp:Literal ID="litTotal" runat="server" />
                </div>

                <hr />

                <!-- Payment Method -->
                <div class="mb-3">
                    <label class="form-check-label">Select Payment Method</label>
                    <asp:RadioButtonList ID="rblPaymentMethod" runat= "server" RepeatDirection="Vertical" RepeatLayout="Table" CssClass="form-check">
                        <asp:ListItem Text="💳 Credit_Card" Value="CreditCard"></asp:ListItem>
                        <asp:ListItem Text="📱 E-Wallet" Value="eWallet"></asp:ListItem>
                        <asp:ListItem Text="💵 Cash" Value="Cash"></asp:ListItem>
                    </asp:RadioButtonList>
                </div>

                <asp:Label ID="lblMsg" runat="server" CssClass="text-danger"></asp:Label>

                <div class="mt-4">
                    <asp:Button ID="btnPay" runat="server" Text="Pay Now" CssClass="btn btn-success" OnClick="btnPay_Click" />

                    <a href="Default.aspx" class="btn btn-secondary ms-2">
                        Cancel
                    </a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>