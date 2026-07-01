package com.iforum.dao;

import com.iforum.model.Announcement;
import com.iforum.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AnnouncementDAO {

    public List<Announcement> getAllAnnouncements(String searchQuery) {
        List<Announcement> list = new ArrayList<>();
        String sql = "SELECT a.*, u.fullname AS creatorName, u.role AS creatorRole " +
                     "FROM announcements a " +
                     "JOIN users u ON a.creatorId = u.id ";
        
        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            sql += "WHERE a.title LIKE ? OR a.content LIKE ? OR a.category LIKE ? ";
        }
        sql += "ORDER BY a.createdAt DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                String token = "%" + searchQuery.trim() + "%";
                ps.setString(1, token);
                ps.setString(2, token);
                ps.setString(3, token);
            }

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Announcement a = new Announcement();
                    a.setAnnouncement_id(rs.getInt("announcement_id"));
                    a.setTitle(rs.getString("title"));
                    a.setContent(rs.getString("content"));
                    a.setCategory(rs.getString("category"));
                    a.setFilePath(rs.getString("filePath"));
                    a.setCreatorId(rs.getInt("creatorId"));
                    a.setCreatorName(rs.getString("creatorName"));
                    a.setCreatorRole(rs.getString("creatorRole"));
                    a.setCreatedAt(rs.getTimestamp("createdAt"));
                    list.add(a);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Announcement getAnnouncementById(int id) {
        String sql = "SELECT a.*, u.fullname AS creatorName, u.role AS creatorRole " +
                     "FROM announcements a " +
                     "JOIN users u ON a.creatorId = u.id " +
                     "WHERE a.announcement_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Announcement a = new Announcement();
                    a.setAnnouncement_id(rs.getInt("announcement_id"));
                    a.setTitle(rs.getString("title"));
                    a.setContent(rs.getString("content"));
                    a.setCategory(rs.getString("category"));
                    a.setFilePath(rs.getString("filePath"));
                    a.setCreatorId(rs.getInt("creatorId"));
                    a.setCreatorName(rs.getString("creatorName"));
                    a.setCreatorRole(rs.getString("creatorRole"));
                    a.setCreatedAt(rs.getTimestamp("createdAt"));
                    return a;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createAnnouncement(Announcement a) {
        String sql = "INSERT INTO announcements (title, content, category, filePath, creatorId) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getContent());
            ps.setString(3, a.getCategory());
            ps.setString(4, a.getFilePath());
            ps.setInt(5, a.getCreatorId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateAnnouncement(Announcement a) {
        String sql = "UPDATE announcements SET title = ?, content = ?, category = ?, filePath = ? WHERE announcement_id = ? AND creatorId = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getContent());
            ps.setString(3, a.getCategory());
            ps.setString(4, a.getFilePath());
            ps.setInt(5, a.getAnnouncement_id());
            ps.setInt(6, a.getCreatorId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteAnnouncement(int id, int currentUserId, String userRole) {
        String sql = "DELETE FROM announcements WHERE announcement_id = ?";
        // Students cannot delete; Lecturers can only delete their own; Admins/Coordinators can delete anything
        if (!"ADMIN".equalsIgnoreCase(userRole) && !"COORDINATOR".equalsIgnoreCase(userRole)) {
            sql += " AND creatorId = ?";
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            if (!"ADMIN".equalsIgnoreCase(userRole) && !"COORDINATOR".equalsIgnoreCase(userRole)) {
                ps.setInt(2, currentUserId);
            }
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}