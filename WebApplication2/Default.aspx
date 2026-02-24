<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .food-img{
            height: 200px;
            object-fit: cover;
        }

        .food-card{
            transition:0.3s;
        }

        .food-card:hover{
            transform: scale(1.03);
            box-shadow:0 10px 25px rgba(0,0,0,0.15);
        }
    </style>
<div class="container-fluid mt-4">

    <div class="row">

       <!-- 🔥 LEFT FILTER -->
        <div class="col-lg-3">

            <div class="card shadow-sm p-3 mb-4">

                <h5 class="mb-3">Filter</h5>

                <hr />

                <!-- Category -->
                <h6>Category</h6>

                <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary w-100 mb-2"
                    CommandArgument="All" OnCommand="Category_Click">
                    All
                </asp:LinkButton>            

                <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary w-100 mb-2"
                    CommandArgument="Burger" OnCommand="Category_Click">
                    Burger
                </asp:LinkButton>

                <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary w-100 mb-2"
                    CommandArgument="Pizza" OnCommand="Category_Click">
                    Pizza
                </asp:LinkButton>

                <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary w-100 mb-2"
                    CommandArgument="Drink" OnCommand="Category_Click">
                    Drink
                </asp:LinkButton>

                <asp:LinkButton runat="server" CssClass="btn btn-outline-secondary w-100 mb-2"
                    CommandArgument="Dessert" OnCommand="Category_Click">
                    Dessert
                </asp:LinkButton>

                <hr />

                <!-- Price Filter -->
                <h6>Price</h6>

                <asp:RadioButtonList ID="rblPrice" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PriceFilter_Changed" CssClass="mb-2">

                    <asp:ListItem Value="All" Selected="True">All</asp:ListItem>
                    <asp:ListItem Value="Low">Below $10</asp:ListItem>
                    <asp:ListItem Value="Mid">$10 - $15</asp:ListItem>
                    <asp:ListItem Value="High">Above $15</asp:ListItem>

                </asp:RadioButtonList>
            </div>
        </div>

        <!-- 🔥 RIGHT RESTAURANT GRID -->
        <div class="col-lg-9">

            <div class="row">

                 <asp:Repeater ID="rptFoods" runat="server" OnItemCommand="rptFoods_ItemCommand">
                     <ItemTemplate>

                         <div class="col-lg-4 col-md-6 mb-4">
                             <div class="card shadow-sm h-100 food-card">

                                 <img src='<%# Eval("ImageUrl") %>' class="card-img-top food-img" />

                                 <div class="card-body">
                                     <h5><%# Eval("FoodName") %></h5>
                                     <p class="text-muted">$<%# Eval("Price") %></p>

                                     <asp:Button ID="btnViewDetail" runat="server"
                                         Text="View"
                                         CssClass="btn btn-success w-100"
                                         CommandName="viewDetail"
                                         CommandArgument='<%# Eval("FoodId") %>' />
                                 </div>
                             </div>
                         </div>
                     </ItemTemplate>
                 </asp:Repeater>
            </div>

            <!-- Empty -->
            <asp:Panel ID="pnlEmpty" runat="server" Visible="false">
                <div class="alert alert-info mt-3">
                    No food found
                </div>
            </asp:Panel>
        </div>
      </div>
  </div>
</asp:Content>