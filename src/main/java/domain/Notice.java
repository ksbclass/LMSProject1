package domain;

import java.util.Date;

public class Notice {
    private String noticeId; 
    private String noticePassword; 
    private String writerId; 
    private String writerName; 
    private String noticeTitle; 
    private String noticeContent;
    private Date noticeCreatedAt;
    private Date noticeUpdatedAt;
    private String noticeFile; 
    private Integer noticeReadCount; 

    // Getters and Setters
    public String getNoticePassword() {
        return noticePassword;
    }
    public void setNoticePassword(String noticePassword) {
        this.noticePassword = noticePassword;
    }
    public String getNoticeId() {
        return noticeId;
    }
    public void setNoticeId(String noticeId) {
        this.noticeId = noticeId;
    }
    public String getWriterId() {
        return writerId;
    }
    public void setWriterId(String writerId) {
        this.writerId = writerId;
    }
    public String getWriterName() { 
        return writerName;
    }
    public void setWriterName(String writerName) { 
        this.writerName = writerName;
    }
    public String getNoticeTitle() {
        return noticeTitle;
    }
    public void setNoticeTitle(String noticeTitle) {
        this.noticeTitle = noticeTitle;
    }
    public String getNoticeContent() {
        return noticeContent;
    }
    public void setNoticeContent(String noticeContent) {
        this.noticeContent = noticeContent;
    }
    public Date getNoticeCreatedAt() {
        return noticeCreatedAt;
    }
    public void setNoticeCreatedAt(Date noticeCreatedAt) {
        this.noticeCreatedAt = noticeCreatedAt;
    }
    public Date getNoticeUpdatedAt() {
        return noticeUpdatedAt;
    }
    public void setNoticeUpdatedAt(Date noticeUpdatedAt) {
        this.noticeUpdatedAt = noticeUpdatedAt;
    }
    public String getNoticeFile() {
        return noticeFile;
    }
    public void setNoticeFile(String noticeFile) {
        this.noticeFile = noticeFile;
    }
    public int getNoticeReadCount() {
        return noticeReadCount;
    }
    public void setNoticeReadCount(int noticeReadCount) {
        this.noticeReadCount = noticeReadCount;
    }

    @Override
    public String toString() {
        return "Notice [noticeId=" + noticeId + ", noticePassword=" + noticePassword + ", writerId=" + writerId
                + ", writerName=" + writerName + ", noticeTitle=" + noticeTitle + ", noticeContent=" + noticeContent
                + ", noticeCreatedAt=" + noticeCreatedAt + ", noticeUpdatedAt=" + noticeUpdatedAt + ", noticeFile="
                + noticeFile + ", noticeReadCount=" + noticeReadCount + "]";
    }
}