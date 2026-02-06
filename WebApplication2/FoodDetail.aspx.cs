using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class FoodDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1️⃣ Check food id
                if (Request.QueryString["id"] == null ||
                    !int.TryParse(Request.QueryString["id"], out int foodId))
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // 2️⃣ Get food from session
                var foods = Session["Foods"] as List<Food>;
                var food = foods?.FirstOrDefault(f => f.FoodId == foodId);

                if (food == null)
                {
                    Response.Redirect("Default.aspx");
                    return;
                }

                // 3️⃣ Display food info
                lblFoodName.Text = food.FoodName;
                lblPrice.Text = food.Price.ToString("0.00");
                imgFood.Src = food.ImageUrl;

                string fullDesc = food.Description ?? "";
                string preview = fullDesc;

                fullDesc = fullDesc.Replace("\n", "<br />");
                if (preview.Length > 100)
                {
                    preview = preview.Substring(0, 100) + "...";
                }

                litDescription.Text = preview;
                litFullDescription.Text = fullDesc;
                lblModalFoodName.Text = food.FoodName;

                // 4️⃣ Control option panels by category
                pnlDrinkOptions.Visible = false;
                pnlDessertOptions.Visible = false;
                pnlFoodOptions.Visible = false;

                if (food.Category == "Drink")
                {
                    pnlDrinkOptions.Visible = true;
                }
                else if (food.Category == "Dessert")
                {
                    pnlDessertOptions.Visible = true;
                }
                else
                {
                    // Burger / Pizza / Other food
                    pnlFoodOptions.Visible = true;
                }

                txtSpecialRequest.Visible = true;
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out int foodId))
                return;

            var foods = Session["Foods"] as List<Food>;
            var food = foods?.FirstOrDefault(f => f.FoodId == foodId);
            if (food == null) return;

            string flavor = "";
            string extras = "";

            // 🧋 Drink
            if (food.Category == "Drink")
            {
                flavor = ddlSugarLevel.SelectedValue;

                extras = string.Join(",",
                    rblIceLevel.Items.Cast<ListItem>()
                    .Where(i => i.Selected)
                    .Select(i => i.Value));
            }
            // 🍰 Dessert
            else if (food.Category == "Dessert")
            {
                flavor = ddlDessertFlavor.SelectedValue;

                extras = string.Join(",",
                    cblDessertExtras.Items.Cast<ListItem>()
                    .Where(i => i.Selected)
                    .Select(i => i.Value));
            }
            // 🍔 Food
            else
            {
                flavor = ddlFlavor.SelectedValue;

                extras = string.Join(",",
                    cblExtras.Items.Cast<ListItem>()
                    .Where(i => i.Selected)
                    .Select(i => i.Value));
            }

            string specialRequest = txtSpecialRequest.Text;

            var cart = Session["Cart"] as List<CartItem> ?? new List<CartItem>();

            var existing = cart.FirstOrDefault(x =>
                x.FoodID == food.FoodId &&
                x.Flavor == flavor &&
                x.Extras == extras &&
                x.SpecialRequest == specialRequest
            );

            if (existing != null)
            {
                existing.Quantity++;
            }
            else
            {
                cart.Add(new CartItem
                {
                    FoodID = food.FoodId,
                    FoodName = food.FoodName,
                    Price = food.Price,
                    Quantity = 1,
                    ImageUrl = food.ImageUrl,
                    Flavor = flavor,
                    Extras = extras,
                    SpecialRequest = specialRequest
                });
            }

            Session["Cart"] = cart;
            Response.Redirect("Cart.aspx");
        }
    }
}