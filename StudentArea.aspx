<%@ Page Title="Student Area" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="StudentArea.aspx.cs" Inherits="StudentArea" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-card">
        <h2>Student Dashboard</h2>
        <p class="subtitle">
            <asp:Label ID="lblWelcome" runat="server"></asp:Label>
        </p>

        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false"></asp:Label>

        <div class="info-group">
            <div class="info-label">Full Name</div>
            <div class="info-value">
                <asp:Label ID="lblFullName" runat="server"></asp:Label>
            </div>
        </div>

        <div class="info-group">
            <div class="info-label">Username</div>
            <div class="info-value">
                <asp:Label ID="lblUsername" runat="server"></asp:Label>
            </div>
        </div>

        <div class="info-group">
            <div class="info-label">Email Address</div>
            <div class="info-value">
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </div>
        </div>
        
        <div class="info-group">
            <div class="info-label">Account Created</div>
            <div class="info-value">
                <asp:Label ID="lblCreatedAt" runat="server"></asp:Label>
            </div>
        </div>

        <div style="margin-top: 2rem;">
            <a href="Logout.aspx" class="btn-primary" style="text-decoration: none; display: inline-block; text-align: center; background-color: var(--error-color);">Logout</a>
        </div>
    </div>
</asp:Content>
