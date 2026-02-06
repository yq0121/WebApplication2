using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data.SqlClient;

namespace WebApplication2
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Username"] == null || Session["UserType"]?.ToString() == "Guest")
                {
                    pnlNotLogin.Visible = true;
                    pnlProfile.Visible = false;
                }
                else
                {
                    pnlNotLogin.Visible = false;
                    pnlProfile.Visible = true;

                    /*LoadProfile();*/

                    lblUsername.Text = Session["Username"].ToString();
                    lblEmail.Text = Session["Email"]?.ToString() ?? "-";
                    lblContact.Text = Session["Contact"]?.ToString() ?? "-";
                }
            }
        }

        /*void LoadProfile()
        {
            string username = Session["Username"].ToString();

            string cs = ConfigurationManager.ConnectionStrings["DeafultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(cs))
            {
                string sql = "SELECT Username, Email, ContactNo FROM Users WHERE Username =@Username";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblUsername.Text = dr["Username"].ToString();
                    lblEmail.Text = dr["Email"].ToString();
                    lblConatct.Text = dr["ContactNo"].ToString();
                }
            }
        }*/

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/Login-Register-ForgotPwd/Login.aspx");
        }
    }
}