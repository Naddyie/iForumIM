package com.iforum.model;

import java.sql.Timestamp;

public class DiscussionMessage {
    private int messageId;
    private int groupId;
    private int senderId;
    private String senderName;
    private String senderRole;
    private String messageText;
    private Timestamp sentAt;
    private String media_type;
    private String media_path;
    private Integer replyToMessageId;
    private String replyToSenderName;
    private String replyToMessageText;
    private String replyToMediaType;
    private String replyToMediaPath;
    private int readCount;
    private String readByNames;

    public DiscussionMessage() {}

    // Getters and Setters
    public int getMessageId() { return messageId; }
    public void setMessageId(int messageId) { this.messageId = messageId; }

    public int getGroupId() { return groupId; }
    public void setGroupId(int groupId) { this.groupId = groupId; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public String getSenderName() { return senderName; }
    public void setSenderName(String senderName) { this.senderName = senderName; }

    public String getSenderRole() { return senderRole; }
    public void setSenderRole(String senderRole) { this.senderRole = senderRole; }

    public String getMessageText() { return messageText; }
    public void setMessageText(String messageText) { this.messageText = messageText; }

    public Timestamp getSentAt() { return sentAt; }
    public void setSentAt(Timestamp sentAt) { this.sentAt = sentAt; }

    public String getMedia_type() { return media_type;}
    public void setMedia_type(String media_type) { this.media_type = media_type; }

    public String getMedia_path() { return media_path;}
    public void setMedia_path(String media_path) { this.media_path = media_path; }

    public Integer getReplyToMessageId() { return replyToMessageId; }
    public void setReplyToMessageId(Integer replyToMessageId) { this.replyToMessageId = replyToMessageId; }

    public String getReplyToSenderName() { return replyToSenderName; }
    public void setReplyToSenderName(String replyToSenderName) { this.replyToSenderName = replyToSenderName; }

    public String getReplyToMessageText() { return replyToMessageText; }
    public void setReplyToMessageText(String replyToMessageText) { this.replyToMessageText = replyToMessageText; }

    public String getReplyToMediaType() { return replyToMediaType; }
    public void setReplyToMediaType(String replyToMediaType) { this.replyToMediaType = replyToMediaType; }

    public String getReplyToMediaPath() { return replyToMediaPath; }
    public void setReplyToMediaPath(String replyToMediaPath) { this.replyToMediaPath = replyToMediaPath; }

    public int getReadCount() { return readCount; }
    public void setReadCount(int readCount) { this.readCount = readCount; }

    public String getReadByNames() { return readByNames; }
    public void setReadByNames(String readByNames) { this.readByNames = readByNames; } 
}