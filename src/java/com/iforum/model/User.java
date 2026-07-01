package com.iforum.model;

/**
 * Model for the 'users' table which stores registered accounts.
 */
public class User {
    private int id;
    private String fullname;
    private String email;
    private String phone;
    private String password;
    private String role; // STUDENT, LECTURER, ADMIN
    private String matric_number; // Null for non-students
    private String faculty;      // Null for students
    private String course;
    private String academicSession;
    private String studentStatus;

    public User() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    public String getMatric_Number() { return matric_number; }
    public void setMatric_Number(String matric_number) { this.matric_number = matric_number; }
    public String getFaculty() { return faculty; }
    public void setFaculty(String faculty) { this.faculty = faculty; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public String getAcademicSession() { return academicSession; }
    public void setAcademicSession(String academicSession) { this.academicSession = academicSession; }
    public String getStudentStatus() { return studentStatus; }
    public void setStudentStatus(String studentStatus) { this.studentStatus = studentStatus;}
    
    // Helper for UI initials (e.g., "John Doe" -> "JD")
    public String getInitials() {
        if (fullname == null || fullname.isEmpty()) return "??";
        String[] parts = fullname.split(" ");
        if (parts.length > 1) return (parts[0].substring(0, 1) + parts[1].substring(0, 1)).toUpperCase();
        return fullname.substring(0, 1).toUpperCase();
    }
}