using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class OrderDetail : System.Web.UI.Page
    {
        protected int CurrentOrderId
        {
            get
            {
                int id;
                int.TryParse(Request.QueryString["id"], out id);
                return id;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                if (CurrentOrderId == 0)
                {
                    Response.Redirect("~/About.aspx");
                    return;
                }

                LoadOrder(CurrentOrderId);
            }
        }

        private void LoadOrder(int orderId)
        {
            var orders = Session["Orders"] as List<Order>;
            var order = orders?.FirstOrDefault(o => o.OrderId == orderId);

            if(order == null)
            {
                Response.Redirect("~/About.aspx");
                return;
            }

            lblOrderId.Text = order.OrderId.ToString();
            lblOrderDate.Text = order.OrderDate.ToString("dd MM yyyy HH:mm");

            rptItems.DataSource = order.Items;
            rptItems.DataBind();

            decimal total = order.Items.Sum(i => i.SubTotal);
            lblTotal.Text = order.Total.ToString("0.00");
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            var orders = Session["Orders"] as List<Order>;

            if (orders == null) return;

            var order = orders.FirstOrDefault(o => o.OrderId == CurrentOrderId);

            if (order != null)
            {
                orders.Remove(order);
                Session["Orders"] = orders;
            }

            Response.Redirect("~/About.aspx");
        }
    }
}