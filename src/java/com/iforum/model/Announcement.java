package com.iforum.model;

import java.sql.Timestamp;

public class Announcement {
    private int announcement_id;
    private String title;
    private String content;
    private String category;
    private String filePath;
    private int creatorId;
    private String creatorName;
    private String creatorRole;
    private Timestamp createdAt;

    // Getters and Setters
    public int getAnnouncement_id() { return announcement_id; }
    public void setAnnouncement_id(int announcement_id) { this.announcement_id = announcement_id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    public int getCreatorId() { return creatorId; }
    public void setCreatorId(int creatorId) { this.creatorId = creatorId; }
    public String getCreatorName() { return creatorName; }
    public void setCreatorName(String creatorName) { this.creatorName = creatorName; }
    public String getCreatorRole() { return creatorRole; }
    public void setCreatorRole(String creatorRole) { this.creatorRole = creatorRole; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}