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
                UpdateCartCount();
        }

        private void UpdateCartCount()
        {
            var cart = Session["Cart"] as List<CartItem>;

            if (cart != null && cart.Count > 0)
            {
                int totalQty = cart.Sum(x => x.Quantity);

                lblCartCount.Text = totalQty.ToString();
                lblCartCount.Visible = true;
            }
            else
            {
                lblCartCount.Text = "0";
                lblCartCount.Visible = false;
            }
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
            string theme = Session["Theme"]?.ToString() ?? "light";

            if (theme == "dark")
                Page.Theme = "DarkTheme";
            else
                Page.Theme = "LightTheme";
        }
    }
}