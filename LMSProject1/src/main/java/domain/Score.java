package domain;

public class Score {
    private String studentId;
    private String scoreId;
    private String courseId;
    private String professorId;
    private String deptId;
    
    private String scoreMid;
    private String scoreFinal;
    private String scoreTotal;
    private String scoreGrade;
    private String scoreEtc;
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getScoreId() {
		return scoreId;
	}
	public void setScoreId(String scoreId) {
		this.scoreId = scoreId;
	}
	public String getCourseId() {
		return courseId;
	}
	public void setCourseId(String courseId) {
		this.courseId = courseId;
	}
	public String getProfessorId() {
		return professorId;
	}
	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
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
	public String getScoreEtc() {
		return scoreEtc;
	}
	public void setScoreEtc(String scoreEtc) {
		this.scoreEtc = scoreEtc;
	}
	@Override
	public String toString() {
		return "Score [studentId=" + studentId + ", scoreId=" + scoreId + ", courseId=" + courseId + ", professorId="
				+ professorId + ", deptId=" + deptId + ", scoreMid=" + scoreMid + ", scoreFinal=" + scoreFinal
				+ ", scoreTotal=" + scoreTotal + ", scoreGrade=" + scoreGrade + ", scoreEtc=" + scoreEtc + "]";
	}
    

   
}