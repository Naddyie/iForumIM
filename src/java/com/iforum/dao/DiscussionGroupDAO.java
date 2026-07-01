package com.iforum.dao;

import com.iforum.model.DiscussionGroup;
import com.iforum.model.DiscussionMessage;
import com.iforum.util.DBConnection;
import java.sql.PreparedStatement;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DiscussionGroupDAO {

    /**
     * Lists all groups and checks if a specific user has joined each group.
     */
    public List<DiscussionGroup> getAllGroups(int currentUserId) {
        List<DiscussionGroup> list = new ArrayList<>();
        String sql = "SELECT dg.*, u.fullname AS creator_name, " +
                     "(SELECT COUNT(*) FROM discussion_memberships WHERE group_id = dg.group_id) AS member_count, " +
                     "EXISTS(SELECT 1 FROM discussion_memberships WHERE group_id = dg.group_id AND user_id = ?) AS is_joined " +
                     "FROM discussion_groups dg " +
                     "JOIN users u ON dg.creator_id = u.id " +
                     "ORDER BY dg.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, currentUserId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DiscussionGroup g = new DiscussionGroup();
                    g.setGroupId(rs.getInt("group_id"));
                    g.setTitle(rs.getString("title"));
                    g.setCategory(rs.getString("category"));
                    g.setDescription(rs.getString("description"));
                    g.setCreatorId(rs.getInt("creator_id"));
                    g.setCreatorName(rs.getString("creator_name"));
                    g.setCreatedAt(rs.getTimestamp("created_at"));
                    g.setJoined(rs.getBoolean("is_joined"));
                    g.setMemberCount(rs.getInt("member_count"));
                    list.add(g);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Creates a new chat group.
     */
    public boolean createGroup(DiscussionGroup group) {
        String sql = "INSERT INTO discussion_groups (title, category, description, creator_id) VALUES (?, ?, ?, ?)";
        boolean success = false;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, group.getTitle());
            ps.setString(2, group.getCategory());
            ps.setString(3, group.getDescription());
            ps.setInt(4, group.getCreatorId());
            
            success = ps.executeUpdate() > 0;
            if (success) {
                // Creators are automatically joined as members
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int groupId = generatedKeys.getInt(1);
                        joinGroup(groupId, group.getCreatorId());
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return success;
    }

    /**
     * Registers a student membership to a chat group.
     */
    public boolean joinGroup(int groupId, int userId) {
        String sql = "INSERT IGNORE INTO discussion_memberships (group_id, user_id) VALUES (?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, groupId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Checks if a user is a member of a group.
     */
    public boolean isMember(int groupId, int userId) {
        String sql = "SELECT 1 FROM discussion_memberships WHERE group_id = ? AND user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, groupId);
            ps.setInt(2, userId);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Gets discussion group metadata by ID.
     */
    public DiscussionGroup getGroupById(int groupId, int currentUserId) {
        String sql = "SELECT dg.*, u.fullname as creator_name, " +
                     "EXISTS(SELECT 1 FROM discussion_memberships WHERE group_id = dg.group_id AND user_id = ?) AS is_joined " +
                     "FROM discussion_groups dg JOIN users u ON dg.creator_id = u.id WHERE dg.group_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, currentUserId);
            ps.setInt(2, groupId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    DiscussionGroup g = new DiscussionGroup();
                    g.setGroupId(rs.getInt("group_id"));
                    g.setTitle(rs.getString("title"));
                    g.setCategory(rs.getString("category"));
                    g.setDescription(rs.getString("description"));
                    g.setCreatorId(rs.getInt("creator_id"));
                    g.setCreatorName(rs.getString("creator_name"));
                    g.setCreatedAt(rs.getTimestamp("created_at"));
                    g.setJoined(rs.getBoolean("is_joined"));
                    return g;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Inserts a chat message.
     */
    public boolean postMessageWithMedia(int groupId, int senderId, String messageText, String media_path, String media_type, Integer replyToMessageId) {
    String sql = "INSERT INTO discussion_messages " +
                 "(group_id, sender_id, message_text, media_path, media_type, reply_to_message_id) " +
                 "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, groupId);
            ps.setInt(2, senderId);

            if (messageText == null || messageText.trim().isEmpty()) {
                ps.setNull(3, Types.LONGVARCHAR);
            } else {
                ps.setString(3, messageText.trim());
            }

            ps.setString(4, media_path);
            ps.setString(5, media_type);

            if (replyToMessageId == null) {
                ps.setNull(6, Types.INTEGER);
            } else {
                ps.setInt(6, replyToMessageId);
            }

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Retrieves message feed chronologically.
     */
    public List<DiscussionMessage> getMessagesByGroup(int groupId) {
        List<DiscussionMessage> messages = new ArrayList<>();

        String sql = "SELECT dm.*, " +
                     "u.fullname AS sender_name, " +
                     "u.role AS sender_role, " +

                     "reply_dm.message_text AS reply_message_text, " +
                     "reply_dm.media_path AS reply_media_path, " +
                     "reply_dm.media_type AS reply_media_type, " +
                     "reply_user.fullname AS reply_sender_name, " +

                     "COUNT(dmr.user_id) AS read_count, " +
                     "GROUP_CONCAT(reader.fullname SEPARATOR ', ') AS read_by_names " +

                     "FROM discussion_messages dm " +
                     "JOIN users u ON dm.sender_id = u.id " +

                     "LEFT JOIN discussion_messages reply_dm " +
                     "ON dm.reply_to_message_id = reply_dm.message_id " +
                     "LEFT JOIN users reply_user " +
                     "ON reply_dm.sender_id = reply_user.id " +

                     "LEFT JOIN discussion_message_reads dmr " +
                     "ON dm.message_id = dmr.message_id " +
                     "LEFT JOIN users reader " +
                     "ON dmr.user_id = reader.id " +

                     "WHERE dm.group_id = ? " +
                     "GROUP BY dm.message_id " +
                     "ORDER BY dm.sent_at ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, groupId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    DiscussionMessage msg = new DiscussionMessage();

                    msg.setMessageId(rs.getInt("message_id"));
                    msg.setGroupId(rs.getInt("group_id"));
                    msg.setSenderId(rs.getInt("sender_id"));
                    msg.setSenderName(rs.getString("sender_name"));
                    msg.setSenderRole(rs.getString("sender_role"));
                    msg.setMessageText(rs.getString("message_text"));
                    msg.setMedia_path(rs.getString("media_path"));
                    msg.setMedia_type(rs.getString("media_type"));
                    msg.setSentAt(rs.getTimestamp("sent_at"));

                    msg.setReplyToMessageId((Integer) rs.getObject("reply_to_message_id"));
                    msg.setReplyToMessageText(rs.getString("reply_message_text"));
                    msg.setReplyToMediaPath(rs.getString("reply_media_path"));
                    msg.setReplyToMediaType(rs.getString("reply_media_type"));
                    msg.setReplyToSenderName(rs.getString("reply_sender_name"));

                    msg.setReadCount(rs.getInt("read_count"));
                    msg.setReadByNames(rs.getString("read_by_names"));

                    messages.add(msg);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return messages;
    }
    
    /*User Read the chat*/
    public void markMessagesAsRead(int groupId, int userId) {
        String sql = "INSERT IGNORE INTO discussion_message_reads (message_id, user_id) " +
                     "SELECT message_id, ? " +
                     "FROM discussion_messages " +
                     "WHERE group_id = ? AND sender_id != ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, groupId);
            ps.setInt(3, userId);

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}