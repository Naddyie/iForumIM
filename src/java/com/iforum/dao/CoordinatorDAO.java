package com.iforum.dao;

import com.iforum.model.User;
import com.iforum.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CoordinatorDAO {

    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) AS total FROM users";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getTotalDiscussions() {
        String sql = "SELECT COUNT(*) AS total FROM discussion_groups";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getTotalReplies() {
        String sql = "SELECT COUNT(*) AS total FROM discussion_messages";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        String sql = "SELECT u.*, us.course, us.academic_session, us.status AS student_status " +
                     "FROM users u " +
                     "LEFT JOIN university_students us ON u.matric_number = us.matric_number " +
                     "ORDER BY u.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User user = new User();

                user.setId(rs.getInt("id"));
                user.setFullname(rs.getString("fullname"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setMatric_Number(rs.getString("matric_number"));
                user.setFaculty(rs.getString("faculty"));

                user.setCourse(rs.getString("course"));
                user.setAcademicSession(rs.getString("academic_session"));
                user.setStudentStatus(rs.getString("student_status"));

                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }
}
