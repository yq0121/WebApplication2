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
                Session["CurrentCategory"] = "All";

                // 初始化 Food 資料（之後可換 DB）
                if (Session["Foods"] == null)
                {
                    Session["Foods"] = GetFoods();
                }

                BindFoods();
                Page.DataBind();
            }
        }

        /* =======================
           Category
        ======================= */
        protected void Category_Click(object sender, CommandEventArgs e)
        {
            string category = e.CommandArgument.ToString();

            Session["CurrentCategory"] = category;

            BindFoods();

            Page.DataBind();
        }

        /* =======================
           Search
        ======================= */
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindFoods();
        }

        /* =======================
           Bind Food (Category + Search)
        ======================= */
        private void BindFoods()
        {
            var foods = Session["Foods"] as List<Food>;
            if (foods == null) return;

            string category = Session["CurrentCategory"].ToString();
            string keyword = txtSearch.Text.Trim().ToLower();

            var result = foods.AsEnumerable();

            if (category != "All")
            {
                result = result.Where(f => f.Category == category);
            }

            if (!string.IsNullOrEmpty(keyword))
            {
                result = result.Where(f =>
                    f.FoodName.ToLower().Contains(keyword));
            }

            rptFoods.DataSource = result.ToList();
            rptFoods.DataBind();
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
                    ImageUrl = "https://images.unsplash.com/photo-1550547660-d9450f859349"
                },
                new Food {
                    FoodId = 2,
                    FoodName = "Pizza",
                    Category = "Pizza",
                    Price = 15,
                    ImageUrl = "https://images.unsplash.com/photo-1601924638867-3ec62b7d6f2b"
                },
                new Food {
                    FoodId = 3,
                    FoodName = "Drink",
                    Category = "Drink",
                    Price = 5,
                    ImageUrl = "https://images.unsplash.com/photo-1544145945-f90425340c7e"
                },
                new Food {
                    FoodId = 4,
                    FoodName = "Dessert",
                    Category = "Dessert",
                    Price = 8,
                    ImageUrl = "https://images.unsplash.com/photo-1505253216365-2d6c1a49e4b4"
                }
            };
        }
    }
}
