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
            string selectedStatus = ddlStatus.SelectedValue;

            var result = orders.AsQueryable();

            if (!string.IsNullOrEmpty(keyword))
            {
                result = result.Where(o => o.OrderId.ToString().Contains(keyword));
            } 
            
            if (!string.IsNullOrEmpty(selectedStatus))
            {
                result = result.Where(o => o.Status.ToString() == (selectedStatus));
            }

            LoadOrders(result.ToList());
        }

        protected void rptOrders_ItemCommand(object sender, RepeaterCommandEventArgs e)
        {
            if (e.Item.ItemType != ListItemType.Item && e.Item.ItemType != ListItemType.AlternatingItem) return;

            var order = e.Item.DataItem as Order;
            var rptItems = e.Item.FindControl("rptItems") as Repeater;
            rptItems.DataSource = order.Items ?? new List<OrderItem>();
            rptItems.DataBind();
        }

        protected string GetStatusClass(string Status)
        {
            switch (Status)
            {
                case "Pending":
                    return "badge badge-warning";
                case "Preparing":
                    return "badge badge-primary";
                case "Confirmed":
                    return "badge badge-success";
                case "Cancelled":
                    return "badge badge-danger";
                default:
                    return "badge badge-secondary";
            }
        }

        protected string GetCardClass(string status)
        {
            if(status == "Completed")
            {
                return "card mb-3 shadow-sm p-3 bg-light text-muted";
            }

            return "card mb-3 shadow-sm p-3";
        }
    }
}
