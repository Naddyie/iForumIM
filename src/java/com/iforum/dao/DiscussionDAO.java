package com.iforum.dao;

import com.iforum.model.Discussion;
import com.iforum.util.DBConnection; // Using your existing utility
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiscussionDAO {

    /**
     * Retrieves all discussions from the database.
     * Uses DBUtil for connection management.
     */
    public List<Discussion> getAllDiscussions() {
        List<Discussion> discussions = new ArrayList<>();
        String sql = "SELECT * FROM discussions ORDER BY createdAt DESC";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Discussion d = new Discussion();
                d.setTopicId(rs.getInt("topicId"));
                d.setTitle(rs.getString("title"));
                d.setCategory(rs.getString("category"));
                d.setDescription(rs.getString("description"));
                d.setAuthorId(rs.getString("authorId")); // Model uses String
                d.setAuthorType(rs.getString("authorType"));
                d.setCreatedAt(rs.getTimestamp("createdAt"));
                discussions.add(d);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return discussions;
    }

    /**
     * Retrieves a single discussion by its ID.
     */
    public Discussion getDiscussionById(int id) {
        Discussion disc = null;
        String sql = "SELECT * FROM discussions WHERE topicId = ?";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    disc = new Discussion();
                    disc.setTopicId(rs.getInt("topicId"));
                    disc.setTitle(rs.getString("title"));
                    disc.setCategory(rs.getString("category"));
                    disc.setDescription(rs.getString("description"));
                    disc.setAuthorId(rs.getString("authorId"));
                    disc.setAuthorType(rs.getString("authorType"));
                    disc.setCreatedAt(rs.getTimestamp("createdAt"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return disc;
    }

    /**
     * Inserts a new discussion into the database.
     */
    public boolean insertDiscussion(Discussion disc) {
        String sql = "INSERT INTO discussions (title, category, description, authorId, authorType) VALUES (?, ?, ?, ?, ?)";
        boolean rowInserted = false;
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, disc.getTitle());
            ps.setString(2, disc.getCategory());
            ps.setString(3, disc.getDescription());
            ps.setString(4, disc.getAuthorId());
            ps.setString(5, disc.getAuthorType());
            
            rowInserted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowInserted;
    }

    /**
     * Updates an existing discussion. Only allows updating title, category, and description.
     */
    public void updateDiscussion(int id, String title, String category, String description) {
        String sql = "UPDATE discussions SET title=?, category=?, description=? WHERE topicId=?";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, title);
            ps.setString(2, category);
            ps.setString(3, description);
            ps.setInt(4, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /**
     * Deletes a discussion by ID.
     */
    public void deleteDiscussion(int id) {
        String sql = "DELETE FROM discussions WHERE topicId = ?";
        
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}