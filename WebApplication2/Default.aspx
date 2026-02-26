<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApplication2._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <h2 class="mb-4 text-center">Choose Your Restaurant</h2>

        <div class="row" id="restaurantList">

            <% foreach (var restaurant in Restaurants)
                {  %>

            <div class="col-lg-4 col-md-6 mb-4 restaurant-card">
                <div class="card shadow-sm h-100">

                    <img src="<%= restaurant.ImageUrl %>" class="card-img-top" style="height:200px; object-fit:cover;" />
                    
                    <div class="card-body text-center">
                        <h5><%= restaurant.Name %></h5>
                        <p class="text-muted"><%= restaurant.Description %></p>

                        <% foreach (var tag in restaurant.Tags)
                            { %>
                            <span class="badge bg-info"><%= tag %></span>
                        <%} %>

                        <p class="mt-2">
                            <% for(int i = 0; i < 5; i++) { %>
                                <% if (i < Math.Floor(restaurant.Rating)) { %>★<% } else { %>☆<%} %>
                            <% } %>
                            (<%= restaurant.Rating.ToString("0.0") %>)
                        </p>

                        <a href='RestaurantMenu.aspx?restaurantId=<%= restaurant.id %>' class="btn btn-danger w-100 mt-2">
                            View Menu
                        </a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>
    <script>
        document.addEventListener('DOMContentLoaded', function () {

            const searchBox = document.querySelector('.global-search');
            const restaurantCards = document.querySelectorAll('.restaurant-card');

            if (!searchBox) return;

            searchBox.addEventListener('input', function () {

                const keyword = searchBox.value.toLowerCase();

                restaurantCards.forEach(card => {

                    const nameE1 = card.querySelector('h5');
                    const descE1 = card.querySelector('.text-muted');
                    const badgeE1s = card.querySelectorAll('.badge');

                    const nameText = nameE1.innerText;
                    const descText = descE1.innerText;
                    const tagsText = Array.from(badgeE1s).map(b => b.innerText).join(" ");

                    const match = nameText.toLowerCase().includes(keyword) ||
                                    descText.toLowerCase().includes(keyword) ||
                                    tagsText.toLowerCase().includes(keyword);

                    card.style.display = match ? '' : 'none';

                    nameE1.innerHTML = highlight(nameText, keyword);
                    descE1.innerHTML = highlight(descText, keyword);

                    badgeE1s.forEach(b => {
                        const originalText = b.innerText;
                        b.innerHTML = highlight(originalText, keyword);
                    });
                });
            });

            function highlight(text, keyword) {
                if (!keyword) return text;
                const regex = new RegExp("(" + keyword.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + ")", "gi");
                return text.replace(regex, '<mark>$1</mark>');
            }
        });
    </script>
</asp:Content>