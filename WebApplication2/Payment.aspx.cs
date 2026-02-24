using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class Payment : System.Web.UI.Page
    {
        private Order currentOrder;

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
                Response.Redirect("Default.aspx");

            int orderId = Convert.ToInt32(Request.QueryString["id"]);

            var orders = Session["Orders"] as List<Order>;
            if (orders == null)
                Response.Redirect("Default.aspx");

            currentOrder = orders.FirstOrDefault(o => o.OrderId == orderId);
            if (currentOrder == null)
                Response.Redirect("Default.aspx");

            if (currentOrder.Status.ToString() == "Cancelled")
                Response.Redirect("Default.aspx");

            litOrderId.Text = currentOrder.OrderId.ToString();
            litTotal.Text = currentOrder.Total.ToString("0.00");
        }

        protected void btnPay_Click (object sender, EventArgs e)
        {
            if(rblPaymentMethod.SelectedIndex == -1)
            {
                lblMsg.Text = "Please select a payment method.";
                return;
            }

            int orderId = Convert.ToInt32(Request.QueryString["id"]);
            var orders = Session["Orders"] as List<Order>;
            var order = orders.FirstOrDefault(o => o.OrderId == orderId);

            // Update Status
            order.paymentStatus = PaymentStatus.Paid;

            // Optional: Save Payment Method
            order.paymentMethod = (PaymentMethod)Enum.Parse(typeof(PaymentMethod), rblPaymentMethod.SelectedValue);

            // Generate fake transaction ref
            order.TransactionRef = "TXN" + DateTime.Now.Ticks.ToString().Substring(10);

            // Redirect to confirmation page
            Response.Redirect("PaymentSuccess.aspx?id=" + orderId);
        }

    }
}