<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="WebApplication2.EditProfile" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5" style="max-width:600px;">
        <div class="card shadow-lg p-4">

            <h3 class="mb-4">👤 Edit Profile</h3>

            <!-- Username -->
            <div class="mb-3">
                <label class="form-label">Username</label>
                <asp:TextBox ID="txtUsername" runat="server"
                    CssClass="form-control" ></asp:TextBox>

                <asp:RequiredFieldValidator ControlToValidate="txtUsername"
                    ErrorMessage="Email is required" CssClass="text-danger"
                    Display="Dynamic" runat="server"></asp:RequiredFieldValidator>
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label class="form-label">Email</label>
                <asp:TextBox ID="txtEmail" runat="server"
                    CssClass="form-control" TextMode="Email"></asp:TextBox>

                <asp:RequiredFieldValidator ControlToValidate="txtEmail"
                    ErrorMessage="Email is required" CssClass="text-danger"
                    Display="Dynamic" runat="server"></asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator ControlToValidate="txtEmail"
                    ErrorMessage="Invalid email format" CssClass="text-danger"
                    Display="Dynamic" ValidationExpression="\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,3})+$"
                    runat="server"></asp:RegularExpressionValidator>
            </div>

            <!-- Contact No -->
            <div class="mb-3">
                <label class="form-label">Contact No</label>
                <asp:TextBox ID="txtContact" runat="server" CssClass="form-control"
                    Placeholder="e.g. 0123456789"></asp:TextBox>

                <asp:RequiredFieldValidator ControlToValidate="txtContact"
                    ErrorMessage="Contact number is required" CssClass="text-danger"
                    Display="Dynamic" runat="server"></asp:RequiredFieldValidator>

                <asp:RegularExpressionValidator ControlToValidate="txtContact"
                    ErrorMessage="Contact must be 10-11 digit" CssClass="text-danger"
                    Display="Dynamic" ValidationExpression="^\d{10,11}$" runat="server"></asp:RegularExpressionValidator>
            </div>

            <!-- Buttons -->
            <div class="d-flex justify-content-between mt-4">
                <a href="Default.aspx" class="btn btn-outline-secondary">
                    ← Back
                </a>

                <asp:Button ID="btnSave" runat="server" Text="Save Changes"
                    CssClass="btn btn-primary" OnClick="btnSave_Click" />
            </div>

            <!-- Message -->
            <asp:Label ID="lblMsg" runat="server" CssClass="text-success mt-3 d-block"></asp:Label>

        </div>
    </div>
</asp:Content>