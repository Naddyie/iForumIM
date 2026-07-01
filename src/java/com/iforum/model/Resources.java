package com.iforum.model;
import java.sql.Timestamp;

public class Resources {
    private int resourceId; //subjectId;
    private String title, description, subjectName, fileName, filePath, fileType, uploadedBy;
    private Timestamp uploadDate;
    
    public Resources() {
    }
    
    public Resources(int resourceId, String title, String description, String subjectName, 
                     String fileName, String filePath, String fileType, String uploadedBy, Timestamp uploadDate) {
        this.resourceId = resourceId;
        this.title = title;
        this.description = description;
        this.subjectName = subjectName;
        this.fileName = fileName;
        this.filePath = filePath;
        this.fileType = fileType;
        this.uploadedBy = uploadedBy;
        this.uploadDate = uploadDate;
    }

    // Getters and Setters
    public int getResourceId() { return resourceId; }
    public void setResourceId(int resourceId) { this.resourceId = resourceId; }
    //public int getSubjectId() { return subjectId; }
    //public void setSubjectId(int subjectId) { this.subjectId = subjectId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getSubjectName() { return subjectName; }
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }
    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }
    public String getFilePath() { return filePath; }
    public void setFilePath(String filePath) { this.filePath = filePath; }
    public String getFileType() { return fileType; }
    public void setFileType(String fileType) { this.fileType = fileType; }
    public String getUploadedBy() { return uploadedBy; }
    public void setUploadedBy(String uploadedBy) { this.uploadedBy = uploadedBy; }
    public Timestamp getUploadDate() { return uploadDate; }
    public void setUploadDate(Timestamp uploadDate) { this.uploadDate = uploadDate; }
}