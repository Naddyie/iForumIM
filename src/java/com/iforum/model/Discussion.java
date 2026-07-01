package com.iforum.model;

import java.sql.Timestamp;

public class Discussion {
    private int topicId;
    private String title;
    private String category;
    private String description;
    private String authorId;
    private String authorType; // "Student" or "Lecturer"
    private Timestamp createdAt;

    // Constructors
    public Discussion() {}

    public Discussion(int topicId, String title, String category, String description, String authorId, String authorType) {
        this.topicId = topicId;
        this.title = title;
        this.category = category;
        this.description = description;
        this.authorId = authorId;
        this.authorType = authorType;
    }

    // Getters and Setters
    public int getTopicId() { return topicId; }
    public void setTopicId(int topicId) { this.topicId = topicId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getAuthorId() { return authorId; }
    public void setAuthorId(String authorId) { this.authorId = authorId; }
    public String getAuthorType() { return authorType; }
    public void setAuthorType(String authorType) { this.authorType = authorType; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}