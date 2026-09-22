using System;
using System.Configuration;
using System.Data;
using Mono.Data.Sqlite;
using System.IO;

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
    public static SqliteConnection GetConnection()
    {
        InitializeDatabase();
        return new SqliteConnection(GetConnectionString());
    }

    /// <summary>
    /// Creates the SQLite database file and tables if they don't exist.
    /// </summary>
    private static void InitializeDatabase()
    {
        string dataDir = AppDomain.CurrentDomain.GetData("DataDirectory") as string;
        if (dataDir == null)
        {
            dataDir = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "App_Data");
            AppDomain.CurrentDomain.SetData("DataDirectory", dataDir);
        }

        if (!Directory.Exists(dataDir))
        {
            Directory.CreateDirectory(dataDir);
        }

        string dbPath = Path.Combine(dataDir, "StudentPortal.db");
        if (!File.Exists(dbPath))
        {
            SqliteConnection.CreateFile(dbPath);
            
            using (var conn = new SqliteConnection(GetConnectionString()))
            {
                conn.Open();
                
                string sqlPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Database", "StudentPortal.sql");
                if (File.Exists(sqlPath))
                {
                    string script = File.ReadAllText(sqlPath);
                    using (var cmd = new SqliteCommand(script, conn))
                    {
                        cmd.ExecuteNonQuery();
                    }
                }
            }
        }
    }

    /// <summary>
    /// Executes a non-query command (INSERT, UPDATE, DELETE) and returns rows affected.
    /// </summary>
    public static int ExecuteNonQuery(string query, params SqliteParameter[] parameters)
    {
        using (SqliteConnection conn = GetConnection())
        {
            using (SqliteCommand cmd = new SqliteCommand(query, conn))
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
    public static object ExecuteScalar(string query, params SqliteParameter[] parameters)
    {
        using (SqliteConnection conn = GetConnection())
        {
            using (SqliteCommand cmd = new SqliteCommand(query, conn))
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
