-- Create the Students table
CREATE TABLE IF NOT EXISTS Students (
    StudentId INTEGER PRIMARY KEY AUTOINCREMENT,
    FullName TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE,
    Username TEXT NOT NULL UNIQUE,
    Password TEXT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Insert a sample student account for testing
-- IMPORTANT: This is for testing purposes only. Password is 'password123'
INSERT INTO Students (FullName, Email, Username, Password)
SELECT 'Test Student', 'test@student.edu', 'teststudent', 'password123'
WHERE NOT EXISTS (SELECT 1 FROM Students WHERE Username = 'teststudent');
