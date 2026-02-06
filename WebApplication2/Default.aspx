<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-5">

    <!-- Big Card Background -->
    <div class="card shadow-lg p-4">

        <!-- Header -->
        <div class="d-flex align-items-center mb-4">
            <h2 class="me-3">🍔 Food Ordering</h2>
            <span class="text-muted">Choose your favourite food</span>
        </div>

        <!-- Category Buttons (先做 UI，用不到功能也沒關係) -->
        <div class="mb-3 d-flex gap-2 flex-wrap">

            <asp:LinkButton runat="server" CssClass='<%# GetCategoryClass("All") %>'
                CommandArgument="All" OnCommand="Category_Click">
                All
            </asp:LinkButton>

            <asp:LinkButton runat="server" CssClass='<%# GetCategoryClass("Burger") %>'
                CommandArgument="Burger" OnCommand="Category_Click">
                Burger
            </asp:LinkButton>

            <asp:LinkButton runat="server" CssClass='<%# GetCategoryClass("Pizza") %>'
                CommandArgument="Pizza" OnCommand="Category_Click">
                Pizza
            </asp:LinkButton>

            <asp:LinkButton runat="server" CssClass='<%# GetCategoryClass("Drink") %>'
                CommandArgument="Drink" OnCommand="Category_Click">
                Drink
            </asp:LinkButton>

            <asp:LinkButton runat="server" CssClass='<%# GetCategoryClass("Dessert") %>'
                CommandArgument="Dessert" OnCommand="Category_Click">
                Dessert
            </asp:LinkButton>
        </div>

        <!-- Search Bar -->
        <div class="row mb-4 align-items-center">
            <div class="col-md-8">
                <asp:TextBox ID="txtSearch" runat="server" 
                    CssClass="form-control form-control-lg" 
                    Placeholder="Search food..."></asp:TextBox>
            </div>
            <div class="col-md-4">
                <asp:Button ID="btnSearch" runat="server" 
                    Text="Search" 
                    CssClass="btn btn-primary btn-lg w-100" 
                    OnClick="btnSearch_Click" />
            </div>
        </div>

        <!-- Food List (用 Repeater 動態顯示) -->
        <div class="row">

            <asp:Repeater ID="rptFoods" runat="server" OnItemCommand="rptFoods_ItemCommand">
                <ItemTemplate>

                    <div class="col-md-3 mb-4  d-inline-block">
                        <div class="card h-100 shadow-sm food-card">

                            <img src='<%# Eval("ImageUrl") %>' class="card-img-top food-img" />

                            <div class="card-body text-center">
                                <h5 class="card-title"><%# Eval("FoodName") %></h5>
                                <p class="text-muted">$<%# Eval("Price") %></p>

                                <asp:Button ID="btnViewDetail" runat="server"
                                    Text="Customize & Add"
                                    CssClass="btn btn-success w-100"
                                    CommandName="viewDetail"
                                    CommandArgument='<%# Eval("FoodID") %>' />
                            </div>
                        </div>
                    </div>

                </ItemTemplate>
            </asp:Repeater>

            <!-- Empty -->
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="alert alert-info mt-3">
                    No food found
                </div>
            </asp:Panel>

        </div>

        <!-- Message -->
        <asp:Label ID="lblMsg" runat="server" CssClass="text-success mt-3"></asp:Label>


        <a href="Cart.aspx" class="btn btn-outline-success ms-auto">    
            🛒 Cart
        </a>

    </div>
</div>

</asp:Content>
