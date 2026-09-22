<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-card">
        <h2>Reset Password</h2>
        <p class="subtitle">Enter your details to reset your password.</p>

        <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false"></asp:Label>

        <div class="form-group">
            <label for="txtIdentifier">Username or Email</label>
            <asp:TextBox ID="txtIdentifier" runat="server" CssClass="form-control" placeholder="Enter username or email" ClientIDMode="Static"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvIdentifier" runat="server" ControlToValidate="txtIdentifier" 
                ErrorMessage="Username or Email is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtNewPassword">New Password</label>
            <div class="password-wrapper">
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Enter new password" ClientIDMode="Static"></asp:TextBox>
                <button type="button" id="btnToggleNewPwd" class="toggle-password" onclick="togglePasswordVisibility('txtNewPassword', 'btnToggleNewPwd')">Show</button>
            </div>
            <asp:RequiredFieldValidator ID="rfvNewPassword" runat="server" ControlToValidate="txtNewPassword" 
                ErrorMessage="New Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label for="txtConfirmPassword">Confirm New Password</label>
            <div class="password-wrapper">
                <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm new password" ClientIDMode="Static"></asp:TextBox>
                <button type="button" id="btnToggleConfirmNewPwd" class="toggle-password" onclick="togglePasswordVisibility('txtConfirmPassword', 'btnToggleConfirmNewPwd')">Show</button>
            </div>
            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                ErrorMessage="Confirm Password is required" CssClass="error-message" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmPassword" 
                ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match" 
                CssClass="error-message" Display="Dynamic"></asp:CompareValidator>
        </div>

        <asp:Button ID="btnReset" runat="server" Text="Update Password" CssClass="btn-primary" OnClick="btnReset_Click" />

        <div class="auth-links">
            <p><a href="Login.aspx">Back to Login</a></p>
        </div>
    </div>
</asp:Content>
