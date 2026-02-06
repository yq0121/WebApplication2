<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="WebApplication2.ResetPassword" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="utf-8"/>
    <title>Forgot Password</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
        body{
            height:100vh;
            background: linear-gradient(135deg, #1f2933, #111827);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .card-box{
            background: #1e1e1e;
            padding: 40px 45px;
            border-radius: 14px;
            width: 420px;
            color: white;
            box-shadow: 0 0 40px rgba(0,0,0,0.6);
        }

        .title-text{
            font-size: 26px;
            margin-bottom: 25px;
            font-weight: 600;
            text-align: center;
        }

        .form-control{
            background: #2a2a2a;
            border: none;
            color: white;
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

        .toggle-password{
            cursor: pointer;
            background: #2a2a2a;
            border: none;
            color: #ccc;
        }

        .toggle-password:hover{
            color:white;
        }

        .btn-reset{
            width: 100%;
            margin-top: 15px;
        }

        .error-msg{
            color: #ff6b6b;
            margin-top: 12px;
            text-align: center;
        }

        .success-msg{
            color: #7CFC9A;
            margin-top: 12px;
            text-align: center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="card-box">
            <h3 class="title-text">Reset Password</h3>

            <!-- New Password -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-lock"></i>
                </span>
                <asp:TextBox ID="txtNewPwd" runat="server" CssClass="form-control"
                    TestMode="Password" Placeholder="New Password" ClientIDMode="Static"></asp:TextBox>

                <button type="button" class="input-group-text toggle-password"
                    onclick="togglePassword('txtNewPwd', 'eye1')">
                    <i id="eye1" class="bi bi-eye"></i>
                </button>
            </div>

            <!-- Confirm Password -->
            <div class="input-group mb-3">
                <span class="input-group-text">
                    <i class="bi bi-lock-fill"></i>
                </span>
                <asp:TextBox ID="txtConfirmPwd" runat="server" CssClass="form-control"
                    TestMode="Password" Placeholder="Confirm Password" ClientIDMode="Static"></asp:TextBox>

                <button type="button" class="input-group-text toggle-password"
                    onclick="togglePassword('txtConfirmPwd', 'eye2')">
                    <i id="eye2" class="bi bi-eye"></i>
                </button>
            </div>

            <!-- Reset Button -->
            <asp:Button ID="btnReset" runat="server" Text="Reset Password"
                CssClass="btn btn-success btn-reset" OnClick="btnReset_Click" />

            <!-- Message -->
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>

        <script>
            function togglePassword(inputId, iconId) {
                var pwd = document.getElementById(inputId);
                var icon = document.getElementById(iconId);

                if (pwd.type === "password") {
                    pwd.type = "text";
                    icon.className = "bi bi-eye-slash";
                } else {
                    pwd.type = "text";
                    icon.className = "bi bi-eye";
                }
            }
        </script>
    </form>
</body>
</html>
