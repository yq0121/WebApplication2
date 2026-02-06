<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="WebApplication2.ForgotPassword" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Forgot Password</title>

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

        .card-box {
            background: #1e1e1e;
            padding: 40px 45px;
            border-radius: 14px;
            width: 420px;
            color: white;
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
        }

        .title-text {
            font-size: 26px;
            margin-bottom: 25px;
            font-weight: 600;
            text-align: center;
        }

        .form-control {
            background: #2a2a2a;
            border: none;
            color: white;
        }

        .form-control::placeholder {
            color: #cccccc;
        }

        .input-group-text {
            background: #2a2a2a;
            border: none;
            color: #aaa;
        }

        .otp-row {
            display: flex;
            gap: 10px;
        }

        .btn-get-code {
            min-width: 140px;
            border-radius: 8px;
            background-color: #0d6efd;
            color: white;
            border: none;
        }

        .btn-get-code:disabled {
            background-color: #777;
            cursor: not-allowed;
        }

        .error-msg {
            color: #ff6b6b;
            margin-top: 12px;
            text-align: center;
        }

        .success-msg {
            color: #7CFC9A;
            margin-top: 12px;
            text-align: center;
        }

        .login-link {
            color: #4da3ff;
            text-decoration: none;
            font-size: 14px;
        }

        .login-link:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="card-box">
        <h3 class="title-text">Forgot Password</h3>

        <!-- Email -->
        <div class="input-group mb-3">
            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                Placeholder="Please enter your email"></asp:TextBox>
        </div>

        <!-- OTP + Get Code -->
        <div class="otp-row mb-3">
            <div class="input-group">
                <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control"
                    Placeholder="Enter verification code" Enabled="false"></asp:TextBox>
            </div>

            <asp:Button ID="btnSendOTP" runat="server" Text="Get Code"
                CssClass="btn btn-get-code" OnClick="btnSendOTP_Click" />
        </div>

        <!-- Verify -->
        <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify OTP"
            CssClass="btn btn-primary w-100" Enabled="false"
            OnClick="btnVerifyOTP_Click" />

        <!-- Message -->
        <asp:Label ID="lblMsg" runat="server" CssClass="error-msg"></asp:Label>

        <!-- Back -->
        <div class="text-center mt-3">
            <a href="Login.aspx" class="login-link">← Back to Login</a>
        </div>
    </div>

</form>
</body>
</html>