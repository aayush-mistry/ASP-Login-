using System;
using System.Data;
using Mono.Data.Sqlite;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // If already logged in, redirect to Student Area
        if (Session["StudentId"] != null)
        {
            Response.Redirect("StudentArea.aspx");
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text; // In a real app, this should be hashed.

            try
            {
                // Note: It's important NOT to expose whether username exists separately from password failure.
                string query = "SELECT StudentId, FullName, Username FROM Students WHERE Username = @Username AND Password = @Password";
                
                using (SqliteConnection con = DatabaseHelper.GetConnection())
                {
                    using (SqliteCommand cmd = new SqliteCommand(query, con))
                    {
                        cmd.Parameters.Add(new SqliteParameter("@Username", username));
                        cmd.Parameters.Add(new SqliteParameter("@Password", password));

                        con.Open();
                        using (SqliteDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Login successful
                                Session["StudentId"] = reader["StudentId"];
                                Session["FullName"] = reader["FullName"].ToString();
                                Session["Username"] = reader["Username"].ToString();

                                Response.Redirect("StudentArea.aspx", false);
                            }
                            else
                            {
                                // Login failed
                                lblError.Text = "Invalid username or password.";
                                lblError.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // In production, log the exception (ex.Message). Don't show raw errors.
                lblError.Text = "Something went wrong. Please try again.";
                lblError.Visible = true;
                
                // For academic debugging (you can uncomment if needed during development)
                // lblError.Text = ex.Message; 
            }
        }
    }
}
