<%@ Page Title="My Cart" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="WebApplication2.Cart" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-5">

    <div class="card shadow-lg p-4">

        <h2 class="mb-4">🛒 My Cart</h2>

        <!-- Empty Cart Message -->
        <asp:Label ID="lblEmpty" runat="server" CssClass="text-muted fs-5" Visible="false">
            Your cart is empty.
        </asp:Label>

        <!-- Cart List -->
        <asp:Repeater ID="rptCart" runat="server" OnItemCommand="rptCart_ItemCommand">
            <HeaderTemplate>
                <table class="table align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>Food</th>
                            <th class="text-center">Price</th>
                            <th class="text-center">Qty</th>
                            <th class="text-center">Sub Total</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody>
            </HeaderTemplate>

            <ItemTemplate>
                <tr>
                    <td>
                        <img src='<%# Eval("ImageUrl") %>' width="60" class="me-2 rounded" />
                        <strong><%# Eval("FoodName") %></strong>

                        <!-- Food Detail -->
                        <div class="small text-muted mt-1">
                            <%# string.IsNullOrEmpty(Eval("Flavor")?.ToString())? "": "Flavor: " + Eval("Flavor") %>
                        </div>

                        <div class="small text-muted">
                            <%# string.IsNullOrEmpty(Eval("Extras")?.ToString())? "": "Extras: " + Eval("Extras") %>
                        </div>

                        <div class="small text-muted">
                            <%# string.IsNullOrEmpty(Eval("SpecialRequest")?.ToString())? "": "Note: " + Eval("SpecialRequest") %>
                        </div>
                    </td>

                    <td class="text-center">$<%# Eval("Price") %></td>

                    <td class="text-center">
                        <asp:Button ID="btnMinus" runat="server"
                            Text="-" CssClass="btn btn-sm btn-outline-secondary"
                            CommandName="minus"
                            CommandArgument='<%# Container.ItemIndex %>' />

                        <span class="mx-2"><%# Eval("Quantity") %></span>

                        <asp:Button ID="Button1" runat="server"
                            Text="+" CssClass="btn btn-sm btn-outline-secondary"
                            CommandName="plus"
                            CommandArgument='<%# Container.ItemIndex %>' />
                    </td>

                    <td class="text-center">
                        $<%# Eval("SubTotal", "{0:0.00}") %>
                    </td>

                    <td class="text-center">
                        <asp:Button ID="btnRemove" runat="server"
                            Text="Remove"
                            CssClass="btn btn-sm btn-outline-danger"
                            CommandName="remove"
                            CommandArgument='<%# Container.ItemIndex %>' />
                    </td>
                </tr>
            </ItemTemplate>

            <FooterTemplate>
                    </tbody>
                </table>
            </FooterTemplate>
        </asp:Repeater>

        <!-- Total -->
        <div class="text-end mt-3 border-top pt-3">
            <h4>
                Total: <span class="text-success">$<asp:Label ID="lblTotal" runat="server"></asp:Label></span>
            </h4>
        </div>

        <!-- Buttons -->
        <div class="d-flex justify-content-between mt-4">
            <a href="Default.aspx" class="btn btn-outline-secondary">← Continue Shopping</a>
            <asp:Button ID="btnCheckout" runat="server" Text="Checkout" CssClass="btn btn-success btn-lg" 
                OnClick="btnCheckout_Click"/>
        </div>

    </div>
</div>

</asp:Content>