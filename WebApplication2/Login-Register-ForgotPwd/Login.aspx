<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="WebApplication2.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Login</title>

    <!-- Bootstrap + Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body {
            height: 100vh;
            background: linear-gradient(135deg, #1f2933, #111827);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .login-card {
            background: #1e1e1e;
            padding: 30px;
            border-radius: 12px;
            width: 350px;
            color: white;
            box-shadow: 0 0 30px rgba(0,0,0,0.4);
        }

        .login-card h3 {
            text-align: center;
            margin-bottom: 25px;
        }

        .form-control {
            background: #2a2a2a;
            border: none;
            color: white;
        }

        .form-control:focus {
            background: #2a2a2a;
            color: white;
            box-shadow: 0 0 0 0.2rem rgba(13,110,253,.25);
        }

        .form-control::placeholder{
            color: #cccccc;
            opacity: 1;
        }

        .input-group-text {
            background: #2a2a2a;
            border: none;
            color: #aaa;
        }

        .btn-register {
            width: 100%;
            margin-top: 15px;
        }

        .error-msg {
            color: #ff6b6b;
            margin-top: 10px;
            text-align: center;
        }

        .toggle-password{
            cursor: pointer;
            background: #2a2a2a;
            border: none;
            color: #ccc;

            position: relative;
            z-index: 10;
        }

        .toggle-password:hover{
            color: white;
        }

        .register-link{
            color: #4da3ff;
            text-decoration: none;
            font-size: 14px;
        }

        .register-link:hover{
            text-decoration: underline;
            color: #7bbcff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-card">
            <h3>System Login</h3>

            <!-- Username -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-person"></i>
                </span>
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
            </div>

            <!-- Password -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-lock"></i>
                </span>
                <asp:TextBox ID="txtPwd" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password" ClientIDMode="Static"></asp:TextBox>

                <button type="button" class="input-group-text toggle-password" OnClick="togglePassword()">
                    <i ID="eyeIcon" class="bi bi-eye"></i>
                </button>
            </div>

            <!-- Login Button -->
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary btn-login" OnClick="btnLogin_Click" Width="290px"  />

            <asp:Button ID="btnGuest" runat="server" Text="Continue as Guest" CssClass="btn btn-secondary w-100 mt-3" OnClick="btnGuest_Click" />

            <div class="d-flex justify-content-between mt-3">
                <a href="ForgotPassword.aspx" class="register-link">Forgot Password?</a>

                <a href="Register.aspx" class="register-link">Register</a> 
            </div>

            <!-- Error Message -->
            <asp:Label ID="lblMsg" runat="server" CssClass="error-msg"></asp:Label>
        </div>
    </form>

    <script>
        function togglePassword() {
            var pwd = document.getElementById("<%= txtPwd.ClientID %>");
            var icon = document.getElementById("eyeIcon");

            if (!pwd) {
                alert("Cannot find the password blank")
                return;
            }

            if (pwd.type === "password") {
                pwd.type = "text";
                icon.className = "bi bi-eye-slash";
            } else {
                pwd.type = "password";
                icon.className = "bi bi-eye"
            }
        }
    </script>
</body>
</html>
