package model.dto.professor_support;

public class ScoreMngDto {
	
	private String studentId;
	private String studentName;
	private String studentNum;
	private String deptName;
	private String professorName;
	private String courseName;
	private String courseId;
	private String coursePeriod;
	private Integer courseCurrentEnrollment;
	private Integer scoreMid;
	private Integer scoreFinal;
	private Integer scoreTotal;
	private String scoreGrade;
	private String scoreEtc;
	
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	public String getStudentNum() {
		return studentNum;
	}
	public void setStudentNum(String studentNum) {
		this.studentNum = studentNum;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public Integer getCourseCurrentEnrollment() {
		return courseCurrentEnrollment;
	}
	public void setCourseCurrentEnrollment(Integer courseCurrentEnrollment) {
		this.courseCurrentEnrollment = courseCurrentEnrollment;
	}
	public Integer getScoreMid() {
		return scoreMid;
	}
	public void setScoreMid(Integer scoreMid) {
		this.scoreMid = scoreMid;
	}
	public Integer getScoreFinal() {
		return scoreFinal;
	}
	public void setScoreFinal(Integer scoreFinal) {
		this.scoreFinal = scoreFinal;
	}
	public Integer getScoreTotal() {
		return scoreTotal;
	}
	public void setScoreTotal(Integer scoreTotal) {
		this.scoreTotal = scoreTotal;
	}
	public String getScoreGrade() {
		return scoreGrade;
	}
	public void setScoreGrade(String scoreGrade) {
		this.scoreGrade = scoreGrade;
	}
	public String getScoreEtc() {
		return scoreEtc;
	}
	public void setScoreEtc(String scoreEtc) {
		this.scoreEtc = scoreEtc;
	}
	public String getCoursePeriod() {
		return coursePeriod;
	}
	public void setCoursePeriod(String coursePeriod) {
		this.coursePeriod = coursePeriod;
	}
	
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	
	@Override
	public String toString() {
		return "ScoreMngDto [studentId=" + studentId + ", studentName=" + studentName + ", studentNum=" + studentNum
				+ ", deptName=" + deptName + ", professorName=" + professorName + ", courseName=" + courseName
				+ ", courseId=" + courseId + ", coursePeriod=" + coursePeriod + ", courseCurrentEnrollment="
				+ courseCurrentEnrollment + ", scoreMid=" + scoreMid + ", scoreFinal=" + scoreFinal + ", scoreTotal="
				+ scoreTotal + ", scoreGrade=" + scoreGrade + ", scoreEtc=" + scoreEtc + "]";
	}
	
	
	
	
}
