<%@ Page Title="Order Details" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="WebApplication2.OrderDetail" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>

        <div>
            <h3 class="mb-1">🧾 Order Detail</h3>

            <p class="text-muted mb-0">
                Order #<asp:Label ID="lblOrderId" runat="server"></asp:Label>
                <br />
                <small>
                    <asp:Label ID="lblOrderDate" runat="server"></asp:Label>
                </small>
            </p>

            <hr />

            <asp:Repeater ID="rptItems" runat="server">
                <ItemTemplate>
                    <div class="border-bottom py-2">

                        <div class="d-flex justify-content-between">
                            <div>
                                <strong><%# Eval("FoodName") %></strong>
                                <span class="text-muted"> x <%# Eval("Quantity") %></span>
                            </div>

                            <div class="fw-semibold">
                                $<%# Eval("Subtotal", "{0:0.00}")%>
                            </div>
                        </div>

                        <div class="small text-muted mt-2">
                            <%# string.IsNullOrEmpty(Eval("Flavor")?.ToString())? "": "Flavor: " + Eval("Flavor") %>
                        </div>

                        <div class="small text-muted">
                            <%# string.IsNullOrEmpty(Eval("Extras")?.ToString())? "": "Extras: " + Eval("Extras") %>
                        </div>

                        <div class="small text-muted">
                            <%# string.IsNullOrEmpty(Eval("SpecialRequest")?.ToString())? "": "Note: " + Eval("SpecialRequest") %>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>

            <hr />

            <h5 class="text-end fw-bold">
                Total: $<asp:Label ID="lblTotal" runat="server"></asp:Label>
            </h5>

            <div class="d-flex justify-content-between mt-4">
                <a href="About.aspx" class="btn btn-outline-secondary">
                    ← Back
                </a>

                <asp:Button ID="btnDelete" runat="server" 
                    Text="Delete Order" CssClass="btn btn-danger"
                    OnClick="btnDelete_Click" OnClientClick="return confirmDelete();"/>
            </div>

            <asp:Label ID="lblMsg" runat="server" CssClass="text-success d-block mt-3"></asp:Label>
        </div>
    </div>
    
    <script>
        function confirmDelete() {
            return confirm("Are you sure you want to delete this order?\nThis action cannot be undone.");
        }
    </script>
</asp:Content>