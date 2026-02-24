using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class OrderConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrder();
            }
        }

        private void LoadOrder()
        {
            if (Request.QueryString["id"] == null)
                Response.Redirect("About.aspx");

            int orderId = Convert.ToInt32(Request.QueryString["id"]);

            var orders = Session["Orders"] as List<Order>;
            if (orders == null)
                Response.Redirect("About.aspx");

            var order = orders.FirstOrDefault(o => o.OrderId == orderId);
            if (order == null)
                Response.Redirect("About.aspx");

            // Basic Info
            litOrderId.Text = order.OrderId.ToString();
            litOrderDate.Text = order.OrderDate.ToString("dd MM yyyy HH:mm");
            litTotal.Text = order.Total.ToString("0.00");

            // Status Badge
            statusBadge.InnerHtml = $"<span class='{GetStatusClass(order.Status.ToString())}'>{order.Status}</span>";

            // Items
            rptItems.DataSource = order.Items;
            rptItems.DataBind();

            //Payment Link
            lnkPayment.NavigateUrl = "Payment.aspx?id=" + order.OrderId;

            // Detail Link
            lnkDetail.NavigateUrl = "OrderDeatil.aspx?id=" + order.OrderId;
        }

        protected string GetStatusClass(string Status)
        {
            switch(Status){
                case "Pending":
                    return "bg bg-warning";
                case "Preparing":
                    return "bg bg-primary";
                case "Confirmed":
                    return "bg bg-success";
                case "Cancelled":
                    return "bg bg-danger";
                default:
                    return "bg bg-secondary";
            }
        }
    }
}