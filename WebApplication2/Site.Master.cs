using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using WebApplication2.Models;

namespace WebApplication2
{
    public partial class SiteMaster : MasterPage
    {
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            System.Web.Security.FormsAuthentication.SignOut();

            Session.Clear();
            Session.Abandon();

            Response.Redirect("~/Login-Register-ForgotPwd/Login.aspx");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            { 
                UpdateCartCount();
            }
        }

        private void UpdateCartCount()
        {
            if (Session["Cart"] != null)
            {
                var cart = Session["Cart"] as List<WebApplication2.Models.CartItem>;

                int totalQty = 0;
                foreach (var item in cart)
                {
                    totalQty += item.Quantity;
                }

                lblCartCount.Text = totalQty.ToString();
                lblCartCount.Visible = totalQty > 0;
            }
            else
            {
                lblCartCount.Text = "0";
                lblCartCount.Visible = false;
            }
        }

    }
}