<%@ Page Title="Payment Success" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PaymentSuccess.aspx.cs" Inherits="WebApplication2.PaymentSuccess" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="card shadow-lg border-0 text-center p-4">
            <div class="mb-4">
                <div class="display-1 text-success">
                    ✔
                </div>
                <h3 class="text-success">Payment Successful!</h3>
                <p class="text-muted">Your transaction has been completed.</p>
            </div>

            <hr />

            <div class="text-start mx-auto" style="max-width:400px;">
                <p><strong>Order ID:</strong>
                    <asp:Literal ID="litOrderId" runat="server"></asp:Literal>
                </p>

                <p><strong>Payment Method:</strong>
                    <asp:Literal ID="litMethod" runat="server"></asp:Literal>
                </p>

                <p><strong>Transaction Ref:</strong>
                    <asp:Literal ID="litRef" runat="server"></asp:Literal>
                </p>
            </div>

            <div class="mt-4">
                <asp:HyperLink ID="lnkBack" runat="server" CssClass="btn btn-success">
                    Back to Order
                </asp:HyperLink>

                <a href="Default.aspx" class="btn btn-outline-danger-secondary ms-2">
                    Back to Menu
                </a>
            </div>

            <div class="mt-3 text-muted small">
                Redirecting in 5 seconds...
            </div>
        </div>
    </div>

    <script>
        setTimeout(function () {
            window.location.href = '<%= lnkBack.NavigateUrl %>';
        }, 5000);
    </script>
</asp:Content>

