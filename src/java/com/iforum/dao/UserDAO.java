package com.iforum.dao;

import com.iforum.model.User;
import com.iforum.util.DBConnection; // Adjust this import to match your actual utility class name
import java.security.MessageDigest;
import java.sql.*;

public class UserDAO {

    public User login(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setPhone(rs.getString("phone"));
                user.setMatric_Number(rs.getString("matric_number"));
                user.setFaculty(rs.getString("faculty"));
            }
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return user;
    }
    
    public User getUserById(int userId) {
        User user = null;

        String sql = "SELECT u.*, us.course, us.academic_session, us.status AS student_status " +
                     "FROM users u " +
                     "LEFT JOIN university_students us ON u.matric_number = us.matric_number " +
                     "WHERE u.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();

                    user.setId(rs.getInt("id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setPhone(rs.getString("phone"));
                    user.setMatric_Number(rs.getString("matric_number"));
                    user.setFaculty(rs.getString("faculty"));

                    user.setCourse(rs.getString("course"));
                    user.setAcademicSession(rs.getString("academic_session"));
                    user.setStudentStatus(rs.getString("student_status"));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean updateUser(User user) {
        boolean rowUpdated = false;
        String sql = "UPDATE users SET fullname = ?, phone = ?, faculty = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getPhone());
            ps.setString(3, user.getFaculty());
            ps.setInt(4, user.getId());
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) { 
            e.printStackTrace(); 
        }
        return rowUpdated;
    }
    
    public boolean changePassword(int userId, String newPassword) {

        String sql = "UPDATE users SET password = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String hashedPassword = hashPassword(newPassword);

            ps.setString(1, hashedPassword);
            ps.setInt(2, userId);

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
}
    
    private String hashPassword(String password) {
        try {

            MessageDigest md = MessageDigest.getInstance("SHA-256");

            byte[] hash = md.digest(password.getBytes("UTF-8"));

            StringBuilder hex = new StringBuilder();

            for (byte b : hash) {
                hex.append(String.format("%02x", b));
            }

            return hex.toString();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}

