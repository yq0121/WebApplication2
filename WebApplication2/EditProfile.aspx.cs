using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class EditProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtUsername.Text = Session["Username"]?.ToString() ?? "Guest";
                txtEmail.Text = Session["Email"]?.ToString() ?? "";
                txtContact.Text = Session["Contact"]?.ToString() ?? "";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            Session["Username"] = txtUsername.Text.Trim();
            Session["Email"] = txtEmail.Text.Trim();
            Session["Contact"] = txtContact.Text.Trim();

            lblMsg.Text = "Profile updated successfully ✔";
        }
    }
}