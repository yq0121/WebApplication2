using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class _Default : Page
    {
        protected List<Restaurant> Restaurants;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRestaurants();
            }
        }

        private void LoadRestaurants()
        {
            Restaurants = new List<Restaurant>
            {
                new Restaurant { id = 1, Name = "McDonald's", Description = "Famous burgers & fries",
                                ImageUrl = "https://images.unsplash.com/photo-1550547660-d9450f859349",
                                Rating = 4.2, Tags = new List<string> { "Fast Food", "Burgers" } 
                                },
                new Restaurant { id = 2, Name = "Sushi King", Description = "Japanese Cuisine",
                                ImageUrl = "https://images.unsplash.com/photo-1601924638867-3ec62b7d6f2b",
                                Rating = 4.5, Tags = new List<string> { "Japanese", "Sushi" }
                                },
                new Restaurant { id = 3, Name = "KFC", Description = "Crispy Fried Chicken",
                                ImageUrl = "https://images.unsplash.com/photo-1600891964599-f61ba0e24092",
                                Rating = 4.0, Tags = new List<string> { "Fast Food", "Chicken" }
                                }
            };
        }
    }
}
