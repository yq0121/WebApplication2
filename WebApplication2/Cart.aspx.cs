using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class Cart : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            List<CartItem> cart = Session["Cart"] as List<CartItem>;

            if (cart == null || cart.Count == 0)
            {
                rptCart.Visible = false;
                lblEmpty.Visible = true;
                lblTotal.Text = "0.00";
                return;
            }

            lblEmpty.Visible = false;
            rptCart.Visible = true;

            rptCart.DataSource = cart;
            rptCart.DataBind();

            // Calculate Total
            decimal total = 0;
            foreach (var item in cart)
            {
                total += item.SubTotal;
            }

            lblTotal.Text = total.ToString("0.00");
        }

        protected void rptCart_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            List<CartItem> cart = Session["Cart"] as List<CartItem>;

            if (cart == null) return;

            int index = Convert.ToInt32(e.CommandArgument);

            if (index < 0 || index >= cart.Count) return;

            CartItem item = cart[index];

            if (item == null) return;

            if (e.CommandName == "plus")
            {
                item.Quantity += 1;
            }
            else if (e.CommandName == "minus")
            {
                item.Quantity -= 1;

                // 如果數量 <= 0，就刪掉
                if (item.Quantity <= 0)
                {
                    cart.Remove(item);
                }
            }
            else if (e.CommandName == "remove")
            {
                cart.Remove(item);
            }

            Session["Cart"] = cart;

            LoadCart();   // 重新綁定畫面
        }

        /*private void LoadCart()
        {
            if (Session["Cart"] == null)
            {
                rptCart.DataSource = null;
                rptCart.DataBind();
                lblTotal.Text = "0.00";
                return;
            }

            List<CartItem> cart = (List<CartItem>)Session["Cart"];

            rptCart.DataSource = cart;
            rptCart.DataBind();

            decimal total = cart.Sum(x => x.Price * x.Quantity);
            lblTotal.Text = total.ToString("0.00");
        }

        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if(e.CommandName == "remove")
            {
                int foodId = Convert.ToInt32(e.CommandArgument);

                List<CartItem> cart = (List<CartItem>)Session["Cart"];

                var item = cart.FirstOrDefault(x => x.FoodID == foodId);

                if(item != null)
                {
                    cart.Remove(item);
                }

                Session["Cart"] = cart;

                LoadCart();
            }
        }*/

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            var cart = Session["Cart"] as List<CartItem>;
            if(cart == null || cart.Count == 0)
            {
                return;
            }

            List<Order> orders = Session["Orders"] as List<Order>; 

            if (orders == null)
            {
                orders = new List<Order>();
            }
            else
            {
                orders = (List<Order>)Session["Orders"];
            }

            int newOrderId = orders.Count + 1;

            Order order = new Order
            {
                OrderId = newOrderId,
                OrderDate = DateTime.Now,
                Status = OrderStatus.Pending,
                Items = cart.Select(c => new OrderItem
                {
                    FoodName = c.FoodName,
                    Quantity = c.Quantity,
                    Price = c.Price,
                    Flavor = c.Flavor,
                    Extras = c.Extras,
                    SpecialRequest = c.SpecialRequest
                }).ToList()
            };

            orders.Add(order);

            Session["Orders"] = orders;

            Session["Cart"] = null;
            Response.Redirect("~/OrderDetail.aspx");
        }
    }
}