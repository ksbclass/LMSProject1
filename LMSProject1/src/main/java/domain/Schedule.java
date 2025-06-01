package domain;

import java.util.Date;

public class Schedule {
    private int scheduleId; 
    private Date scheduleDate; 
    private String scheduleTitle;
    private String scheduleDescription; 

    public Schedule() {}

    public Schedule(int scheduleId, Date scheduleDate, String scheduleTitle, String scheduleDescription) {
        this.scheduleId = scheduleId;
        this.scheduleDate = scheduleDate;
        this.scheduleTitle = scheduleTitle;
        this.scheduleDescription = scheduleDescription;
    }

    // Getters and Setters
    public int getScheduleId() { return scheduleId; }
    public void setScheduleId(int scheduleId) { this.scheduleId = scheduleId; }
    public Date getScheduleDate() { return scheduleDate; }
    public void setScheduleDate(Date scheduleDate) { this.scheduleDate = scheduleDate; }
    public String getScheduleTitle() { return scheduleTitle; }
    public void setScheduleTitle(String scheduleTitle) { this.scheduleTitle = scheduleTitle; }
    public String getScheduleDescription() { return scheduleDescription; }
    public void setScheduleDescription(String scheduleDescription) { this.scheduleDescription = scheduleDescription; }
}