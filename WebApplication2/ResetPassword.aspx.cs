using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace WebApplication2
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        string connStr = "YOUR_CONNECTION_STRING_HERE";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["email"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string email = Request.QueryString["email"];
            string newPwd = txtNewPwd.Text.Trim();
            string confirmPwd = txtConfirmPwd.Text.Trim();

            if (newPwd == "" || confirmPwd == "")
            {
                lblMsg.CssClass = "error-msg";
                lblMsg.Text = "Password cannot be empty";
                return;
            }

            if (newPwd.Length > 6)
            {
                lblMsg.CssClass = "error-msg";
                lblMsg.Text = "Password must be at least 6 characters.";
                return;
            }

            if(newPwd != confirmPwd)
            {
                lblMsg.CssClass = "error-msg";
                lblMsg.Text = "Password do not match.";
                return;
            }

            // Hash password (simple SHA256)
            string hashedPwd = HashPassword(newPwd);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(
                    "UPDATE Users SET Password=@Pwd WHERE Email=@email", conn);

                cmd.Parameters.AddWithValue("@Pwd", hashedPwd);
                cmd.Parameters.AddWithValue("Email", email);

                int rows = cmd.ExecuteNonQuery();

                if(rows > 0)
                {
                    lblMsg.CssClass = "success-msg";
                    lblMsg.Text = "Password reset successfully. Redirecting to login...";

                    Response.AddHeader("REFRESH", "2;URL=Login.aspx");
                }
                else
                {
                    lblMsg.CssClass = "error.msg";
                    lblMsg.Text = "Reset failed. Please try again.";
                }
            }
        }

        private string HashPassword(string password)
        {
            using(SHA256 sha = SHA256.Create())
            {
                byte[] bytes = sha.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();

                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));

                return sb.ToString();
            }
        }
    }
}