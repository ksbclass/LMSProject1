package model.dto.mypage;

public class UpdateStuPwDto {
	private String studentId;
	private String studentPassword;
	private String studentNewPassword;
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getStudentPassword() {
		return studentPassword;
	}
	public void setStudentPassword(String studentPassword) {
		this.studentPassword = studentPassword;
	}
	public String getStudentNewPassword() {
		return studentNewPassword;
	}
	public void setStudentNewPassword(String studentNewPassword) {
		this.studentNewPassword = studentNewPassword;
	}
	
}
