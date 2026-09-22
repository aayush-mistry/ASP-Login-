using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

/// <summary>
/// A simple helper class to centralize ADO.NET connection and execution logic.
/// </summary>
public static class DatabaseHelper
{
    // Retrieve connection string from Web.config
    private static string GetConnectionString()
    {
        return ConfigurationManager.ConnectionStrings["StudentPortalConnection"].ConnectionString;
    }

    /// <summary>
    /// Gets a new SQL connection. Make sure to wrap in a using statement.
    /// </summary>
    public static SqlConnection GetConnection()
    {
        return new SqlConnection(GetConnectionString());
    }

    /// <summary>
    /// Executes a non-query command (INSERT, UPDATE, DELETE) and returns rows affected.
    /// </summary>
    public static int ExecuteNonQuery(string query, params SqlParameter[] parameters)
    {
        using (SqlConnection conn = GetConnection())
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                
                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
    }

    /// <summary>
    /// Executes a scalar command and returns the first column of the first row.
    /// </summary>
    public static object ExecuteScalar(string query, params SqlParameter[] parameters)
    {
        using (SqlConnection conn = GetConnection())
        {
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                
                conn.Open();
                return cmd.ExecuteScalar();
            }
        }
    }
}
