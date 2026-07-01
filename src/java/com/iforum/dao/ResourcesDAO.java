package com.iforum.dao;

import com.iforum.model.Resources;
import com.iforum.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResourcesDAO {
    
    public List<Resources> getAllResources() throws SQLException {
        List<Resources> list = new ArrayList<>();
        String sql = "SELECT * FROM resources ORDER BY upload_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Resources(
                    rs.getInt("resource_id"), rs.getString("title"), rs.getString("description"),
                    rs.getString("subject_name"), rs.getString("file_name"), 
                    rs.getString("file_path"), rs.getString("file_type"), 
                    rs.getString("uploaded_by"), rs.getTimestamp("upload_date")
                ));
            }
        }
        return list;
    }

    public boolean addResource(Resources r) throws SQLException {
        String sql = "INSERT INTO resources (title, description, subject_name, file_name, file_path, file_type, uploaded_by) VALUES (?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, r.getTitle());
            ps.setString(2, r.getDescription());
            ps.setString(3, r.getSubjectName());
            ps.setString(4, r.getFileName());
            ps.setString(5, r.getFilePath());
            ps.setString(6, r.getFileType());
            ps.setString(7, r.getUploadedBy());
            return ps.executeUpdate() > 0;
        }
    }

    public void deleteResource(int id) throws SQLException {
        String sql = "DELETE FROM resources WHERE resource_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}