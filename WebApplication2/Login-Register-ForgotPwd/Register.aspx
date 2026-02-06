<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WebApplication2.Register" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8"/>
    <title>Register</title>

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

        .register-card{
            background: #1e1e1e;
            padding: 30px;
            border-radius: 12px;
            width: 380px;
            color: white;
            box-shadow: 0 0 30px rgba(0,0,0,0.4);
        }

        .register-card h3{
            text-align: center;
            margin-bottom: 25px
        }

        .form-control{
            background: #2a2a2a;
            border: none;
            color: white;
        }

        .form-control:focus{
            background: #2a2a2a;
            color: white;
            box-shadow: 0 0 0 0.2rem rgba(13, 110, 253,.25);
        }

        .form-control::placeholder{
            color: #cccccc;
            opacity: 1;
        }

        .input-group-text{
            background: #2a2a2a;
            border: none;
            color: #aaa;
        }

        .btn-register{
            width: 100%;
            margin-top: 15px;
        }

        .login-link{
            color: #4da3ff;
            text-decoration: none;
            font-size: 14px;
        }

        .login-link:hover{
            text-decoration: underline;
            color: #7bbcff;
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

        .error-msg{
            color: #ff6b6b;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-card">
            <h3>Register Menu</h3>

            <!-- Username -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-person"></i>
                </span>
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control" Placeholder="Username"></asp:TextBox>
            </div>

            <!-- Email -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-envelope"></i>
                </span>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Email Address"></asp:TextBox>
            </div>

            <asp:RequiredFieldValidator ControlToValidate="txtEmail"
                ErrorMessage="Email is required" CssClass="text-danger"
                Display="Dynamic" runat="server"></asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ControlToValidate="txtEmail"
                ErrorMessage="Invalid email format" CssClass="text-danger"
                Display="Dynamic" ValidationExpression="\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$"
                runat="server"></asp:RegularExpressionValidator>

            <!-- Contact No -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-phone"></i>
                </span>
                <asp:TextBox ID="txtContactNo" runat="server" CssClass="form-control" Placeholder="Contact No"></asp:TextBox>
            </div>

            <asp:RequiredFieldValidator ControlToValidate="txtContactNo"
                ErrorMessage="Contact No is required" CssClass="text-danger"
                Display="Dynamic" runat="server"></asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ControlToValidate="txtContactNo"
                ErrorMessage="Contact no must be 8-12 digit" CssClass="text-danger"
                Display="Dynamic" ValidationExpression="^\d{8, 12}$" runat="server"></asp:RegularExpressionValidator>

            <!-- Password -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-lock"></i>
                </span>
                <asp:TextBox ID="txtPwd" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Password"
                    ClientIDMode="Static"></asp:TextBox>

                <button type="button" class="input-group-text toggle-password" 
                    onclick="togglePassword('txtPwd', 'eyeIcon1')">
                    <i id="eyeIcon1" class="bi bi-eye"></i>
                </button>
            </div>

             <asp:RequiredFieldValidator ControlToValidate="txtPwd"
                ErrorMessage="Password is required" CssClass="text-danger" 
                Display="Dynamic" runat="server"></asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ControlToValidate="txtPwd"
                ErrorMessage="Password must be at least 6 characters"
                CssClass="text-danger" Display="Dynamic"
                ValidationExpression=".{6,}" runat="server"></asp:RegularExpressionValidator>

            <!-- Confirm Password -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-lock-fill"></i>
                </span>
                <asp:TextBox ID="txtConfirm" runat="server" CssClass="form-control" TextMode="Password" Placeholder="Confirm Password"
                    ClientIDMode="Static"></asp:TextBox>

                <button type="button" class="input-group-text toggle-password" 
                    onclick="togglePassword('txtConfirm', 'eyeIcon2')">
                    <i id="eyeIcon2" class="bi bi-eye"></i>
                </button>
            </div>

            <asp:RequiredFieldValidator ControlToValidate="txtConfirm"
                ErrorMessage="Please confirm your password" CssClass="text-danger"
                Display="Dynamic" runat="server"></asp:RequiredFieldValidator>

            <asp:RegularExpressionValidator ControlToCompare="txtPwd" 
                ControlToValidate="txtConfirm" ErrorMessage="Password do not match"
                CssClass="text-danger" Display="Dynamic" runat="server"></asp:RegularExpressionValidator>

            <!-- Register Button-->
            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary btn-register" OnClick="btnRegister_Click" Width="320px" />

            <!-- Back to Login -->
            <div class="text-center mt-3">
                <span style="color: #aaa">Already have an account?</span>
                <a href="Login.aspx" class="login-link">Login</a>
            </div>
            
            <!-- Error / Info -->
            <asp:Label ID="lblMsg" runat="server" CssClass="error-msg"></asp:Label>
        </div>
    </form>

    <script>
        function togglePassword(inputId, iconId) {
            var pwd = document.getElementById(inputId);
            var icon = document.getElementById(iconId);

            if (!pwd) {
                alert("Cannot find password blank");
                return;
            }

            if (pwd.type === "password") {
                pwd.type = "text";
                icon.className = "bi bi-eye-slash";
            } else {
                pwd.type = "password";
                icon.className = "bi bi-eye";
            }
        }
    </script>
</body>
</html>
