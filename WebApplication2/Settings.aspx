<%@ Page Title="Settings" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Settings.aspx.cs" Inherits="WebApplication2.Settings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Panel ID="pnlGuest" runat="server" Visible="false">
        <div class="alert alert-info">
            You are browsing as <b>Guest</b>.
            Login to access full settings.
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlUser" runat="server" Visible="false">

        <h3>General Settings</h3>

        <div class="settings-item">
            <label>Theme</label>
            <asp:DropDownList ID="ddlTheme" runat="server">
                <asp:ListItem Text="Light" Value="light"></asp:ListItem>
                <asp:ListItem Text="Dark" Value="dark"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <div class="settings-item">
            <label>Language</label>
            <asp:DropDownList ID="ddlLang" runat="server">
                <asp:ListItem Text="English" Value="en"></asp:ListItem>
                <asp:ListItem Text="Chinese" Value="zh"></asp:ListItem>
            </asp:DropDownList>
        </div>

        <asp:Button ID="btnSave" runat="server" 
            Text="Save Settings" CssClass="btn btn-primary"
            OnClick="btnSave_Click" />

    </asp:Panel>

</asp:Content>