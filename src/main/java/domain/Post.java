package domain;

import java.util.Date;

public class Post {
    private String postId;
    private String authorId;
    private String authorName;
    private String postPassword;
    private String postTitle;
    private String postContent;
    private Date postCreatedAt;
    private Date postUpdatedAt;
    private Integer postGroup;
    private Integer postGroupLevel;
    private Integer postGroupStep;
    private String postFile;
    private Integer postReadCount;
    private boolean postNotice;

    // Getters and Setters
    public String getPostId() { return postId; }
    public void setPostId(String postId) { this.postId = postId; }
    public String getAuthorId() { return authorId; }
    public void setAuthorId(String authorId) { this.authorId = authorId; }
    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }
    public String getPostPassword() { return postPassword; }
    public void setPostPassword(String postPassword) { this.postPassword = postPassword; }
    public String getPostTitle() { return postTitle; }
    public void setPostTitle(String postTitle) { this.postTitle = postTitle; }
    public String getPostContent() { return postContent; }
    public void setPostContent(String postContent) { this.postContent = postContent; }
    public Date getPostCreatedAt() { return postCreatedAt; }
    public void setPostCreatedAt(Date postCreatedAt) { this.postCreatedAt = postCreatedAt; }
    public Date getPostUpdatedAt() { return postUpdatedAt; }
    public void setPostUpdatedAt(Date postUpdatedAt) { this.postUpdatedAt = postUpdatedAt; }
    public Integer getPostGroup() { return postGroup; }
    public void setPostGroup(Integer postGroup) { this.postGroup = postGroup; }
    public Integer getPostGroupLevel() { return postGroupLevel; }
    public void setPostGroupLevel(Integer postGroupLevel) { this.postGroupLevel = postGroupLevel; }
    public Integer getPostGroupStep() { return postGroupStep; }
    public void setPostGroupStep(Integer postGroupStep) { this.postGroupStep = postGroupStep; }
    public String getPostFile() { return postFile; }
    public void setPostFile(String postFile) { this.postFile = postFile; }
    public Integer getPostReadCount() { return postReadCount; }
    public void setPostReadCount(Integer postReadCount) { this.postReadCount = postReadCount; }
    public boolean isPostNotice() { return postNotice; }
    public void setPostNotice(boolean postNotice) { this.postNotice = postNotice; }
}