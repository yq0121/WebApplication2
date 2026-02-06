using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Settings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                bool isGuest = Session["Username"] == null;

                pnlGuest.Visible = isGuest;
                pnlUser.Visible = !isGuest;

                ddlTheme.SelectedValue = Session["Theme"]?.ToString() ?? "light";
                ddlTheme.SelectedValue = Session["Lang"]?.ToString() ?? "en";
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Session["Theme"] = ddlTheme.SelectedValue;
            Session["Lang"] = ddlLang.SelectedValue;
        }
    }
}