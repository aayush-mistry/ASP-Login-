<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-card">
        <h2>Student Login</h2>
        <p class="subtitle">Welcome back! Please enter your details.</p>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger" Visible="false"></asp:Label>
        
        <div class="form-group">
            <label for="txtUsername">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter your username" ClientIDMode="Static"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                ErrorMessage="Username is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        
        <div class="form-group">
            <label for="txtPassword">Password</label>
            <div class="password-wrapper">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter your password" ClientIDMode="Static"></asp:TextBox>
                <button type="button" id="btnTogglePassword" class="toggle-password" onclick="togglePasswordVisibility('txtPassword', 'btnTogglePassword')">Show</button>
            </div>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                ErrorMessage="Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>
        
        <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-primary" OnClick="btnLogin_Click" />
        
        <div class="auth-links">
            <p>Don't have an account? <a href="Registration.aspx">Create Account</a></p>
            <p><a href="ForgotPassword.aspx">Forgot Password?</a></p>
        </div>
    </div>
</asp:Content>
