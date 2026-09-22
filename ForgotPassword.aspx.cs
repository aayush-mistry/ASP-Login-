using System;
using System.Data;
using System.Data.SqlClient;

public partial class ForgotPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string identifier = txtIdentifier.Text.Trim(); // Username or Email
            string newPassword = txtNewPassword.Text; // Should be hashed in production

            try
            {
                using (SqlConnection con = DatabaseHelper.GetConnection())
                {
                    con.Open();

                    // 1. Verify that account exists
                    string checkQuery = "SELECT StudentId FROM Students WHERE Username = @Identifier OR Email = @Identifier";
                    int studentId = 0;

                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, con))
                    {
                        checkCmd.Parameters.Add(new SqlParameter("@Identifier", identifier));
                        object result = checkCmd.ExecuteScalar();

                        if (result != null)
                        {
                            studentId = Convert.ToInt32(result);
                        }
                        else
                        {
                            ShowMessage("Account not found.", false);
                            return;
                        }
                    }

                    // 2. Update the password
                    if (studentId > 0)
                    {
                        string updateQuery = "UPDATE Students SET Password = @NewPassword WHERE StudentId = @StudentId";
                        using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                        {
                            updateCmd.Parameters.Add(new SqlParameter("@NewPassword", newPassword));
                            updateCmd.Parameters.Add(new SqlParameter("@StudentId", studentId));

                            int rowsAffected = updateCmd.ExecuteNonQuery();

                            if (rowsAffected > 0)
                            {
                                ShowMessage("Password updated successfully. Please login again.", true);
                                ClearForm();
                            }
                            else
                            {
                                ShowMessage("Failed to update password.", false);
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Log exception in production
                ShowMessage("Something went wrong. Please try again.", false);
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
        txtIdentifier.Text = string.Empty;
        txtNewPassword.Text = string.Empty;
        txtConfirmPassword.Text = string.Empty;
    }
}
