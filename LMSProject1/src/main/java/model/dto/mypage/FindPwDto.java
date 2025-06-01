package model.dto.mypage;

public class FindPwDto {

	private String professorId;
	private String professorEmail;
	private String studentId;
	private String studentEmail;
	public String getProfessorId() {
		return professorId;
	}
	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}
	public String getProfessorEmail() {
		return professorEmail;
	}
	public void setProfessorEmail(String professorEmail) {
		this.professorEmail = professorEmail;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getStudentEmail() {
		return studentEmail;
	}
	public void setStudentEmail(String studentEmail) {
		this.studentEmail = studentEmail;
	}
	@Override
	public String toString() {
		return "FindPwDto [professorId=" + professorId + ", professorEmail=" + professorEmail + ", studentId="
				+ studentId + ", studentEmail=" + studentEmail + "]";
	}
	
	

}
