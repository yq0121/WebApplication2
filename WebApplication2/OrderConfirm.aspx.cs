using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class OrderConfirm : System.Web.UI.Page
    {
        private string OrderStatus
        {
            get { return ViewState["OrderStatus"]?.ToString() ?? "Pending"; }
            set { ViewState["OrderStatus"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadOrderDetails();
                UpdateUI();
            }
        }

        private void LoadOrderDetails()
        {
            var cart = Session["Cart"] as List<CartItem>;

            if (cart == null || cart.Count == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            gvOrderDetails.DataSource = cart;
            gvOrderDetails.DataBind();

            decimal total = 0;
            foreach (var item in cart)
                total += item.SubTotal;

            lblTotal.Text = total.ToString("0.00");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            OrderStatus = "Confirmed";

            lblMessage.Text = "Order confirmed successfully ✔";
            btnConfirm.Enabled = false;

            UpdateUI();
        }

        private void UpdateUI()
        {
            switch (OrderStatus)
            {
                case "Pending":
                    lblStatusBadge.Text = "Pending";
                    lblStatusBadge.CssClass = "badge bg-secondary";

                    progressBar.Style["width"] = "25%";
                    progressBar.InnerText = "Pending";
                    progressBar.Attributes["class"] =
                        "progress-bar progress-bar-striped progress-bar-animated bg-warning";
                    break;

                case "Confirmed":
                    lblStatusBadge.Text = "Confirmed";
                    lblStatusBadge.CssClass = "badge bg-success";

                    progressBar.Style["width"] = "50%";
                    progressBar.InnerText = "Confirmed";
                    progressBar.Attributes["class"] =
                        "progress-bar progress-bar-striped progress-bar-animated bg-success";
                    break;
            }
        }
    }
}