using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class RestaurantMenu : System.Web.UI.Page
    {
        protected int RestaurantId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["restaurantId"] == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                RestaurantId = Convert.ToInt32(Request.QueryString["restaurantId"]);

                Session["CurrentRestaurant"] = RestaurantId;

                if (Session["CurrentCategory"] == null)
                    Session["CurrentCategory"] = "All";

                Session["Foods"] = GetFoodsByRestaurant(RestaurantId);

                LoadCategories();
                BindFoods();
                Page.DataBind();
            }
        }

        private void LoadCategories()
        {
            var foods = Session["Foods"] as List<Food>;
            if (foods == null) return;

            var categories = foods.Select(f => f.Category).Distinct().ToList();
            categories.Insert(0, "All");

            rptCategories.DataSource = categories;
            rptCategories.DataBind();
        }

        protected void PriceFilter_Changed(object sender, EventArgs e)
        {
            BindFoods();
        }

        private void BindFoods()
        {
            var foods = Session["Foods"] as List<Food>;
            if (foods == null) return;

            string category = Session["CurrentCategory"]?.ToString() ?? "All";
            string priceFilter = rblPrice.SelectedValue;

            var result = foods.AsEnumerable();

            // Category
            if (category != "All")
            {
                result = result.Where(f => f.Category == category);
            }

            // Price
            if (priceFilter == "Low")
                result = result.Where(f => f.Price < 10);
            else if (priceFilter == "Mid")
                result = result.Where(f => f.Price >= 10 && f.Price <= 15);
            else if (priceFilter == "High")
                result = result.Where(f => f.Price > 15);

            var finalList = result.ToList();

            rptFoods.DataSource = finalList;
            rptFoods.DataBind();

            pnlEmpty.Visible = finalList.Count == 0;
            HighlightCategory();
        }

        private void HighlightCategory()
        {
            string current = Session["CurrentCategory"]?.ToString() ?? "All";

            foreach (Control c in Page.Controls)
            {
                HighlightRecursive(c, current);
            }
        }

        private void HighlightRecursive(Control parent, string current)
        {
            foreach (Control c in parent.Controls)
            {
                if (c is LinkButton btn)
                {
                    if (btn.CommandArgument == current)
                        btn.CssClass = "btn btn-primary w-100 mb-2";
                    else
                        btn.CssClass = "btn btn-outline-secondary w-100 mb-2";
                }

                HighlightRecursive(c, current);
            }
        }

        /* =======================
           Category
        ======================= */
        protected void Category_Click(object sender, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "filterCategory") return;

            string category = e.CommandArgument.ToString();

            Session["CurrentCategory"] = category;

            BindFoods();
        }

        /* =======================
           Add to Cart
        ======================= */
        protected void rptFoods_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName != "viewDetail") return;

            int foodId = Convert.ToInt32(e.CommandArgument);

            Response.Redirect("FoodDetail.aspx?id=" + foodId);
        }

        protected string GetCategoryClass(string category)
        {
            string current = Session["CurrentCategory"]?.ToString() ?? "All";

            return category == current ? "btn btn-primary me-2" : "btn btn-outline-secondary me-2";
        }

        /* =======================
           Demo Food Data
        ======================= */
        private List<Food> GetFoodsByRestaurant(int restaurantId)
        {
            if (restaurantId == 1)
            {
                return new List<Food>
                {
                    new Food {
                        FoodId = 1,
                        FoodName = "Big Mac",
                        Category = "Burger",
                        Price = 12,
                        ImageUrl = "https://images.unsplash.com/photo-1550547660-d9450f859349",
                        Description = "Classic McDonald's Big Mac",
                        Flavors = new List<string>{"Original", "Spicy", "BBQ" },
                        Extras = new List<string>{"Extra Cheese", "Extra Egg", "Extra Sauce", "Extra Vegetable"},
                        AllowSpecialRequest = true
                    },
                    new Food {
                        FoodId = 2,
                        FoodName = "Fries",
                        Category = "Snack",
                        Price = 6,
                        ImageUrl = "https://images.unsplash.com/photo-1576107232684-1279f390859f",
                        Description = "Crispy golden fries",
                        Flavors = new List<string>{"Medium", "Large"},
                        Extras = null,
                        AllowSpecialRequest = true
                    }
                };
            }
            else if (restaurantId == 2)
            {
                return new List<Food>
                {
                    new Food {
                        FoodId = 10,
                        FoodName = "Salmon Sushi",
                        Category = "Sushi",
                        Price = 14,
                        ImageUrl = "https://images.unsplash.com/photo-1607301405390-0f64c4c3c2c5",
                        Description = "Fresh salmon sushi",
                        Flavors = null,
                        Extras = new List<string>{"Extra Wasabi"},
                        AllowSpecialRequest = true
                    },
                    new Food {
                        FoodId = 11,
                        FoodName = "Tempura",
                        Category = "Japanese",
                        Price = 13,
                        ImageUrl = "https://images.unsplash.com/photo-1601924638867-3ec62b7d6f2b",
                        Description = "Crispy shrimp tempura",
                        Flavors = null,
                        Extras = new List<string>{"Extra Sauce"},
                        AllowSpecialRequest = true
                    },
                };
            }
            else if(restaurantId == 3)
            {
                return new List<Food>
                {
                    new Food {
                        FoodId = 20,
                        FoodName = "Fried Chicken",
                        Category = "Chicken",
                        Price = 15,
                        ImageUrl = "https://images.unsplash.com/photo-1562967916-eb82221dfb92",
                        Description = "Original recipe fried chicken",
                        Flavors = new List<string>{"Original", "Hot and Spicy" },
                        Extras = new List<string>{"Extra Sauce"},
                        AllowSpecialRequest = true
                    },
                    new Food {
                        FoodId = 21,
                        FoodName = "Coke",
                        Category = "Side",
                        Price = 5,
                        ImageUrl = "https://images.unsplash.com/photo-1543352634-3d6c8f5f7b58",
                        Description = "Cole-cola very good",
                        Flavors = new List<string>{ "Normal Sugar", "Less Sugar", "Zero Sugar"},
                        Extras = new List<string>{ "Normal Ice", "Less Ice", "No Ice" },
                        AllowSpecialRequest = true
                    }
                };
            }

            return new List<Food>();
        }
    }
}