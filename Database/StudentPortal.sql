-- Create the Database
CREATE DATABASE StudentPortalDB;
GO

USE StudentPortalDB;
GO

-- Create the Students table
CREATE TABLE Students (
    StudentId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()
);
GO

-- Insert a sample student account for testing
-- IMPORTANT: This is for testing purposes only. Password is 'password123'
INSERT INTO Students (FullName, Email, Username, Password)
VALUES ('Test Student', 'test@student.edu', 'teststudent', 'password123');
GO
