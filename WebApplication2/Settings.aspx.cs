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

                if (!isGuest)
                {
                    string theme = Session["Theme"]?.ToString() ?? "light";
                    if (ddlTheme.Items.FindByValue(theme) != null) 
                        ddlTheme.SelectedValue = theme;

                    string lang = Session["Lang"]?.ToString() ?? "en";
                    if (ddlLang.Items.FindByValue(lang) != null)
                        ddlLang.SelectedValue = lang;
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            Session["Theme"] = ddlTheme.SelectedValue;
            Session["Lang"] = ddlLang.SelectedValue;

            lblMsg.Text = "✅ Settings saved successfully!";
        }
    }
}