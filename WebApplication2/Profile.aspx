<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="WebApplication2.Profile" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col md-6">
                
                <div class="card shadow p-4">
                    <h3 class="mb-4">👤 My Profile</h3>

                    <!-- Not Login Message -->
                    <asp:Panel ID="pnlNotLogin" runat="server" Visible="false">
                        <div class="alert alert-warning">
                            Please login yo view your profile.
                        </div>
                        <a href="~/Login-Register-ForgotPwd/Login.aspx" 
                            class="btn btn-primary">Go to Login</a>
                    </asp:Panel>

                    <!-- Profile Info -->
                    <asp:Panel ID="pnlProfile" runat="server" Visible="false">
                        
                        <div class="mb-3">
                            <strong>Username:</strong>
                            <asp:Label ID="lblUsername" runat="server"></asp:Label>
                        </div>

                        <div class="mb-3">
                            <strong>Email:</strong>
                            <asp:Label ID="lblEmail" runat="server"></asp:Label>
                        </div>

                        <div class="mb-3">
                            <strong>Contact No</strong>
                            <asp:Label ID="lblContact" runat="server"></asp:Label>
                        </div>

                        <!-- Edit Button -->
                        <a href="EditProfile.aspx" class="btn btn-outline-primary">
                            <i class="bi bi-pencil"></i> Edit
                        </a>
                    </asp:Panel>
         
                </div>
            </div>
        </div>
    </div>
</asp:Content>