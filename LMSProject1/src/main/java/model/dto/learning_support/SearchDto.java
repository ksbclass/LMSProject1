package model.dto.learning_support;

public class SearchDto {
	private String college;
	private String deptId;
	private String courseId;
    private String courseName;
    private String studentId;
    
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
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
	
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	
	@Override
	public String toString() {
		return "SearchDto [college=" + college + ", deptId=" + deptId + ", courseId=" + courseId + ", courseName="
				+ courseName + ", studentId=" + studentId + "]";
	}
    
	
	    
    
}