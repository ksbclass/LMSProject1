package model.dto.mypage;

public class DeleteUserDto {
	private String studentId;
	private String deptId;
	private String studentName;
	private String studentStatus;
	
	public String getStudentStatus() {
		return studentStatus;
	}
	public void setStudentStatus(String studentStatus) {
		this.studentStatus = studentStatus;
	}
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getStudentName() {
		return studentName;
	}
	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}
	@Override
	public String toString() {
		return "DeleteUserDto [studentId=" + studentId + ", deptId=" + deptId + ", studentName=" + studentName
				+ ", studentStatus=" + studentStatus + "]";
	}
	
	
	
	
}
