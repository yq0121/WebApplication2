using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class PaymentSuccess : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadData();
            }
        }

        private void LoadData()
        {
            if (Request.QueryString["id"] == null)
                Response.Redirect("Default.aspx");

            int orderId = Convert.ToInt32(Request.QueryString["id"]);

            var orders = Session["Orders"] as List<Order>;
            if (orders == null)
                Response.Redirect("Default.aspx");

            var order = orders.FirstOrDefault(o => o.OrderId == orderId);
            if (order == null)
                Response.Redirect("Default.aspx");

            litOrderId.Text = order.OrderId.ToString();
            litMethod.Text = order.paymentMethod.ToString();
            litRef.Text = order.TransactionRef;

            lnkBack.NavigateUrl = "OrderConfirm.aspx?id" + orderId;
        }
    }
}