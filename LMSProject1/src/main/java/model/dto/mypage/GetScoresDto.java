package model.dto.mypage;

public class GetScoresDto {
	private String courseId;
	private String courseName;
	private int courseScore;
	private String coursePeriod;
	private String studentId;
	private String professorName;
	
	private String scoreMid;
	private String scoreFinal;
	private String scoreTotal;
	private String scoreGrade;
	
	
	public String getCoursePeriod() {
		return coursePeriod;
	}
	public void setCoursePeriod(String coursePeriod) {
		this.coursePeriod = coursePeriod;
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
	public int getCourseScore() {
		return courseScore;
	}
	public void setCourseScore(int courseScore) {
		this.courseScore = courseScore;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public String getScoreMid() {
		return scoreMid;
	}
	public void setScoreMid(String scoreMid) {
		this.scoreMid = scoreMid;
	}
	public String getScoreFinal() {
		return scoreFinal;
	}
	public void setScoreFinal(String scoreFinal) {
		this.scoreFinal = scoreFinal;
	}
	public String getScoreTotal() {
		return scoreTotal;
	}
	public void setScoreTotal(String scoreTotal) {
		this.scoreTotal = scoreTotal;
	}
	public String getScoreGrade() {
		return scoreGrade;
	}
	public void setScoreGrade(String scoreGrade) {
		this.scoreGrade = scoreGrade;
	}
	@Override
	public String toString() {
		return "GetScoresDto [courseId=" + courseId + ", courseName=" + courseName + ", courseScore=" + courseScore
				+ ", coursePeriod=" + coursePeriod + ", studentId=" + studentId + ", professorName=" + professorName
				+ ", scoreMid=" + scoreMid + ", scoreFinal=" + scoreFinal + ", scoreTotal=" + scoreTotal
				+ ", scoreGrade=" + scoreGrade + "]";
	}


}
