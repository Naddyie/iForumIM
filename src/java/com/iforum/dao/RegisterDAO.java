package com.iforum.dao;

import java.sql.*;
import com.iforum.model.User;
import com.iforum.util.DBConnection;

public class RegisterDAO {

    /**
     * Step 1: Verify if student exists in university_students list.
     */
    public String verifyMaritimeStudent(String matric) {
        String fullName = null;

        String sql = "SELECT * FROM university_students " +
                     "WHERE matric_number = ? " +
                     "AND course = ? " +
                     "AND status = 'ACTIVE'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, matric);
            ps.setString(2, "Bachelor of Computer Science with Maritime Informatics");

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    fullName = rs.getString("full_name");
                }
            }

        } catch (SQLException e) {
            System.err.println("RegisterDAO Verification Error: " + e.getMessage());
            e.printStackTrace();
        }

        return fullName;
    }

    /**
     * Step 2: Insert the final registered user into the 'users' table.
     */
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users (fullname, email, phone, password, role, matric_number, faculty) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        boolean success = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole().toUpperCase());
            ps.setString(6, user.getMatric_Number());
            ps.setString(7, user.getFaculty());
            
            success = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("RegisterDAO Registration Error: " + e.getMessage());
            e.printStackTrace();
        }
        return success;
    }
}