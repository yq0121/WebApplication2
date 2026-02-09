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
            var orders = Session["Orders"] as List<Order>;

            if (orders == null || orders.Count == 0)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            // Get the latest order
            var latestOrder = orders.LastOrDefault();

            if (latestOrder == null)
            {
                Response.Redirect("Default.aspx");
                return;
            }

            gvOrderDetails.DataSource = latestOrder.Items;
            gvOrderDetails.DataBind();

            lblTotal.Text = latestOrder.Total.ToString("0.00");
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