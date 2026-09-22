using System;
using System.Data;
using Mono.Data.Sqlite;

public partial class Registration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // If already logged in, redirect to Student Area
        if (Session["StudentId"] != null)
        {
            Response.Redirect("StudentArea.aspx");
        }
    }

    protected void btnRegister_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text; // Should be hashed in production

            try
            {
                using (SqliteConnection con = DatabaseHelper.GetConnection())
                {
                    con.Open();

                    // 1. Check if email exists
                    string emailCheckQuery = "SELECT COUNT(*) FROM Students WHERE Email = @Email";
                    using (SqliteCommand emailCmd = new SqliteCommand(emailCheckQuery, con))
                    {
                        emailCmd.Parameters.Add(new SqliteParameter("@Email", email));
                        int emailCount = Convert.ToInt32(emailCmd.ExecuteScalar());
                        if (emailCount > 0)
                        {
                            ShowMessage("Email address is already registered.", false);
                            return;
                        }
                    }

                    // 2. Check if username exists
                    string userCheckQuery = "SELECT COUNT(*) FROM Students WHERE Username = @Username";
                    using (SqliteCommand userCmd = new SqliteCommand(userCheckQuery, con))
                    {
                        userCmd.Parameters.Add(new SqliteParameter("@Username", username));
                        int userCount = Convert.ToInt32(userCmd.ExecuteScalar());
                        if (userCount > 0)
                        {
                            ShowMessage("Username is already taken.", false);
                            return;
                        }
                    }

                    // 3. Insert new user
                    string insertQuery = @"INSERT INTO Students (FullName, Email, Username, Password) 
                                           VALUES (@FullName, @Email, @Username, @Password)";
                    
                    using (SqliteCommand insertCmd = new SqliteCommand(insertQuery, con))
                    {
                        insertCmd.Parameters.Add(new SqliteParameter("@FullName", fullName));
                        insertCmd.Parameters.Add(new SqliteParameter("@Email", email));
                        insertCmd.Parameters.Add(new SqliteParameter("@Username", username));
                        insertCmd.Parameters.Add(new SqliteParameter("@Password", password));

                        int rowsAffected = insertCmd.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            ShowMessage("Registration successful. You can now login.", true);
                            ClearForm();
                        }
                        else
                        {
                            ShowMessage("Registration failed. Please try again.", false);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Show actual error for debugging the database connection issue
                ShowMessage("Error: " + ex.Message, false);
            }
        }
    }

    private void ShowMessage(string message, bool isSuccess)
    {
        lblMessage.Text = message;
        lblMessage.Visible = true;
        lblMessage.CssClass = isSuccess ? "alert alert-success" : "alert alert-danger";
    }

    private void ClearForm()
    {
        txtFullName.Text = string.Empty;
        txtEmail.Text = string.Empty;
        txtUsername.Text = string.Empty;
        txtPassword.Text = string.Empty;
        txtConfirmPassword.Text = string.Empty;
    }
}
