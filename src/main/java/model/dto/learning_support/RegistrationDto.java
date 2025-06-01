package model.dto.learning_support;

public class RegistrationDto {
    private String registrationId;
    private String creditCategory;
    private String courseId;
    private String courseName;
    private Integer courseScore;
    private String professorName;
    private String courseTimeLoc;
    private String timeSlot;
    
    // Getters and Setters
	public String getRegistrationId() {
		return registrationId;
	}
	public void setRegistrationId(String registrationId) {
		this.registrationId = registrationId;
	}
	public String getCreditCategory() {
		return creditCategory;
	}
	public void setCreditCategory(String creditCategory) {
		this.creditCategory = creditCategory;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public Integer getCourseScore() {
		return courseScore;
	}
	public void setCourseScore(Integer courseScore) {
		this.courseScore = courseScore;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public String getCourseTimeLoc() {
		return courseTimeLoc;
	}
	public void setCourseTimeLoc(String courseTimeLoc) {
		this.courseTimeLoc = courseTimeLoc;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	
	@Override
	public String toString() {
		return "RegistrationDto [registrationId=" + registrationId + ", creditCategory=" + creditCategory
				+ ", courseId=" + courseId + ", courseName=" + courseName + ", courseScore=" + courseScore
				+ ", professorName=" + professorName + ", courseTimeLoc=" + courseTimeLoc + ", timeSlot=" + timeSlot
				+ "]";
	}

    
}