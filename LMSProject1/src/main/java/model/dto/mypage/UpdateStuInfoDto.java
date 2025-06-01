package model.dto.mypage;

public class UpdateStuInfoDto {
	private String studentId;
	private String studentEmail;
    private String studentPhone;
    private String studentImg;
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
	public String getStudentPhone() {
		return studentPhone;
	}
	public void setStudentPhone(String studentPhone) {
		this.studentPhone = studentPhone;
	}
	public String getStudentImg() {
		return studentImg;
	}
	public void setStudentImg(String studentImg) {
		this.studentImg = studentImg;
	}
	@Override
	public String toString() {
		return "UpdateStuInfoDto [studentId=" + studentId + ", studentEmail=" + studentEmail + ", studentPhone="
				+ studentPhone + ", studentImg=" + studentImg + "]";
	}
    
    

}
