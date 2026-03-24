<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebApplication2.Settings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlGuest" runat="server" Visible="false">
        <div class="alert alert-info">
            You are browsing as <b>Guest</b>.
            Login to access full settings.
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlUser" runat="server" Visible="false">

        <div class="card shadow-sm p-4">
            <h4 class="mb-4">⚙️ General Settings</h4>

            <div class="mb-3">
                <label class="form-label">Theme</label>
                <asp:DropDownList ID="ddlTheme" runat="server" CssClass="form-control">
                    <asp:ListItem Text="Light" Value="light"></asp:ListItem>
                    <asp:ListItem Text="Dark" Value="dark"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="mb-3">
                <label class="form-label">Language</label>
                <asp:DropDownList ID="ddlLang" runat="server" CssClass="form-control">
                    <asp:ListItem Text="English" Value="en"></asp:ListItem>
                    <asp:ListItem Text="Chinese" Value="zh"></asp:ListItem>
                </asp:DropDownList>
            </div>

            <asp:Button ID="btnSave" runat="server" 
                Text="💾 Save Settings" CssClass="btn btn-primary"
                OnClick="btnSave_Click" />

            <asp:Label ID="lblMsg" runat="server" CssClass="text-success ms-3"></asp:Label> 

        </div>

    </asp:Panel>
</asp:Content>