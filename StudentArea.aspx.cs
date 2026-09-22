using System;
using System.Data.SqlClient;

public partial class StudentArea : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // Require Authentication
        if (Session["StudentId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadStudentData();
        }
    }

    private void LoadStudentData()
    {
        int studentId = Convert.ToInt32(Session["StudentId"]);

        try
        {
            // Retrieve data directly from database to ensure it's up to date
            string query = "SELECT FullName, Username, Email, CreatedAt FROM Students WHERE StudentId = @StudentId";

            using (SqlConnection con = DatabaseHelper.GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.Add(new SqlParameter("@StudentId", studentId));

                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblWelcome.Text = "Welcome, " + reader["FullName"].ToString() + "!";
                            lblFullName.Text = reader["FullName"].ToString();
                            lblUsername.Text = reader["Username"].ToString();
                            lblEmail.Text = reader["Email"].ToString();
                            
                            DateTime createdAt = Convert.ToDateTime(reader["CreatedAt"]);
                            lblCreatedAt.Text = createdAt.ToString("MMMM dd, yyyy");
                        }
                        else
                        {
                            // In case the user was deleted while logged in
                            Session.Clear();
                            Response.Redirect("Login.aspx");
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            lblError.Text = "Failed to load profile data. Please try again later.";
            lblError.Visible = true;
        }
    }
}
