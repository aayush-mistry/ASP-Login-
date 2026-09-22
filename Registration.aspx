<%@ Page Title="Registration" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-card">
        <h2>Create Account</h2>
        <p class="subtitle">Join the Student Portal today.</p>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>

        <div class="form-group">
            <label for="txtFullName">Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" ClientIDMode="Static"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" ControlToValidate="txtFullName" 
                ErrorMessage="Full Name is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtEmail">Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email address" ClientIDMode="Static"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" 
                ErrorMessage="Email is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" 
                ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" 
                ErrorMessage="Invalid email format" CssClass="error-message" Display="Dynamic"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <label for="txtUsername">Username</label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a username" ClientIDMode="Static"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ControlToValidate="txtUsername" 
                ErrorMessage="Username is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtPassword">Password</label>
            <div class="password-wrapper">
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Create a password" ClientIDMode="Static"></asp:TextBox>
                <button type="button" id="btnToggleRegPassword" class="toggle-password" onclick="togglePasswordVisibility('txtPassword', 'btnToggleRegPassword')">Show</button>
            </div>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="txtPassword" 
                ErrorMessage="Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtConfirmPassword">Confirm Password</label>
            <div class="password-wrapper">
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm your password" ClientIDMode="Static"></asp:TextBox>
                <button type="button" id="btnToggleConfirmRegPassword" class="toggle-password" onclick="togglePasswordVisibility('txtConfirmPassword', 'btnToggleConfirmRegPassword')">Show</button>
            </div>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                ErrorMessage="Confirm Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                ControlToCompare="txtPassword" ErrorMessage="Passwords do not match" 
                CssClass="error-message" Display="Dynamic"></asp:CompareValidator>
        </div>

        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn-primary" OnClick="btnRegister_Click" />

        <div class="auth-links">
            <p>Already have an account? <a href="Login.aspx">Back to Login</a></p>
        </div>
    </div>
</asp:Content>
