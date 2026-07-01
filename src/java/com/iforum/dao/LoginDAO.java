package com.iforum.dao;

import java.sql.*;
import java.security.MessageDigest;
import com.iforum.model.User;
import com.iforum.util.DBConnection; 

public class LoginDAO {

    /**
     * Authenticates user credentials against the 'users' table.
     */
    public User authenticate(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, email);
            String hashedPassword = hashPassword(password);
            ps.setString(2, hashedPassword);
            //ps.setString(2, password);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setRole(rs.getString("role"));
                    user.setPhone(rs.getString("phone"));
                    user.setFaculty(rs.getString("faculty"));
                    user.setMatric_Number(rs.getString("matric_number"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Login Authentication Error: " + e.getMessage());
            e.printStackTrace();
        }
        return user;
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