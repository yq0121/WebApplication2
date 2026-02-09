using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrders();
            }
        }

        private void LoadOrders(List<Order> source = null)
        {
            var orders = source ?? Session["Orders"] as List<Order>;

            if (orders == null || orders.Count == 0)
            {
                pnlEmpty.Visible = true;
                rptOrders.Visible = false;
                return;
            }

            pnlEmpty.Visible = false;
            rptOrders.Visible = true;

            rptOrders.DataSource = orders
                .OrderByDescending(o => o.OrderDate)
                .ToList();

            rptOrders.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            var orders = Session["Orders"] as List<Order>;
            if (orders == null) return;

            string keyword = txtSearch.Text.Trim();

            var result = orders;

            if (!string.IsNullOrEmpty(keyword))
            {
                result = orders
                    .Where(o => o.OrderId.ToString().Contains(keyword))
                    .ToList();
            }

            LoadOrders(result);
        }

        
        protected void rptOrders_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var order = e.Item.DataItem as Order;
            var rptItems = e.Item.FindControl("rptItems") as Repeater;
            rptItems.DataSource = order.Items ?? new List<OrderItem>();
            rptItems.DataBind();
        }
        
    }
}
