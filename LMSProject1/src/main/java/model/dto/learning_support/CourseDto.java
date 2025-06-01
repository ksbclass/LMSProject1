package model.dto.learning_support;

public class CourseDto {
	private String courseId;
	private String deptId;
	private String professorId;
	private String professorName;
	private String courseName;
	private String creditCategory;// 전공필수여부
	private Integer courseScore;
	private String coursePlan;
	private Integer courseCurrentEnrollment;
	private Integer courseMaxCnt;
	private String timeSlot; // 시간
	
	

	// Getters and Setters
	public String getCourseId() {
		return courseId;
	}

	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getProfessorId() {
		return professorId;
	}

	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}

	public String getProfessorName() {
		return professorName;
	}

	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}

	public String getCourseName() {
		return courseName;
	}

	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}

	public String getCreditCategory() {
		return creditCategory;
	}

	public void setCreditCategory(String creditCategory) {
		this.creditCategory = creditCategory;
	}

	public Integer getCourseScore() {
		return courseScore;
	}

	public void setCourseScore(Integer courseScore) {
		this.courseScore = courseScore;
	}

	public String getCoursePlan() {
		return coursePlan;
	}

	public void setCoursePlan(String coursePlan) {
		this.coursePlan = coursePlan;
	}

	public String getTimeSlot() {
		return timeSlot;
	}

	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}

	public Integer getCourseCurrentEnrollment() {
		return courseCurrentEnrollment;
	}

	public void setCourseCurrentEnrollment(Integer courseCurrentEnrollment) {
		this.courseCurrentEnrollment = courseCurrentEnrollment;
	}

	public Integer getCourseMaxCnt() {
		return courseMaxCnt;
	}

	public void setCourseMaxCnt(Integer courseMaxCnt) {
		this.courseMaxCnt = courseMaxCnt;
	}

	@Override
	public String toString() {
		return "CourseDto [courseId=" + courseId + ", deptId=" + deptId + ", professorId=" + professorId
				+ ", professorName=" + professorName + ", courseName=" + courseName + ", creditCategory="
				+ creditCategory + ", courseScore=" + courseScore + ", coursePlan=" + coursePlan
				+ ", courseCurrentEnrollment=" + courseCurrentEnrollment + ", courseMaxCnt=" + courseMaxCnt
				+ ", timeSlot=" + timeSlot + "]";
	}

}