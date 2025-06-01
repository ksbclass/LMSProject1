package model.dto.mypage;

public class LoginDto {
	private String studentId;
    private String professorId;
   
    
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	
	public String getProfessorId() {
		return professorId;
	}
	public void setProfessorId(String professorId) {
		this.professorId = professorId;
	}
	@Override
	public String toString() {
		return "LoginDto [studentId=" + studentId + ", professorId=" + professorId + "]";
	}
	
	
	
	
    
    
}
