using System;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;

namespace WebApplication2
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string connStr = "YOUR_CONNECTION_STRING_HERE";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtOTP.Enabled = false;
                btnVerifyOTP.Enabled = false;
            }
        }

        private string GenerateOTP()
        {
            Random rnd = new Random();
            return rnd.Next(100000, 999999).ToString();
        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (email == "")
            {
                lblMsg.CssClass = "error-msg";
                lblMsg.Text = "Please enter your email.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                // Check email exists
                SqlCommand checkCmd = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Email=@Email", conn);
                checkCmd.Parameters.AddWithValue("@Email", email);

                int exists = (int)checkCmd.ExecuteScalar();

                if (exists == 0)
                {
                    lblMsg.CssClass = "error-msg";
                    lblMsg.Text = "This email does not exist.";
                    return;
                }

                // Generate OTP
                string otp = GenerateOTP();
                DateTime expire = DateTime.Now.AddMinutes(5);

                // Save OTP
                SqlCommand insertCmd = new SqlCommand(
                    @"INSERT INTO PasswordResetOTP (Email, OTP, ExpireTime, IsUsed)
                      VALUES (@Email, @OTP, @Expire, 0)", conn);

                insertCmd.Parameters.AddWithValue("@Email", email);
                insertCmd.Parameters.AddWithValue("@OTP", otp);
                insertCmd.Parameters.AddWithValue("@Expire", expire);
                insertCmd.ExecuteNonQuery();

                // Send Email
                SendOTPEmail(email, otp);

                // Enable OTP input & verify button
                txtOTP.Enabled = true;
                btnVerifyOTP.Enabled = true;

                // Optional: disable resend
                btnSendOTP.Enabled = false;

                lblMsg.CssClass = "success-msg";
                lblMsg.Text = "OTP has been sent to your email.";
            }
        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string otp = txtOTP.Text.Trim();

            if (otp == "")
            {
                lblMsg.CssClass = "error-msg";
                lblMsg.Text = "Please enter OTP.";
                return;
            }

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(
                    @"SELECT TOP 1 * FROM PasswordResetOTP
                      WHERE Email=@Email AND OTP=@OTP AND IsUsed=0
                      ORDER BY Id DESC", conn);

                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@OTP", otp);

                SqlDataReader dr = cmd.ExecuteReader();

                if (!dr.Read())
                {
                    lblMsg.CssClass = "error-msg";
                    lblMsg.Text = "Invalid OTP.";
                    return;
                }

                DateTime expire = Convert.ToDateTime(dr["ExpireTime"]);
                dr.Close();

                if (DateTime.Now > expire)
                {
                    lblMsg.CssClass = "error-msg";
                    lblMsg.Text = "OTP has expired.";
                    return;
                }

                // Mark OTP used
                SqlCommand updateCmd = new SqlCommand(
                    "UPDATE PasswordResetOTP SET IsUsed=1 WHERE Email=@Email AND OTP=@OTP", conn);

                updateCmd.Parameters.AddWithValue("@Email", email);
                updateCmd.Parameters.AddWithValue("@OTP", otp);
                updateCmd.ExecuteNonQuery();

                // Go to reset password page
                Response.Redirect("ResetPassword.aspx?email=" + Server.UrlEncode(email));
            }
        }

        private void SendOTPEmail(string toEmail, string otp)
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress("yourgmail@gmail.com");
            mail.To.Add(toEmail);
            mail.Subject = "Password Reset OTP";
            mail.Body = "Your OTP code is: " + otp + "\nThis code will expire in 5 minutes.";

            SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
            smtp.Credentials = new NetworkCredential("yourgmail@gmail.com", "YOUR_APP_PASSWORD");
            smtp.EnableSsl = true;

            smtp.Send(mail);
        }
    }
}
