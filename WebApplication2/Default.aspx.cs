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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 初始化分類
                if(Session["CurrentCategory"] == null)
                    Session["CurrentCategory"] = "All";

                // 初始化 Food 資料（之後可換 DB）
                if (Session["Foods"] == null)
                    Session["Foods"] = GetFoods();

                BindFoods();
            }
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
                HightlightCategory();
            }

            // Price
            if (priceFilter == "Low")
                result = result.Where(f => f.Price > 10);
            else if (priceFilter == "Mid")
                result = result.Where(f => f.Price >= 10 && f.Price <= 15);
            else if (priceFilter == "High")
                result = result.Where(f => f.Price > 15);

            var finalList = result.ToList();

            rptFoods.DataSource = finalList;
            rptFoods.DataBind();

            pnlEmpty.Visible = finalList.Count == 0;
        }

        private void HightlightCategory()
        {
            string current = Session["CurrentCategory"]?.ToString() ?? "All";

            foreach(Control c in Page.Controls)
            {
                HighlightRecursive(c, current);
            }
        }

        private void HighlightRecursive(Control parent, string current)
        {
            foreach(Control c in parent.Controls)
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
        protected void Category_Click(object sender, CommandEventArgs e)
        {
            string category = e.CommandArgument.ToString();

            Session["CurrentCategory"] = category;
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
        private List<Food> GetFoods()
        {
            return new List<Food>
            {
                new Food {
                    FoodId = 1,
                    FoodName = "Burger",
                    Category = "Burger",
                    Price = 12,
                    ImageUrl = "https://images.unsplash.com/photo-1550547660-d9450f859349",
                    Description = "Juicy grilled beef patty served with fresh lettuce, tomatoes, and melted cheese in a soft bun. Perfect for a satisfying and hearty meal."
                },
                new Food {
                    FoodId = 2,
                    FoodName = "Pizza",
                    Category = "Pizza",
                    Price = 15,
                    ImageUrl = "https://images.unsplash.com/photo-1601924638867-3ec62b7d6f2b",
                    Description = "Hot and freshly baked pizza topped with rich tomato sauce, melted mozzarella cheese, and a crispy crust that delivers comfort in every bite."
                },
                new Food {
                    FoodId = 3,
                    FoodName = "Drink",
                    Category = "Drink",
                    Price = 5,
                    ImageUrl = "https://images.unsplash.com/photo-1544145945-f90425340c7e",
                    Description = "Refreshing cold beverage to quench your thirst. Choose your preferred sugar and ice level for the perfect drink experience."
                },
                new Food {
                    FoodId = 4,
                    FoodName = "Dessert",
                    Category = "Dessert",
                    Price = 8,
                    ImageUrl = "https://images.unsplash.com/photo-1505253216365-2d6c1a49e4b4",
                    Description = "Sweet and delightful dessert made to satisfy your cravings. Soft, creamy, and perfectly balanced for a delightful ending to your meal."
                }
            };
        }
    }
}
