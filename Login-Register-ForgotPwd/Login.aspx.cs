using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string user = txtUser.Text.Trim();
            string pwd = txtPwd.Text.Trim();

            if(user == "" || pwd == "")
            {
                lblMsg.Text = "Please fill in all the blanks.";
                return;
            }

            if(user == "admin" && pwd == "1234")
            {
                Session["Username"] = user;
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                lblMsg.Text = "Invalid username or password.";
            }
        }

        protected void txtUser_TextChanged(object sender, EventArgs e)
        {

        }
    }
}