<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FoodDetail.aspx.cs" Inherits="WebApplication2.FoodDetail" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Food Detail</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-5">
            <div class="card p-4 shadow">

                <!--Food Name & Price -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <img id="imgFood" runat="server" class="img-fluid rounded" />
                    </div>
                    <div class="col-md-8">
                        <h3>
                            <asp:Label ID="lblFoodName" runat="server"></asp:Label>
                        </h3>
                        <h5 class="text-muted">
                            RM <asp:Label ID="lblPrice" runat="server"></asp:Label>
                        </h5>
                    </div>
                </div>

                <hr />

                <!--  ===== Drink Options ===== -->
                <asp:Panel ID="pnlDrinkOptions" runat="server" Visible="false">
                    <h5>🧋 Drink Options</h5>

                    <asp:DropDownList ID="ddlSugarLevel" runat="server" CssClass="mb-3">
                        <asp:ListItem Text="Normal Sugar" Value="Normal Sugar"></asp:ListItem>
                        <asp:ListItem Text="Less Sugar" Value="Less Sugar"></asp:ListItem>
                        <asp:ListItem Text="Half Sugar" Value="Half Sugar"></asp:ListItem>
                        <asp:ListItem Text="No Sugar" Value="No Sugar"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:CheckBoxList ID="rblIceLevel" runat="server" CssClass="mb-3">
                        <asp:ListItem Text="Normal Ice" Value="Normal Ice"></asp:ListItem>
                        <asp:ListItem Text="Less Ice" Value="Less Ice"></asp:ListItem>
                        <asp:ListItem Text="Half Ice" Value="Half Ice"></asp:ListItem>
                        <asp:ListItem Text="No Ice" Value="No Ice"></asp:ListItem>
                    </asp:CheckBoxList>
                </asp:Panel>

                <!--  ===== Dessert Options ===== -->
                <asp:Panel ID="pnlDessertOptions" runat="server" Visible="false">
                    <h5>🍰 Dessert Options</h5>

                    <!-- Flavor -->
                    <asp:DropDownList ID="ddlDessertFlavor" runat="server" CssClass="mb-3">
                        <asp:ListItem Text="Chocolate" Value="Normal Sugar"></asp:ListItem>
                        <asp:ListItem Text="Vanilla" Value="Less Sugar"></asp:ListItem>
                        <asp:ListItem Text="Strawberry" Value="Half Sugar"></asp:ListItem>
                        <asp:ListItem Text="Lime" Value="No Sugar"></asp:ListItem>
                    </asp:DropDownList>

                    <!-- Extra -->
                    <asp:CheckBoxList ID="cblDessertExtras" runat="server" CssClass="mb-3">
                        <asp:ListItem Text="Extra Cream" Value="Extra Cream"></asp:ListItem>
                        <asp:ListItem Text="Sprinkles" Value="Sprinkles"></asp:ListItem>
                    </asp:CheckBoxList>
                </asp:Panel>

                <!-- ===== Burger / Pizza Options ===== -->
                <asp:Panel ID="pnlFoodOptions" runat="server" Visible="false">
                     <h5>🍔 Food Options</h5>

                     <!-- Flavor choice -->
                     <asp:DropDownList ID="ddlFlavor" runat="server" CssClass="form-select mb-3">
                        <asp:ListItem Text="Spicy" Value="Spicy"></asp:ListItem>
                        <asp:ListItem Text="Mild" Value="Mild"></asp:ListItem>
                        <asp:ListItem Text="Sweet" Value="Sweet"></asp:ListItem>
                    </asp:DropDownList>

                    <!-- Extra -->
                    <asp:CheckBoxList ID="cblExtras" runat="server" CssClass="mb-3">
                        <asp:ListItem Text="Extra Cheese" Value="Cheese"></asp:ListItem>
                        <asp:ListItem Text="Extra Egg" Value="Egg"></asp:ListItem>
                    </asp:CheckBoxList>
                </asp:Panel>

                <!-- ===== Special Request (All Food) ===== -->
                <div class="mb-3">
                    <label class="form-label">Special Request</label>
                    <asp:TextBox ID="txtSpecialRequest" runat="server"
                        CssClass="form-control"
                        Placeholder="E.g. no onion, less sauce..." />
                </div>

                <!-- Add Cart -->
                <div class="d-flex gap-2">
                    <asp:Button ID="btAddToCart" runat="server" Text="Add to Cart" CssClass="btn btn-success w-100 mt-2" OnClick="btnAddToCart_Click" />
                    
                    <!-- Back To Menu -->
                    <a href="Default.aspx" class="btn btn-secondary w-100 mt-2"> ← Back To Menu</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
