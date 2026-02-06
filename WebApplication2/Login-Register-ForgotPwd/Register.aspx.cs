using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication2
{
    public partial class Register : System.Web.UI.Page
    {
        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string user = txtUser.Text.Trim(); ;
            string email = txtEmail.Text.Trim();
            string contactNo = txtContactNo.Text.Trim();
            string pwd = txtPwd.Text.Trim();
            string confirmPwd = txtConfirm.Text.Trim();

            if(user == "" || email == "" || contactNo == "" ||pwd == "" || confirmPwd == "")
            {
                lblMsg.Text = "Please fill in all the blanks.";
                return;
            }

            if(pwd != confirmPwd)
            {
                lblMsg.Text = "Password not match";
                return;
            }

            lblMsg.ForeColor = System.Drawing.Color.Green;
            lblMsg.Text = "Register successful! You can now login.";

            Response.Redirect("~/Default.aspx");
        }
    }
}