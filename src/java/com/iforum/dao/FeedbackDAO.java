package com.iforum.dao;

import com.iforum.model.Feedback;
import com.iforum.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO {

    private Connection conn;

    public FeedbackDAO() {
        try {
            conn = DBConnection.getConnection();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // INSERT FEEDBACK
    public boolean insertFeedback(Feedback f) {
        String sql = "INSERT INTO feedback (discussion_title, rating, comment) VALUES (?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, f.getDiscussionTitle());
            ps.setInt(2, f.getRating());
            ps.setString(3, f.getComment());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return false;
    }

    // GET ALL FEEDBACK
    public List<Feedback> getAllFeedback() {

        List<Feedback> list = new ArrayList<>();

        String sql = "SELECT * FROM feedback ORDER BY submitted_at DESC";

        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                Feedback f = new Feedback();

                f.setFeedbackId(rs.getInt("feedback_id"));
                f.setDiscussionTitle(rs.getString("discussion_title"));
                f.setRating(rs.getInt("rating"));
                f.setComment(rs.getString("comment"));
                f.setSubmittedAt(rs.getTimestamp("submitted_at"));

                list.add(f);
            }

        } catch (SQLException e) {

            e.printStackTrace();

        }

        return list;
    }
}